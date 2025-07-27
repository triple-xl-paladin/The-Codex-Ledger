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

class DomainCardModel {
  final int level;
  final String domain;
  final String name;
  final String type;
  final int recallCost;
  final String feature;
  final String image;
  final int id;
  final int tier;

  DomainCardModel({
    required this.level,
    required this.domain,
    required this.name,
    required this.type,
    required this.recallCost,
    required this.feature,
    required this.image,
    required this.id,
    required this.tier
  });

  factory DomainCardModel.fromJson(Map<String, dynamic> json) {
    //print("Parsing card JSON: $json");

    int parseInt(dynamic value, {int fallback=0}) {
      if (value is int) return value;
      if (value is String) return int.tryParse(value) ?? fallback;
      return fallback;
    }

    return DomainCardModel(
      level: parseInt(json['level']),
      domain: json['domain'] ?? '',
      name: json['name'] ?? '',
      type: json['type'] ?? '',
      recallCost: parseInt(json['recallCost']),
      feature: json['feature'] ?? '',
      image: json['image'] ?? '',
      id: parseInt(json['id']),
      tier: parseInt(json['tier']),
    );
  }

  Map<String, dynamic> toJson() => {
    'level': level,
    'domain': domain,
    'name': name,
    'type': type,
    'recallCost': recallCost,
    'feature': feature,
    'image': image,
    'id': id,
    'tier': tier,
  };

  /// Makes sure there are no duplicate cards being selected. Not sure how
  /// this works.
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is DomainCardModel &&
              runtimeType == other.runtimeType &&
              name == other.name &&
              domain == other.domain &&
              level == other.level;

  @override
  int get hashCode => name.hashCode ^ domain.hashCode ^ level.hashCode;

}
