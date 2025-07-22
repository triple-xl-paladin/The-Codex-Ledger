import 'dart:convert';
import 'package:daggerheart/models/weapon.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:daggerheart/utils/debug_utils.dart';

Future<List<WeaponModel>> loadWeapons({String jsonAssetPath = 'assets/weapons.json'}) async {
  try {
    final jsonString = await rootBundle.loadString(jsonAssetPath);
    debugLog("WeaponService: Loaded $jsonAssetPath string successfully");

    final List<dynamic> jsonList = json.decode(jsonString);
    debugLog("WeaponService: Decoded $jsonAssetPath: ${jsonList.length} items found.");

    return jsonList.map((jsonItem) => WeaponModel.fromJson(jsonItem)).toList();
  } catch (e) {
    debugLog("WeaponService: Failed to load or parse $jsonAssetPath: $e");
    return [];
  }
}

// NEW FUNCTION to group cards by tier
Map<int, List<WeaponModel>> groupCardsByTier(List<WeaponModel> weapons) {
  final Map<int, List<WeaponModel>> weaponMap = {};
  for (var weapon in weapons) {
    final tier = weapon.tier;
    if (!weaponMap.containsKey(tier)) {
      weaponMap[tier] = [];
    }
    weaponMap[tier]!.add(weapon);
  }
  return weaponMap;
}