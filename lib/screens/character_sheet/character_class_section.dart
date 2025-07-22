import 'package:daggerheart/models/character_heritage.dart';
import 'package:daggerheart/providers/app_data_provider.dart';
import 'package:daggerheart/screens/character_sheet/dialogs/heritage_picker_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:daggerheart/extensions/iterable_extensions.dart';
import 'package:daggerheart/utils/debug_utils.dart';

import 'package:daggerheart/models/character.dart';
import 'package:daggerheart/models/character_class.dart';
import 'package:daggerheart/models/character_subclass.dart';
import 'package:daggerheart/models/character_ancestry.dart';

//import 'package:daggerheart/services/class_service.dart';
//import 'package:daggerheart/services/subclass_service.dart';
//import 'package:daggerheart/services/ancestry_service.dart';
//import 'package:daggerheart/services/heritage_service.dart';

//import 'package:daggerheart/screens/subclass_picker_screen.dart';

import 'package:daggerheart/screens/character_sheet/dialogs/subclass_picker_dialog.dart';
import 'package:daggerheart/screens/character_sheet/dialogs/class_picker_dialog.dart';
import 'package:daggerheart/screens/character_sheet/dialogs/ancestry_picker_dialog.dart';
import 'package:provider/provider.dart';


class CharacterClassSection extends StatefulWidget {
  final Character character;
  final Function(Character) onCharacterUpdated;

  const CharacterClassSection({
    super.key,
    required this.character,
    required this.onCharacterUpdated,
  });

  @override
  State<CharacterClassSection> createState() => _CharacterClassSectionState();
}

class _CharacterClassSectionState extends State<CharacterClassSection> {
  late Character _character;

  @override
  void initState() {
    super.initState();
    _character = widget.character;
  }

