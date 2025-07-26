import 'dart:convert';
import 'package:daggerheart/services/logging_service.dart';
import 'package:daggerheart/utils/debug_utils.dart';
import 'package:flutter/services.dart';
import '../models/rule_manifest_category_model.dart';

class RulesManifestService {
  Future<List<RuleManifestCategory>> loadRulesManifest() async {
    final String manifestString;
    final String ruleManifestFile = 'assets/rules/rules_manifest.json';
    final List<dynamic> jsonList;

    try {
      manifestString = await rootBundle.loadString(ruleManifestFile);
      debugLog('RulesManifestService: file path $ruleManifestFile / manifestString $manifestString');
      jsonList = jsonDecode(manifestString);
      return jsonList
          .map((e) => RuleManifestCategory.fromJson(e))
          .toList();
    } catch (e,stack) {
      LoggingService().severe('Failed to load/decode $ruleManifestFile: $e/$stack');
      debugLog('RulesManifestService: Failed to load/decode $ruleManifestFile: $e/$stack');
      return [];
    }
  }
}
