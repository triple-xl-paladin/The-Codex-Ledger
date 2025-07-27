/*
 * This file is part of The Codex Ledger.
 *
 * The Codex Ledger is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * The Codex Ledger is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with The Codex Ledger.  If not, see <https://www.gnu.org/licenses/>.
 */

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
