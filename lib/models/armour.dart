//import 'package:flutter/cupertino.dart';

import 'package:daggerheart/utils/debug_utils.dart';

class ArmourModel {

  final int armourId;
  final String name;
  final int baseThreshold1;
  final int baseThreshold2;
  final int baseScore;
  final String feature;
  final int tier;
  final String? image;

  ArmourModel({
    required this.armourId,
    required this.name,
    required this.baseThreshold1,
    required this.baseThreshold2,
    required this.baseScore,
    required this.feature,
    required this.tier,
    this.image
  });

  static int _parseInt(dynamic value, {int fallback = 0}) {
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? fallback;
    return fallback;
  }

  factory ArmourModel.fromJson(Map<String, dynamic> json) {
    debugLog("ArmourModel: Parsing card JSON: $json");

    /*
      armourId INTEGER,
      armourName TEXT,
      armourFeature TEXT,
      armourBaseScore INTEGER,
      armourBaseThreshold1 INTEGER,
      armourBaseThreshold2 INTEGER,
      tier INTEGER,
      image TEXT,
    */
    return ArmourModel(
      armourId: _parseInt(json['id']),
      name: json['name'].toString(),
      baseThreshold1: _parseInt(json['base_threshold1']),
      baseThreshold2: _parseInt(json['base_threshold2']),
      baseScore: _parseInt(json['base_score']),
      feature: json['feature'] ?? '',
      tier: _parseInt(json['tier']),
      image: json['image'] ?? '',
    );
  }

  /*
  factory ArmourModel.fromDb(Map<String, dynamic> json) {
    debugLog("ArmourModel: Parsing card JSON: $json");

    int parseInt(dynamic value, {int fallback=0}) {
      if (value is int) return value;
      if (value is String) return int.tryParse(value) ?? fallback;
      return fallback;
    }

    /*
      armourId INTEGER,
      armourName TEXT,
      armourFeature TEXT,
      armourBaseScore INTEGER,
      armourBaseThreshold1 INTEGER,
      armourBaseThreshold2 INTEGER,
      tier INTEGER,
      image TEXT,
    */
    return ArmourModel(
      armourId: parseInt(json['armourId']),
      name: json['armourName'].toString(),
      baseThreshold1: parseInt(json['armourBaseThreshold1']),
      baseThreshold2: parseInt(json['armourBaseThreshold2']),
      baseScore: parseInt(json['armourBaseScore']),
      feature: json['armourFeature'] ?? '',
      tier: parseInt(json['tier']),
      image: json['image'] ?? '',
    );
  }

   */

  Map<String, dynamic> toDbMap() => {
    'armourId': armourId,
    'armourName': name,
    'armourBaseScore': baseScore,
    'armourBaseThreshold1': baseThreshold1,
    'armourBaseThreshold2': baseThreshold2,
    'armourFeature': feature,
    'image': image,
    'tier': tier,
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is ArmourModel &&
              runtimeType == other.runtimeType &&
              armourId == other.armourId;

  @override
  int get hashCode => armourId.hashCode;


}