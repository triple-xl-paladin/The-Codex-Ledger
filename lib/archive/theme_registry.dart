/*
// lib/theme/theme_registry.dart

import 'package:flutter/material.dart';
import 'package:daggerheart/services/theme_loader_service.dart';

class ThemeRegistry {
  static final Map<String, String> _themePaths = {
    'Dark Fantasy': 'assets/themes/dark_fantasy.json',
    'Light Arcane': 'assets/themes/light_arcane.json',
    // Add more themes here
  };

  static Map<String, String> get themeNames => _themePaths;

  static Future<Map<String, ThemeData>> loadAllThemes() async {
    final Map<String, ThemeData> result = {};
    for (var entry in _themePaths.entries) {
      result[entry.key] = await ThemeLoader.loadThemeFromJson(entry.value);
    }
    return result;
  }

  static Future<ThemeData> loadThemeByName(String name) async {
    final path = _themePaths[name];
    if (path == null) throw Exception('Theme "$name" not found.');
    return ThemeLoader.loadThemeFromJson(path);
  }
}
*/