import 'dart:async';
//import 'package:daggerheart/models/armour.dart';
//import 'package:daggerheart/models/items.dart';
//import 'package:daggerheart/models/weapon.dart';
import 'package:daggerheart/providers/app_data_provider.dart';
import 'package:daggerheart/utils/debug_utils.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/character.dart';
import '../models/domain_card.dart';
import 'dart:io';
//import 'package:flutter/foundation.dart';
import 'package:daggerheart/utils/other_utils.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('daggerheart.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    // Delete the existing database for clean start (development only!)
    /*
    bool resetDatabase = !kReleaseMode;
    final dbFile = File(path);
    if (await dbFile.exists()) {
      print('Deleting existing database at $path');
      await dbFile.delete();
    }
     */

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }


  /// Create the table to store characters from [Character]
  ///
  Future _createDB(Database db, int version) async {
    // Create Character table
    await db.execute('''
      CREATE TABLE characters (
        characterId INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT UNIQUE NOT NULL,
        characterLevel INTEGER,
        characterEvasion INTEGER,
        characterHitPoints INTEGER,
        characterClass TEXT,
        characterSubclass TEXT,
        characterAncestry TEXT,
        characterHeritage TEXT,
        characterAgility INTEGER,
        characterStrength INTEGER,
        characterFinesse INTEGER,
        characterInstinct INTEGER,
        characterPresence INTEGER,
        characterKnowledge INTEGER
      )
    ''');

    // Create Domain Card table
    await db.execute('''
      CREATE TABLE domain_cards (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        characterId INTEGER,
        level INTEGER,
        domain TEXT,
        name TEXT,
        type TEXT,
        recallCost INTEGER,
        feature TEXT,
        image TEXT,
        tier INTEGER,
        FOREIGN KEY(characterId) REFERENCES characters(characterId) ON DELETE CASCADE
      )
    ''');

    // Create Weapons table
    /*
      final int id;
      final String name;
      final String feature;
      final String type;
      final int tier;
      final String? image;
    */
    await db.execute('''
      CREATE TABLE weapons (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        characterId INTEGER,
        weaponId INTEGER,
        FOREIGN KEY(characterId) REFERENCES characters(characterId) ON DELETE CASCADE
      )
    ''');

    // Create Armour table
    /*
      final int armourId;
      final String name;
      final int baseThreshold1;
      final int baseThreshold2;
      final int baseScore;
      final String feature;
      final int tier;
      final String? image;
    */
    await db.execute('''
      CREATE TABLE armour (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        characterId INTEGER,
        armourId INTEGER,
        FOREIGN KEY(characterId) REFERENCES characters(characterId) ON DELETE CASCADE
      )
    ''');

    /// Create Items table
    /*
      final String itemName;
      final String? itemFeature;
      final String? itemType;
      final int itemId;
      final String? itemImage;
    */
    await db.execute('''
      CREATE TABLE items (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        characterId INTEGER,
        itemId INTEGER,
        FOREIGN KEY(characterId) REFERENCES characters(characterId) ON DELETE CASCADE
      )
    ''');

  }

  /// Helper to build the Map for Attributes enum
  Map<Attribute, int> _extractAttributes(Map<String, Object?> row) {
    return {
      for (var attr in Attribute.values)
        attr: row['character${_capitalize(attr.name)}'] as int? ?? 0,
    };
  }

  String _capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  // CRUD operations here...

  Future<int> insertCharacter(Character character) async {
    final db = await instance.database;
    final id = await db.insert('characters', {
      'name': character.name,
      'characterLevel': character.characterLevel,
      'characterEvasion': character.characterEvasion,
      'characterHitPoints': character.characterHitpoints,
      'characterClass': character.characterClass,
      'characterSubclass': character.characterSubclass,
      'characterAncestry': character.characterAncestry,
      'characterHeritage': character.characterHeritage,
      'characterAgility': character.attributes?[Attribute.agility] ?? 0,
      'characterStrength': character.attributes?[Attribute.strength] ?? 0,
      'characterFinesse': character.attributes?[Attribute.finesse] ?? 0,
      'characterInstinct': character.attributes?[Attribute.instinct] ?? 0,
      'characterPresence': character.attributes?[Attribute.presence] ?? 0,
      'characterKnowledge': character.attributes?[Attribute.knowledge] ?? 0,
    }, conflictAlgorithm: ConflictAlgorithm.abort);

    // Insert cards for the character
    for (final card in character.deck) {
      await db.insert('domain_cards', {
        'characterId': id,
        'level': card.level,
        'domain': card.domain,
        'name': card.name,
        'type': card.type,
        'recallCost': card.recallCost,
        'feature': card.feature,
        'image': card.image,
      });
    }

    // Insert weapons for the character
    /*
        characterId INTEGER,
        weaponId INTEGER,
   */
    for (final weapon in character.weapons) {
      await db.insert('weapons', {
        'characterId': id,
        'weaponId': weapon.id,
      });
    }

    // Insert armour for the character
    /*
        characterId INTEGER,
        armourId INTEGER,
   */
    for (final armour in character.armours) {
      await db.insert('armour', {
        'characterId': id,
        'armourId': armour.armourId,
      });
    }

    // Insert items for the character
    /*
        characterId INTEGER,
        itemId INTEGER,
   */
    for (final item in character.items) {
      await db.insert('items', {
        'characterId': id,
        'itemId': item.itemId,
      });
    }

    return id;
  }

  Future<List<Character>> getCharacters() async {
    final db = await instance.database;

    final characterRows = await db.query(
        'characters',
      columns: ['characterId', 'name'],
    );

    return characterRows.map((row) {
      return Character(
        characterId: row['characterId'] as int,
        name: row['name'] as String,
        deck: [],          // empty deck; no cards loaded here
        weapons: [],
        armours: [],
        items: [],
        attributes: {},    // empty or null if you prefer
      );
    }).toList();

  }

  Future<void> updateCharacter(Character character) async {
    if (character.characterId == null) {
      throw ArgumentError('Character ID must not be null when updating.');
    }

    final db = await instance.database;

    // Update character by ID
    await db.update('characters', {
      'name': character.name,
      'characterLevel': character.characterLevel,
      'characterEvasion': character.characterEvasion,
      'characterHitPoints': character.characterHitpoints,
      'characterClass': character.characterClass,
      'characterSubclass': character.characterSubclass,
      'characterAncestry': character.characterAncestry,
      'characterHeritage': character.characterHeritage,
      'characterAgility': character.attributes?[Attribute.agility] ?? 0,
      'characterStrength': character.attributes?[Attribute.strength] ?? 0,
      'characterFinesse': character.attributes?[Attribute.finesse] ?? 0,
      'characterInstinct': character.attributes?[Attribute.instinct] ?? 0,
      'characterPresence': character.attributes?[Attribute.presence] ?? 0,
      'characterKnowledge': character.attributes?[Attribute.knowledge] ?? 0,
    },
        where: 'characterId = ?', whereArgs: [character.characterId]);

    // Delete old cards for character
    await db.delete('domain_cards', where: 'characterId = ?', whereArgs: [character.characterId]);
    await db.delete('weapons', where: 'characterId = ?', whereArgs: [character.characterId]);
    await db.delete('armour', where: 'characterId = ?', whereArgs: [character.characterId]);
    await db.delete('items', where: 'characterId = ?', whereArgs: [character.characterId]);

    // Insert updated cards
    for (final card in character.deck) {
      await db.insert('domain_cards', {
        'characterId': character.characterId,
        'level': card.level,
        'domain': card.domain,
        'name': card.name,
        'type': card.type,
        'recallCost': card.recallCost,
        'feature': card.feature,
        'image': card.image,
      });
    }

    // Insert updated weapons
    /*
      characterId INTEGER,
      weaponId INTEGER,
      weaponName TEXT,
      weaponFeature TEXT,
      weaponType TEXT,
      tier INTEGER,
      image TEXT,
    */
    debugLog('DatabaseHelper: Weapons count ${character.weapons.length}');
    for (final weapon in character.weapons) {
      await db.insert('weapons', {
        'characterId': character.characterId,
        'weaponId': weapon.id,
      });
    }

    // Insert updated armour
    /*
        characterId INTEGER,
        armourId INTEGER,
        armourName TEXT,
        armourFeature TEXT,
        armourBaseScore INTEGER,
        armourBaseThreshold1 INTEGER,
        armourBaseThreshold2 INTEGER,
        tier INTEGER,
        image TEXT,
    */
    for (final armour in character.armours) {
      await db.insert('armour', {
        'characterId': character.characterId,
        'armourId': armour.armourId,
      });
    }

    // Insert updated items
    /*
        characterId INTEGER,
        itemId INTEGER,
        itemName TEXT,
        itemFeature TEXT,
        itemType TEXT,
        image TEXT,
    */
    for (final item in character.items) {
      await db.insert('items', {
        'characterId': character.characterId,
        'itemId': item.itemId,
      });
    }

  }

  Future<void> deleteCharacter(int characterId) async {
    final db = await instance.database;
    await db.delete('characters', where: 'characterId = ?', whereArgs: [characterId]);
    // Cards will be deleted due to ON DELETE CASCADE
  }

  Future<void> resetDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'daggerheart.db');

    // Delete the existing database for clean start
    final dbFile = File(path);

    if (await dbFile.exists()) {
      debugLog('Deleting existing database at $path');
      await dbFile.delete();
    }

    // Also clear the cached _database instance so it reopens fresh next time
    _database = null;
  }

  /// Get a character based on the characterId
  Future<Character?> getCharacterById(int id, AppDataProvider appData) async {
    final db = await instance.database;

    // Query db for character
    final charRows = await db.query(
      'characters',
      where: 'characterId = ?',
      whereArgs: [id],
    );

    // If no characters are in the db
    if (charRows.isEmpty) return null;

    // Returns the first row if the query returned multiple rows.
    // It shouldn't be possible to return more than 1 row unless the db
    // gets corrupted.
    final charRow = charRows.first;

    // Query db for a list of selected domain cards
    // db.query returns a map
    final cardsRows = await db.query(
      'domain_cards',
      where: 'characterId = ?',
      whereArgs: [id],
    );
    // converts map to a list of type DomainCardModel
    List<DomainCardModel> deck = cardsRows.map((c) => DomainCardModel.fromJson(c)).toList();

    // Query db for the selected weapons
    final weaponsRows = await db.query(
      'weapons',
      where: 'characterId = ?',
      whereArgs: [id],
    );

    final allWeapons = appData.weapons;

    final weapons = weaponsRows.map((row) => allWeapons.firstWhere((w) => w.id == parseInt(row['weaponId']))).toList();
    // converts map to a list of type WeaponModel
    //List<WeaponModel> weapons = weaponsRows.map((c) => WeaponModel.fromDb(c)).toList();

    // Query db for the selected armour
    final armourRows = await db.query(
      'armour',
      where: 'characterId = ?',
      whereArgs: [id],
    );

    final allArmour = appData.armours;
    final armours = armourRows.map((row) => allArmour.firstWhere((a) => a.armourId == parseInt(row['armourId']))).toList();

    // converts map to a list of type ArmourModel
    //List<ArmourModel> armour = armourRows.map((c) => ArmourModel.fromDb(c)).toList();

    // Query db for the selected items
    final itemsRows = await db.query(
      'items',
      where: 'characterId = ?',
      whereArgs: [id],
    );

    final allItems = appData.items;
    final items = itemsRows.map((row) => allItems.firstWhere((a) => a.itemId == parseInt(row['itemId']))).toList();
    // converts map to a list of type ItemsModel
    //List<ItemsModel> items = itemsRows.map((c) => ItemsModel.fromDb(c)).toList();

    final characterJson = {
      'characterId': parseInt(charRow['characterId'])!,
      'name': charRow['name'] as String,
      'characterClass': charRow['characterClass'] as String?,
      'characterLevel': charRow['characterLevel'] as int?,
      'characterEvasion': charRow['characterEvasion'] as int?,
      'characterHitpoints': charRow['characterHitPoints'] as int?,
      'characterSubclass': charRow['characterSubclass'] as String?,
      'characterAncestry': charRow['characterAncestry'] as String?,
      'characterHeritage': charRow['characterHeritage'] as String?,
      'deck': deck.map((card) => card.toJson()).toList(),
      'weapons':weapons.map((w) => w.id).toList(),
      'armours':armours.map((a) => a.armourId).toList(),
      'items': items.map((i) => i.itemId).toList(),
      'attributes': {
        for (var attr in Attribute.values)
          attr.name: charRow['character${_capitalize(attr.name)}'],
      }
    };

    return Character.fromJson(characterJson, allWeapons, allArmour, allItems);
    /*
    return Character(
      characterId: parseInt(charRow['characterId'])!,
      name: charRow['name'] as String,
      characterClass: charRow['characterClass'] as String?,
      characterLevel: charRow['characterLevel'] as int?,
      characterEvasion: charRow['characterEvasion'] as int?,
      characterHitpoints: charRow['characterHitPoints'] as int?,
      characterSubclass: charRow['characterSubclass'] as String?,
      characterAncestry: charRow['characterAncestry'] as String?,
      characterHeritage: charRow['characterHeritage'] as String?,
      deck: deck.map((card) => card.toJson()).toList(),
      weapons: weapons,
      armours: armours,
      items: items,
      attributes: _extractAttributes(charRow),
    );
     */
  }
}