  @override
  void didUpdateWidget(covariant CharacterClassSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.character != oldWidget.character) {
      _character = widget.character;
    }
  }

  /// Widget for select class which opens a dialog window [ClassPickerDialog] widget
  /// Called from the onTap in [_buildClassSelector]
  void _selectClass(List<CharacterClass> availableClasses) async {
    final selected = await showDialog<CharacterClass>(
      context: context,
      builder: (context) => ClassPickerDialog(
        availableClasses: availableClasses,
        selectedClass: availableClasses.firstWhereOrNull(
            (cls) => cls.name == _character.characterClass,
        ),
      ),
    );

    // Updates the UI
    if (selected != null) {
      setState(() {
        _character = _character.copyWith(
          characterClass: selected.name,
          characterLevel: 1,
          characterSubclass: null,
        );
      });
      widget.onCharacterUpdated(_character);
    }
  }

  /// Widget for select ancestry which opens a dialog window [AncestryPickerDialog] widget
  /// Called from the onTap in [_buildAncestrySelector]
  void _selectAncestry(List<CharacterAncestry> availableAncestry) async {
    final selected = await showDialog<CharacterAncestry>(
      context: context,
      builder: (context) => AncestryPickerDialog(
        availableAncestry: availableAncestry,
        selectedAncestry: availableAncestry.firstWhereOrNull(
              (cls) => cls.name == _character.characterAncestry,
        ),
      ),
    );

    // Updates the UI
    if (selected != null) {
      setState(() {
        _character = _character.copyWith(
          characterAncestry: selected.name,
        );
      });
      widget.onCharacterUpdated(_character);
    }
  }

  /// Widget for select heritage which opens a dialog window [HeritagePickerDialog] widget
  /// Called from the onTap in [_buildHeritageSelector]
  void _selectHeritage(List<CharacterHeritage> availableHeritage) async {
    final selected = await showDialog<CharacterHeritage>(
      context: context,
      builder: (context) => HeritagePickerDialog(
        availableHeritage: availableHeritage,
        selectedHeritage: availableHeritage.firstWhereOrNull(
              (cls) => cls.name == _character.characterHeritage,
        ),
      ),
    );

    // Updates the UI
    if (selected != null) {
      setState(() {
        _character = _character.copyWith(
          characterHeritage: selected.name,
        );
      });
      widget.onCharacterUpdated(_character);
    }
  }

  /// Builds the Class selection widget
  ///
  /// The onTap calls [_selectClass]
  Widget _buildClassSelector(CharacterClass? selectedClass, List<CharacterClass> availableClasses) {
    return Expanded(
      child: Row(
        children: [
          Text('Class: ', style: Theme.of(context).textTheme.titleMedium),
          GestureDetector(
            onTap: () => _selectClass(availableClasses),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade700,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                _character.characterClass ?? 'Select Class',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build the sub-class selector
  ///
  /// Calls the [SubclassPickerDialog] widget for the actual dialog to pick a sub-class
  Widget _buildSubclassSelector(CharacterClass? selectedClass, List<CharacterSubclass> subclassDetails) {
    if (selectedClass == null || selectedClass.availableSubClasses.isEmpty) {
      return Expanded(
        child: Text('No subclasses available for ${selectedClass?.name ?? 'selected class'}'),
      );
    }

    return Expanded(
      child: Row(
        children: [
          Text('Subclass: ', style: Theme.of(context).textTheme.titleMedium),
          GestureDetector(
            onTap: () async {
              final selected = await showDialog<String>(
                context: context,
                builder: (_) => SubclassPickerDialog(
                  selectedClass: selectedClass,
                  subclassDetails: subclassDetails,
                ),
              );

              // Updates the UI
              if (selected != null) {
                setState(() {
                  _character = _character.copyWith(characterSubclass: selected);
                });
                widget.onCharacterUpdated(_character);
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade700,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _character.characterSubclass ?? 'Select Subclass',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  if (_character.characterSubclass != null && kDebugMode)
                    Text(
                      'Subclass selected',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the Ancestry selection widget
  ///
  /// The onTap calls [_selectAncestry]
  Widget _buildAncestrySelector(List<CharacterAncestry> availableAncestry) {
    return Expanded(
      child: Row(
        children: [
          Text('Ancestry: ', style: Theme.of(context).textTheme.titleMedium),
          GestureDetector(
            onTap: () => _selectAncestry(availableAncestry),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade700,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                _character.characterAncestry ?? 'Select Ancestry',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the Ancestry selection widget
  ///
  /// The onTap calls [_selectHeritage]
  Widget _buildHeritageSelector(List<CharacterHeritage> availableHeritage) {
    return Expanded(
      child: Row(
        children: [
          Text('Heritage: ', style: Theme.of(context).textTheme.titleMedium),
          GestureDetector(
            onTap: () => _selectHeritage(availableHeritage),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade700,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                _character.characterHeritage ?? 'Select Heritage',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Main build for Character Class section
  @override
  Widget build(BuildContext context) {
    final appData = Provider.of<AppDataProvider>(context);
    final availableClasses = appData.classes;
    final subclassDetails = appData.subclasses; // To hold the details for each sub class
    final availableAncestry = appData.ancestries;
    final availableHeritage = appData.heritages;

    CharacterClass? selectedClass;
    try {
        selectedClass = availableClasses.firstWhereOrNull(
            (cls) => cls.name == _character.characterClass,
      );
    } catch (e) {
      selectedClass = null;
      debugLog('Error in character class select build: $e');
    }

    return SingleChildScrollView(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _buildClassSelector(selectedClass,availableClasses),
                SizedBox(width: 16,),
                _buildSubclassSelector(selectedClass, subclassDetails),
                SizedBox(width: 16,),
                _buildAncestrySelector(availableAncestry), // Ancestry Selector
                SizedBox(width: 16,),
                _buildHeritageSelector(availableHeritage), // Heritage Selector
              ],
            ),
          ], // Column Children
      ),
    );
  }
}