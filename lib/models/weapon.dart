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