import 'package:daggerheart/models/armour.dart';
import 'package:daggerheart/models/items.dart';
import 'package:daggerheart/models/weapon.dart';
import 'package:daggerheart/models/domain_card.dart';
import 'package:daggerheart/utils/debug_utils.dart';

enum Attribute {
  agility,
  strength,
  finesse,
  instinct,
  presence,
  knowledge,
}

class Character {
  final String name;
  final List<DomainCardModel> deck;
  final List<WeaponModel> weapons;
  final List<ArmourModel> armours;
  final List<ItemsModel> items;
  final int? characterId;  // nullable for new unsaved characters

  final int? characterLevel;
  final int? characterEvasion;
  final int? characterHitpoints;
  final String? characterClass;
  final String? characterSubclass;
  final String? characterAncestry;
  final String? characterHeritage;
  final Map<Attribute, int>? attributes;
  final int? characterStress;
  final int? characterHope;
  final int? characterProficiencyBonus;

  Character({
    required this.characterId,
    required this.name,
    required this.deck,
    required this.weapons,
    required this.armours,
    required this.items,
    this.characterLevel,
    this.characterEvasion,
    this.characterHitpoints,
    this.characterClass,
    this.characterSubclass,
    this.characterAncestry,
    this.characterHeritage,
    this.attributes,
    this.characterStress,
    this.characterHope,
    this.characterProficiencyBonus,
  });

  factory Character.newCharacter(String name) {
    return Character(
      characterId: null, // no id yet
      name: name,
      deck: [],
      weapons: [],
      armours: [],
      items: [],
      attributes: {
        for (var attr in Attribute.values) attr: 0,
      }
    );
  }

  // Makes a copy of the Character class.
  Character copyWith({
    int? characterId,
    String? name,
    List<DomainCardModel>? deck,
    List<WeaponModel>? weapons,
    List<ArmourModel>? armours,
    List<ItemsModel>? items,
    int? characterLevel,
    int? characterEvasion,
    int? characterHitpoints,
    int? characterStress,
    int? characterHope,
    int? characterProficiencyBonus,
    String? characterClass,
    String? characterSubclass,
    String? characterAncestry,
    String? characterHeritage,
    Map<Attribute, int>? attributes,
  }) {
    return Character(
      characterId: characterId ?? this.characterId,
      name: name ?? this.name,
      deck: deck ?? this.deck,
      weapons: weapons ?? this.weapons,
      armours: armours ?? this.armours,
      items: items ?? this.items,
      characterLevel: characterLevel ?? this.characterLevel,
      characterEvasion: characterEvasion ?? this.characterEvasion,
      characterHitpoints: characterHitpoints ?? this.characterHitpoints,
      characterStress: characterStress ?? this.characterStress,
      characterProficiencyBonus: characterProficiencyBonus ?? this.characterProficiencyBonus,
      characterHope: characterHope ?? this.characterHope,
      characterClass: characterClass ?? this.characterClass,
      characterSubclass: characterSubclass ?? this.characterSubclass,
      characterAncestry: characterAncestry ?? this.characterAncestry,
      characterHeritage: characterHeritage ?? this.characterHeritage,
      attributes: attributes ?? this.attributes,
    );
  }

  void addCard(DomainCardModel card) {
    deck.add(card);
  }

  void removeCard(DomainCardModel card) {
    deck.remove(card);
  }

  void addWeapon(WeaponModel weapon) {
    weapons.add(weapon);
  }

  void removeWeapon(WeaponModel weapon) {
    weapons.remove(weapon);
  }

  void addArmour(ArmourModel armour) {
    armours.add(armour);
  }

  void removeArmour(ArmourModel armour) {
    armours.remove(armour);
  }

  void addItem(ItemsModel item) {
    items.add(item);
  }

  void removeItem(ItemsModel item) {
    items.remove(item);
  }

  /// Set missing attributes to the default value of 0
  Character withAttributeDefaults() {
    final filledAttributes = {
      for (var attr in Attribute.values)
        attr: attributes?[attr] ?? 0,
    };

    return copyWith(attributes: filledAttributes);
  }

