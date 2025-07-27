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

import 'package:daggerheart/utils/debug_utils.dart';

/*
   {
        "id": 2,
        "name": "AANTARI BOW",
        "feature": "***Reliable:*** +1 to attack rolls",
        "type": "Primary Weapon",
        "tier": 4
    },
 */

class WeaponModel {

  final int id;
  final String name;
  final String feature;
  final String type;
  final int tier;
  final String? image;

  WeaponModel({
    required this.id,
    required this.name,
    required this.feature,
    required this.type,
    required this.tier,
    this.image
  });

  static int _parseInt(dynamic value, {int fallback = 0}) {
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? fallback;
    return fallback;
  }

  factory WeaponModel.fromJson(Map<String, dynamic> json) {
    debugLog("WeaponModel: Parsing card JSON: $json");

    return WeaponModel(
      id: _parseInt(json['id']),
      name: json['name'] ?? '',
      feature: json['feature'] ?? '',
      type: json['type'] ?? '',
      tier: _parseInt(json['tier']),
      image: json['image'],
    );
  }

  /*
  factory WeaponModel.fromDb(Map<String, dynamic> dbMap) {
    debugLog("WeaponModel: Parsing card JSON: $dbMap");

    return WeaponModel(
      id: _parseInt(dbMap['weaponId']),
      name: dbMap['weaponName'].toString(),
      feature: dbMap['weaponFeature'] ?? '',
      type: dbMap['weaponType'] ?? '',
      tier: _parseInt(dbMap['tier']),
      image: dbMap['image'] ?? '',
    );
  }
   */

  Map<String, dynamic> toDbMap() => {
    'weaponId': id,
    'weaponName': name,
    'weaponType': type,
    'weaponFeature': feature,
    'image': image,
    'tier': tier,
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is WeaponModel &&
              runtimeType == other.runtimeType &&
              id == other.id;

  @override
  int get hashCode => id.hashCode;

}