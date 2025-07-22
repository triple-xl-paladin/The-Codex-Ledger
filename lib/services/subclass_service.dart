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