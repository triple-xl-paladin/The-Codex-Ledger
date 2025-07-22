import 'package:daggerheart/providers/theme_provider.dart';
import 'package:daggerheart/services/theme_loader_service.dart';
import 'package:daggerheart/theme/app_themes.dart';
import 'package:daggerheart/utils/debug_utils.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'package:daggerheart/providers/app_data_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform, TargetPlatform, kIsWeb;
import 'package:daggerheart/utils/scroll_behaviour.dart';
import 'package:logging/logging.dart';
import 'package:daggerheart/services/logging_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  LoggingService().setup(level: Level.ALL);
  final logger = LoggingService().getLogger('Main');
  logger.info('App starting');

  // For desktop platforms, use sqflite_common_ffi
  if (!kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.windows ||
          defaultTargetPlatform == TargetPlatform.linux ||
          defaultTargetPlatform == TargetPlatform.macOS)) {
    sqfliteFfiInit(); // Initializes FFI
    databaseFactory = databaseFactoryFfi; // Sets the global database factory
  }

  // Initialize Hive for desktop
  await Hive.initFlutter();

  // Open settings box
  final settingsBox = await Hive.openBox('settings');

  // Reset the theme on every startup when in debug mode
  await resetThemeOnStartup(settingsBox);

  // Load saved theme key (or use fallback)
  final allThemes = await ThemeLoader.loadThemesFromManifest();
  AppThemes.allThemes = allThemes;

  String? themeKey = settingsBox.get('selectedThemeKey');
  debugLog('Main/themeKey: $themeKey');
  
  // Retrieve saved theme key
  // final themeKey = settingsBox.get('selectedThemeKey', defaultValue: 'Light');

  // Get theme or fallback
  // final selectedTheme = allThemes[themeKey] ?? ThemeData.light();
  ThemeData selectedTheme;
  if(themeKey == null) {
    selectedTheme = ThemeData();
  } else {
    selectedTheme = await ThemeLoader.loadThemeByName(themeKey);
  }

  //final themeKey = settingsBox.get('selectedThemeKey', defaultValue: 'Dark Fantasy');
  //final selectedTheme = await ThemeRegistry.loadThemeByName(themeKey);
  //final selectedTheme = AppThemes.allThemes[themeKey] ?? AppThemes.darkFantasy;

  final appDataProvider = AppDataProvider(); //force creation & init
  final themeProvider = ThemeProvider(selectedTheme);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: appDataProvider),
        ChangeNotifierProvider.value(value: themeProvider),
      ],
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'Daggerheart',
      theme: themeProvider.themeData,
      home: HomeScreen(),
      scrollBehavior: const AlwaysVisibleScrollBehavior(),
    );
  }
}