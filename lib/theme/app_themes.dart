// themes/app_themes.dart
import 'package:flutter/material.dart';

class AppThemes {

  static Map<String, ThemeData> allThemes = {
    'Dark Fantasy': ThemeData.light(),
  };

  /*
  static final darkFantasy = ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF3E2723),
    scaffoldBackgroundColor: const Color(0xFF121212),
    cardColor: const Color(0xFF1E1E1E),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF212121),
      foregroundColor: Colors.white,
      elevation: 4,
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: Color(0xFF1A1A1A),
    ),
    textTheme: TextTheme(
      bodyMedium: TextStyle(color: Colors.grey[300]),
      titleLarge: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
    iconTheme: const IconThemeData(color: Colors.tealAccent),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF6A1B9A),
      secondary: Color(0xFF00897B),
    ),
  );

  static final light = ThemeData.light();

  static Map<String, ThemeData> allThemes = {
    'Dark Fantasy': darkFantasy,
    'Light': light,
  };
  */
}
