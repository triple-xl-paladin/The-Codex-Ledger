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

import 'package:daggerheart/utils/debug_utils.dart';
import 'package:flutter/material.dart';

import 'package:daggerheart/models/armour.dart';
import 'package:daggerheart/models/weapon.dart';
import 'package:daggerheart/models/character_ancestry.dart';
import 'package:daggerheart/models/character_heritage.dart';
import 'package:daggerheart/models/character_subclass.dart';
import 'package:daggerheart/models/character_class.dart';
import 'package:daggerheart/models/domain_card.dart';
import 'package:daggerheart/models/items.dart';

import 'package:daggerheart/services/heritage_service.dart';
import 'package:daggerheart/services/armour_service.dart';
import 'package:daggerheart/services/class_service.dart';
import 'package:daggerheart/services/card_service.dart';
import 'package:daggerheart/services/ancestry_service.dart';
import 'package:daggerheart/services/subclass_service.dart';
import 'package:daggerheart/services/weapon_service.dart';
import 'package:daggerheart/services/items_service.dart';

class AppDataProvider extends ChangeNotifier {
  List<CharacterClass> _classes = [];
  List<CharacterAncestry> _ancestries = [];
  List<CharacterSubclass> _subclasses =[];
  List<CharacterHeritage> _heritages = [];
  List<DomainCardModel> _cards = [];
  List<ArmourModel> _armours = [];
  List<WeaponModel> _weapons = [];
  List<ItemsModel> _items = [];
  bool _isLoading = true;
  String? _error;

  List<CharacterClass> get classes => _classes;
  List<CharacterAncestry> get ancestries => _ancestries;
  List<CharacterSubclass> get subclasses => _subclasses;
  List<CharacterHeritage> get heritages => _heritages;
  List<DomainCardModel> get domainCards => _cards;
  List<ArmourModel> get armours => _armours;
  List<WeaponModel> get weapons => _weapons;
  List<ItemsModel> get items => _items;
  bool get isLoading => _isLoading;
  String? get error => _error;

  /// Attempt to force load all json files on creation
  AppDataProvider() {
    debugLog("AppDataProvider: AppDataProvider created");
    loadAllData();
  }

  Future<void> loadAllData() async {
    debugLog("AppDataProvider: Starting to load data");

    if (!_isLoading && _armours.isNotEmpty) {
      debugLog("AppDataProvider: Data already loaded");
      return; // already loaded
    }

    try {
      _isLoading = true;
      notifyListeners();

      _classes = await loadClasses(jsonAssetPath: 'assets/classes.json');
      _cards = await loadCards(jsonAssetPath: 'assets/cards.json');
      _armours = await loadArmours(jsonAssetPath: 'assets/armour.json');
      _subclasses = await loadSubclasses(jsonAssetPath: 'assets/subclasses.json');
      _heritages = await loadHeritage(jsonAssetPath: 'assets/communities.json');
      _ancestries = await loadAncestry(jsonAssetPath: 'assets/ancestries.json');
      _weapons = await loadWeapons(jsonAssetPath: 'assets/weapons.json');
      _items = await loadItems(jsonAssetPath: 'assets/items.json');
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
