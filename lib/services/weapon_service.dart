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