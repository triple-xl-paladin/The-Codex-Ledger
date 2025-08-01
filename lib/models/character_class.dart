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

class CharacterClass {
  final String id;
  final String name;
  final String description;
  final int evasion;
  final int hitPoints;
  final List<String> domainClasses;
  final List<String> classItems;
  final String hopeFeature;
  final List<String> classFeatures;
  final List<String> availableSubClasses;

  CharacterClass({
    required this.id,
    required this.name,
    required this.description,
    required this.evasion,
    required this.hitPoints,
    required this.domainClasses,
    required this.classItems,
    required this.hopeFeature,
    required this.classFeatures,
    required this.availableSubClasses,
  });

  factory CharacterClass.fromJson(Map<String, dynamic> json) {
    return CharacterClass(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      evasion: json['evasion'],
      hitPoints: json['hitPoints'],
      domainClasses: List<String>.from(json['domainClasses']),
      classItems: List<String>.from(json['classItems']),
      hopeFeature: json['hopeFeature'],
      classFeatures: List<String>.from(json['classFeatures']),
      availableSubClasses: List<String>.from(json['availableSubClasses']),
    );
  }
}
