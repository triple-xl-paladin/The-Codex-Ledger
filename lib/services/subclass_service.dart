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
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:daggerheart/models/character_subclass.dart';

Future<List<CharacterSubclass>> loadSubclasses({String jsonAssetPath = 'assets/subclasses.json'}) async {
  try {
    final jsonString = await rootBundle.loadString(jsonAssetPath);
    if(kDebugMode) print("SubclassService: Loaded $jsonAssetPath string successfully");

    final List<dynamic> jsonList = json.decode(jsonString);
    if(kDebugMode) print("SubclassService: Decoded $jsonAssetPath: ${jsonList.length} items found.");

    /**
    for (var item in jsonList) {
      print("Subclass JSON item: $item");
    }
     */

    return jsonList.map((jsonItem) => CharacterSubclass.fromJson(jsonItem)).toList();
  } catch (e) {
    if(kDebugMode) print("SubclassService: Failed to load or parse $jsonAssetPath: $e");
    return [];
  }
}