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