import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:daggerheart/models/items.dart';  // adjust path if needed
import 'package:daggerheart/utils/debug_utils.dart';

Future<List<ItemsModel>> loadItems({String jsonAssetPath = 'assets/items.json'}) async {
  try {
    final jsonString = await rootBundle.loadString(jsonAssetPath);
    debugLog("ItemService: Loaded $jsonAssetPath string successfully");

    final List<dynamic> jsonList = json.decode(jsonString);
    debugLog("ItemService: Decoded $jsonAssetPath: ${jsonList.length} items found.");

    return jsonList.map((jsonItem) => ItemsModel.fromJson(jsonItem)).toList();
  } catch (e) {
    debugLog("ItemService: Failed to load or parse $jsonAssetPath: $e");
    return [];
  }
}