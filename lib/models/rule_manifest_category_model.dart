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

import 'rule_manifest_entry_model.dart';

class RuleManifestCategory {
  final String category;
  final List<RuleManifestEntry> entries;

  RuleManifestCategory({required this.category, required this.entries});

  factory RuleManifestCategory.fromJson(Map<String, dynamic> json) {
    return RuleManifestCategory(
      category: json['category'],
      entries: (json['entries'] as List<dynamic>)
          .map((e) => RuleManifestEntry.fromJson(e))
          .toList(),
    );
  }
}
