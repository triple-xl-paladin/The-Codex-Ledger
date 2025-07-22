import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/domain_card.dart';  // adjust path if needed
import 'package:daggerheart/utils/debug_utils.dart';

Future<List<DomainCardModel>> loadCards({String jsonAssetPath = 'assets/cards.json'}) async {
  try {
    final jsonString = await rootBundle.loadString(jsonAssetPath);
    debugLog("CardService: Loaded $jsonAssetPath string successfully");

    final List<dynamic> jsonList = json.decode(jsonString);
    debugLog("CardService: Decoded $jsonAssetPath: ${jsonList.length} items found.");

    return jsonList.map((jsonItem) => DomainCardModel.fromJson(jsonItem)).toList();
  } catch (e) {
    debugLog("CardService: Failed to load or parse $jsonAssetPath: $e");
    return [];
  }
}

// NEW FUNCTION to group cards by domain
Map<String, List<DomainCardModel>> groupCardsByDomain(List<DomainCardModel> cards) {
  final Map<String, List<DomainCardModel>> domainMap = {};
  for (var card in cards) {
    final domain = card.domain;
    if (!domainMap.containsKey(domain)) {
      domainMap[domain] = [];
    }
    domainMap[domain]!.add(card);
  }
  return domainMap;
}