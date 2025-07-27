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
