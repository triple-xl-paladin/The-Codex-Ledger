import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

void debugLog(String message) {
  if (kDebugMode) {
    print('[DEBUG] $message');
  }
}

Future<void> resetThemeOnStartup(Box settingsBox) async {
  if (kDebugMode) {
    //var box = await Hive.openBox('themeBox');
    await settingsBox.clear();
    //await box.close();
  }
}
