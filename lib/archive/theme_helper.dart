/*
import 'package:daggerheart/utils/other_utils.dart';
import 'package:flutter/material.dart';

import '../utils/debug_utils.dart';

ThemeData parseThemeFromJson(Map<String, dynamic> json) {
  debugLog('scaffoldBackgroundColor key: ${json.containsKey('scaffoldBackgroundColor')}');
  debugLog('scaffoldBackgroundColor value: ${json['scaffoldBackgroundColor']}');

  return ThemeData(
    brightness: json['brightness'] == 'dark' ? Brightness.dark : Brightness.light,
    primaryColor: hexToColor(json['primaryColor']),
    scaffoldBackgroundColor: hexToColor(json['scaffoldBackgroundColor']),
    fontFamily: json['fontFamily'] ?? 'Roboto',
    // add more mappings as needed
  );
}

 */