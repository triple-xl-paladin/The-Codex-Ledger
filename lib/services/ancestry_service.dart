import 'dart:convert';
import 'package:daggerheart/utils/debug_utils.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../models/character_ancestry.dart';  // adjust path if needed

Future<List<CharacterAncestry>> loadAncestry({String jsonAssetPath = 'assets/ancestries.json'}) async {
  try {
    final jsonString = await rootBundle.loadString(jsonAssetPath);
    debugLog("AncestryService: Loaded $jsonAssetPath string successfully");

    final List<dynamic> jsonList = json.decode(jsonString);
    debugLog("AncestryService: Decoded $jsonAssetPath: ${jsonList.length} items found.");

    return jsonList.map((jsonItem) => CharacterAncestry.fromJson(jsonItem)).toList();
  } catch (e) {
    debugLog("AncestryService: Failed to load or parse $jsonAssetPath: $e");
    return [];
  }
}