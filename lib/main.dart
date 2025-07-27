import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'package:daggerheart/providers/app_data_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
//import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, TargetPlatform, kIsWeb;
import 'package:daggerheart/utils/scroll_behaviour.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // For desktop platforms, use sqflite_common_ffi
  if (!kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.windows ||
          defaultTargetPlatform == TargetPlatform.linux ||
          defaultTargetPlatform == TargetPlatform.macOS)) {
    sqfliteFfiInit(); // Initializes FFI
    databaseFactory = databaseFactoryFfi; // Sets the global database factory
  }

  final appDataProvider = AppDataProvider(); //force creation & init
  runApp(
    ChangeNotifierProvider.value(
      //create: (_) => AppDataProvider(),//..loadAllData(), // initialize your provider if needed
      value: appDataProvider,
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daggerheart',
      //theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        //colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //theme: ThemeData(primarySwatch: Colors.indigo),
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Color(0xFF3E2723), // Dark brown
        scaffoldBackgroundColor: Color(0xFF121212), // Very dark background
        cardColor: Color(0xFF1E1E1E),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF212121),
          foregroundColor: Colors.white,
          elevation: 4,
        ),
        drawerTheme: DrawerThemeData(
          backgroundColor: Color(0xFF1A1A1A),
        ),
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.grey[300]),
          titleLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: IconThemeData(color: Colors.tealAccent),
        colorScheme: ColorScheme.dark(
          primary: Color(0xFF6A1B9A), // Purple accent
          secondary: Color(0xFF00897B), // Teal accent
        ),
      ),
      home: HomeScreen(),
      scrollBehavior: const AlwaysVisibleScrollBehavior(),
    );
  }
}