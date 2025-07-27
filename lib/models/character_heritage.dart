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

class CharacterHeritage {
  final String? id;
  final String name;
  final String description;
  final String? image;

  CharacterHeritage({
    required this.id,
    required this.name,
    required this.description,
    this.image,
  });

  factory CharacterHeritage.fromJson(Map<String, dynamic> json) {
    return CharacterHeritage(
      id: json['id'],
      name: json['name'],
      description: json['feature'],
      image: json['image'],
    );
  }
}
