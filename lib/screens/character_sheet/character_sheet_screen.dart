import 'package:daggerheart/providers/app_data_provider.dart';
import 'package:daggerheart/screens/character_sheet/character_armour_section.dart';
import 'package:daggerheart/screens/character_sheet/character_damage_section.dart';
import 'package:daggerheart/screens/character_sheet/character_derived_section.dart';
import 'package:daggerheart/screens/character_sheet/character_items_section.dart';
import 'package:daggerheart/screens/character_sheet/character_weapons_section.dart';
import 'package:flutter/material.dart';

import 'package:daggerheart/screens/character_sheet/character_class_feature_section.dart';
import 'package:daggerheart/screens/character_sheet/character_class_section.dart';
import 'package:daggerheart/screens/character_sheet/character_attribute_section.dart';
import 'package:daggerheart/screens/character_sheet/character_domain_deck_section.dart';

import 'package:daggerheart/services/database_helper.dart';

import 'package:daggerheart/models/character.dart';
import 'package:provider/provider.dart';

import '../../utils/debug_utils.dart';

/// The Character Sheet screen shows the details of the character. The
/// constructor expects a Character object.
class CharacterSheetScreen extends StatefulWidget {
  //final Character character;
  final int characterId;

  /// Constructor expects a Character object
  const CharacterSheetScreen({
    super.key,
    required this.characterId,
  });

  @override
  State<CharacterSheetScreen> createState() => _CharacterSheetScreenState();
}

/// Private class that contains the layout and widgets for the character screen
class _CharacterSheetScreenState extends State<CharacterSheetScreen> {
  Character? _character;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCharacter(); // Loads character from DB
  }

  /// Loads character details from DB based on Character ID
  Future<void> _loadCharacter() async {
    // Get the AppDataProvider instance from the widget tree
    final appData = Provider.of<AppDataProvider>(context, listen: false);

    final character = await DatabaseHelper.instance.getCharacterById(widget.characterId, appData);
    if (!mounted) return;
    setState(() {
      _character = character;
      _isLoading = false;
    });
  }

  // Save a character to db method
  void _saveCharacter() async {
    if (_character == null) return;

    try {
      // Call your DatabaseHelper update method (assuming you have one)
      await DatabaseHelper.instance.updateCharacter(_character!);

      if (!mounted) return;  // <-- guard here

      // Show a simple confirmation/snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Character saved successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save character: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if(_isLoading) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(child: CircularProgressIndicator()),
      );
    }
    if (_character == null) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(child: Text('Character not found')),
      );
    }
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (bool didPop, dynamic result) {
        if(!didPop) return; // Don't save if the pop was cancelled
        _saveCharacter(); // Auto-save before exiting
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(_character!.name),
          actions: [
            IconButton(
              icon: Icon(Icons.save),
              onPressed: _saveCharacter,
              tooltip: 'Save changes',
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Text('Name: ${widget.character.name}'),
              //SizedBox(height: 8),
              // The section for Class, sub-class, ancestry and heritage are
              // handled in a separate custom widget CharacterClassSection
              CharacterClassSection(
                  character: _character!, // ✅ Force unwrap because we know it's non-null at this point
                  onCharacterUpdated: (updated) {
                    setState(() {
                      _character = updated;
                      debugLog('CharacterSheetScreen/CharacterClassSection: Parent updated character deck size: ${_character?.deck.length}');
                      debugLog('CharacterSheetScreen/CharacterClassSection: Parent updated character weapons size: ${_character?.weapons.length}');
                    });
                  }),
              SizedBox(height: 16),
              CharacterDerivedSection(
                  character: _character!,
                  onCharacterUpdated: (updated) {
                    setState(() {
                      _character = updated;
                    });
                  }
              ),
              SizedBox(height: 16),
              CharacterDamageSection(
                  character: _character!,
                  onCharacterUpdated: (updated) {
                    setState(() {
                      _character = updated;
                    });
                  }
              ),
              SizedBox(height: 16),
              Text(
                'Attributes',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 8),
              // Character Attributes
              AttributeSection(
                  attributes: _character!.attributes!,
                  onAttributesUpdated: (newAttributes) {
                    setState(() {
                      _character = _character!.copyWith(
                        attributes: newAttributes,
                      );
                      debugLog('CharacterSheetScreen/AttributeSection: Parent updated character deck size: ${_character?.deck.length}');
                      debugLog('CharacterSheetScreen/AttributeSection: Parent updated character weapons size: ${_character?.weapons.length}');
                    });
                  }
              ),
              SizedBox(height: 16),

              // Hope Features
              CharacterClassFeatureSection(
                  character: _character!,
                  ),
              SizedBox(height: 16),
              DomainDeckSection(
                  character: _character!,
                  onCharacterUpdated: (updated) {
                    setState(() {
                      _character = updated;
                      debugLog('CharacterSheetScreen/DomainDeckSection: Parent updated character deck size: ${_character?.deck.length}');
                      debugLog('CharacterSheetScreen/DomainDeckSection: Parent updated character weapons size: ${_character?.weapons.length}');
                    });
                  }
              ),
              // Weapons
              SizedBox(height: 8),
              CharacterWeaponsSection(
                  character: _character!,
                  onCharacterUpdated: (updated) {
                    setState(() {
                      _character = updated;
                      debugLog('CharacterSheetScreen/WeaponsSection: Parent updated character deck size: ${_character?.deck.length}');
                      debugLog('CharacterSheetScreen/WeaponsSection: Parent updated character weapons size: ${_character?.weapons.length}');
                    });
                  }),
              // Armour
              SizedBox(height: 8),
              CharacterArmourSection(
                  character: _character!,
                  onCharacterUpdated: (updated) {
                    setState(() {
                      _character = updated;
                      debugLog('CharacterSheetScreen/ArmourSection: Parent updated character deck size: ${_character?.deck.length}');
                      debugLog('CharacterSheetScreen/ArmourSection: Parent updated character weapons size: ${_character?.weapons.length}');
                      debugLog('CharacterSheetScreen/ArmourSection: Parent updated character armour size: ${_character?.armours.length}');
                    });
                  }),
              // Items
              SizedBox(height: 8),
              CharacterItemsSection(
                  character: _character!,
                  onCharacterUpdated: (updated) {
                    setState(() {
                      _character = updated;
                      debugLog('CharacterSheetScreen/ItemsSection: Parent updated character deck size: ${_character?.deck.length}');
                      debugLog('CharacterSheetScreen/ItemsSection: Parent updated character weapons size: ${_character?.weapons.length}');
                      debugLog('CharacterSheetScreen/ItemsSection: Parent updated character armour size: ${_character?.armours.length}');
                      debugLog('CharacterSheetScreen/ItemsSection: Parent updated character items size: ${_character?.items.length}');
                    });
                  }),
            ], // children
          ),
        ),
      ),
    );
  } // build
}