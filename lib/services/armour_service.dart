import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:daggerheart/models/armour.dart';  // adjust path if needed
//import 'package:daggerheart/models/domain_card.dart';
import 'package:daggerheart/utils/debug_utils.dart';

Future<List<ArmourModel>> loadArmours({String jsonAssetPath = 'assets/armour.json'}) async {
  try {
    final jsonString = await rootBundle.loadString(jsonAssetPath);
    debugLog("ArmourService: Loaded $jsonAssetPath string successfully");

    final List<dynamic> jsonList = json.decode(jsonString);
    debugLog("ArmourService: Decoded $jsonAssetPath: ${jsonList.length} items found.");

    return jsonList.map((jsonItem) => ArmourModel.fromJson(jsonItem)).toList();
  } catch (e) {
    debugLog("ArmourService: Failed to load or parse $jsonAssetPath: $e");
    return [];
  }
}

// NEW FUNCTION to group cards by tier
Map<int, List<ArmourModel>> groupCardsByTier(List<ArmourModel> armours) {
  final Map<int, List<ArmourModel>> armourMap = {};
  for (var armour in armours) {
    final tier = armour.tier;
    if (!armourMap.containsKey(tier)) {
      armourMap[tier] = [];
    }
    armourMap[tier]!.add(armour);
  }
  return armourMap;
}