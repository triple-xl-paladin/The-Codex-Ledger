import 'dart:convert';
import 'package:daggerheart/utils/debug_utils.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../models/character_class.dart';  // adjust path if needed

Future<List<CharacterClass>> loadClasses({String jsonAssetPath = 'assets/classes.json'}) async {
  try {
    final jsonString = await rootBundle.loadString(jsonAssetPath);
    debugLog("ClassService: Loaded $jsonAssetPath string successfully");

    final List<dynamic> jsonList = json.decode(jsonString);
    debugLog("ClassService: Decoded $jsonAssetPath: ${jsonList.length} items found.");

    return jsonList.map((jsonItem) => CharacterClass.fromJson(jsonItem)).toList();
  } catch (e) {
    debugLog("ClassService: Failed to load or parse $jsonAssetPath: $e");
    return [];
  }
}