  Map<String, dynamic> toJson() => {
    'id': characterId,
    'name': name,
    'deck': deck.map((card) => card.toJson()).toList(),
    'weapons': weapons.map((weapon) => weapon.id).toList(),
    'armours': armours.map((armour) => armour.armourId).toList(),
    'items': items.map((item) => item.itemId).toList(),
    'characterLevel': characterLevel,
    'characterEvasion': characterEvasion,
    'characterHitpoints': characterHitpoints,
    'characterHope': characterHope,
    'characterStress': characterStress,
    'characterProficiencyBonus': characterProficiencyBonus,
    'characterClass': characterClass,
    'characterSubclass': characterSubclass,
    'characterAncestry': characterAncestry,
    'characterHeritage': characterHeritage,
    'attributes': attributes?.map((key, value) => MapEntry(key.name, value)),
  };

  /// Base proficiency based on character level
  int get baseProficiency {
     final level = characterLevel ?? 1;
     if (level >= 8) return 3;
     if (level >= 5) return 2;
     return 1;
  }

  /// Total proficiency (editable by user, defaults to base)
  int get totalProficiency {
    return baseProficiency + (characterProficiencyBonus ?? 0);
  }

  /// Bonus is the difference between total and base
  int get bonusProficiency {
    final total = totalProficiency;
    final base = baseProficiency;
    return (total > base) ? total - base : 0;
  }

  /// Used when the user edits total proficiency directly in UI
  /// Only ever stores the bonus, not the base proficiency value
  Character withUpdatedProficiency(int newTotal) {
    final bonus = newTotal - baseProficiency; // determine the bonus element
    return copyWith(characterProficiencyBonus: bonus > 0 ? bonus : 0);
  }

  factory Character.fromJson(
      Map<String, dynamic> json,
      List<WeaponModel> allWeapons,
      List<ArmourModel> allArmour,
      List<ItemsModel> allItems,
      ) {


    final attributesMap = (json['attributes'] as Map<String, dynamic>?)?.map(
      (key, value) => MapEntry(
          Attribute.values.firstWhere((e) => e.name == key),
        value as int,
      ),
    );

    final character = Character(
      characterId: json['characterId'],
      name: json['name'],
      deck: (json['deck'] as List<dynamic>? ?? [])
          .map((item) => DomainCardModel.fromJson(item))
          .toList(),

      //weapons: (json['weapons'] as List<dynamic>? ?? [])
      //  .map((id) => allWeapons.firstWhere((w) => w.id == id))
      //  .toList(),
      weapons: (json['weapons'] as List<dynamic>? ?? []).map((entry) {
        debugLog('Character.fromJson: raw weapon entry = $entry');

        // Check if the entry is just an ID (int or string)
        final weaponId = (entry is int)
            ? entry
            : (entry is String)
            ? int.tryParse(entry)
            : (entry is Map && entry.containsKey('weaponId'))
            ? entry['weaponId']
            : null;

        if (weaponId == null) {
          debugLog('❌ Invalid weaponId entry: $entry');
          return null; // Or throw or skip
        }

        final match = allWeapons.where((w) => w.id == weaponId);
        if (match.isEmpty) {
          debugLog('No matching weapon for id $weaponId in: ${allWeapons.map((a) => a.id)}');
          return null; // Or throw or a fallback
        }

        return match.first;
      }).whereType<WeaponModel>().toList(),


      armours: (json['armours'] as List<dynamic>? ?? [])
        .map((data) {
          final id = data['id'];
          final base = allArmour.firstWhere(
              (w) => w.armourId == id,
            orElse: () => throw Exception('Armour ID $id not found in allArmour'),
          );
            return base.copyWith(equipped: data['equipped'] == true);
        }).toList(),
      items: (json['items'] as List<dynamic>? ?? [])
        .map((id) => allItems.firstWhere((w) => w.itemId == id))
        .toList(),
      characterLevel: json['characterLevel'],
      characterEvasion: json['characterEvasion'],
      characterHitpoints: json['characterHitpoints'],
      characterHope: json['characterHope'],
      characterStress: json['characterStress'],
      characterProficiencyBonus: json['characterProficiencyBonus'],
      characterClass: json['characterClass'],
      characterSubclass: json['characterSubclass'],
      characterAncestry: json['characterAncestry'],
      characterHeritage: json['characterHeritage'],
      attributes: attributesMap,
    );

    return character.withAttributeDefaults();
  }
}
