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

import '../utils/debug_utils.dart';
import 'package:daggerheart/utils/other_utils.dart';

class ItemsModel {
  final String itemName;
  final String? itemFeature;
  final String? itemType;
  final int itemId;
  final String? itemImage;

  ItemsModel({
    required this.itemId,
    required this.itemName,
    this.itemFeature,
    this.itemType,
    this.itemImage,
  });

  factory ItemsModel.fromJson(Map<String, dynamic> json) {
    debugLog("ItemsModel: Parsing card JSON: $json");
    /*
        characterId INTEGER,
        itemId INTEGER,
        itemName TEXT,
        itemFeature TEXT,
        itemType TEXT,
        image TEXT,
    */
    return ItemsModel(
      itemId: parseInt(json['id']),
      itemName: json['name'].toString(),
      itemFeature: json['feature'] ?? '',
      itemType: json['type'] ?? '',
      itemImage: json['image'] ?? '',
    );
  }

  /*
  factory ItemsModel.fromDb(Map<String, dynamic> json) {
    debugLog("ItemsModel: Parsing card JSON: $json");

    int parseInt(dynamic value, {int fallback=0}) {
      if (value is int) return value;
      if (value is String) return int.tryParse(value) ?? fallback;
      return fallback;
    }

    /*
        characterId INTEGER,
        itemId INTEGER,
        itemName TEXT,
        itemFeature TEXT,
        itemType TEXT,
        image TEXT,
    */
    return ItemsModel(
      itemId: parseInt(json['itemId']),
      itemName: json['itemName'].toString(),
      itemFeature: json['itemFeature'] ?? '',
      itemType: json['itemType'] ?? '',
      itemImage: json['image'] ?? '',
    );
  }
   */

  Map<String, dynamic> toDbMap() => {
    'itemId': itemId,
    'itemName': itemName,
    'armourFeature': itemFeature,
    'image': itemImage,
    'itemType': itemType,
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is ItemsModel &&
              runtimeType == other.runtimeType &&
              itemId == other.itemId;

  @override
  int get hashCode => itemId.hashCode;

}