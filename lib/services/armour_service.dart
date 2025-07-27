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

import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:daggerheart/models/armour.dart';  // adjust path if needed
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