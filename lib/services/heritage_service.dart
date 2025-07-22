import 'dart:convert';
import 'package:daggerheart/utils/debug_utils.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../models/character_heritage.dart';  // adjust path if needed

Future<List<CharacterHeritage>> loadHeritage({String jsonAssetPath = 'assets/communities.json'}) async {
  try {
    final jsonString = await rootBundle.loadString(jsonAssetPath);
    debugLog("HeritageService: Loaded $jsonAssetPath string successfully");

    final List<dynamic> jsonList = json.decode(jsonString);
    debugLog("HeritageService: Decoded $jsonAssetPath: ${jsonList.length} items found.");

    return jsonList.map((jsonItem) => CharacterHeritage.fromJson(jsonItem)).toList();
  } catch (e) {
    debugLog("HeritageService: Failed to load or parse $jsonAssetPath: $e");
    return [];
  }
}