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