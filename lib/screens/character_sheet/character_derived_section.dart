import 'package:daggerheart/providers/app_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:daggerheart/extensions/iterable_extensions.dart';
import 'package:daggerheart/utils/debug_utils.dart';
import 'package:daggerheart/models/character.dart';
import 'package:daggerheart/models/character_class.dart';
import 'package:provider/provider.dart';

class CharacterDerivedSection extends StatefulWidget {
  final Character character;
  final Function(Character) onCharacterUpdated;

  const CharacterDerivedSection({
    super.key,
    required this.character,
    required this.onCharacterUpdated,
  });

  @override
  State<CharacterDerivedSection> createState() => _CharacterDerivedSectionState();
}

class _CharacterDerivedSectionState extends State<CharacterDerivedSection> {
  final int _minLevel = 1; // Minimum level in Daggerheart
  final int _maxLevel = 10; // Maximum level in Daggerheart

  late Character _character;

  @override
  void initState() {
    super.initState();
    _character = widget.character;

    if(_character.characterLevel==null) {
      _character = _character.copyWith(characterLevel: 1);
    }
  }

  @override
  void didUpdateWidget(covariant CharacterDerivedSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.character != oldWidget.character) {
      _character = widget.character;
    }
  }

  /// Builds the character level and its interactive ability using +/- buttons
  /*
  Widget _buildLevelSelector() {
    // Hides the level box when no class has been selected instead of showing null
    //if (_character.characterLevel == null) return SizedBox.shrink(); // What does this do?
    final currentLevel = _character.characterLevel!;

    return Row(
        children: [
          Text('Level:'),

          //decrement button
          IconButton(
            icon: Icon(Icons.remove),
            onPressed: () {
              // Cannot be lower than 1
              if (currentLevel > _minLevel) {
                setState(() {
                  debugLog('CharacterClassSection: BEFORE copyWith: level=${_character.characterLevel}, deckSize=${_character.deck.length}');
                  final currentDeck = _character.deck;
                  _character = _character.copyWith(
                    characterLevel: currentLevel - 1,
                    deck: currentDeck,
                  );
                  debugLog('CharacterClassSection: Updated character level: ${_character.characterLevel} deck size: ${_character.deck.length}');
                });
                widget.onCharacterUpdated(_character);
              }
            },
          ),

          const SizedBox(width: 8,),
          Text('$currentLevel'),
          const SizedBox(width: 8,),

          // increment
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Cannot exceed [_maxLevel]
              if (currentLevel < _maxLevel) {
                setState(() {
                  final currentDeck = _character.deck;
                  debugLog('CharacterClassSection: BEFORE copyWith: level=${_character.characterLevel}, deckSize=${_character.deck.length}');
                  _character = _character.copyWith(
                    characterLevel: currentLevel + 1,
                    deck: currentDeck,
                  );
                  debugLog('CharacterClassSection: Updated character level: ${_character.characterLevel} deck size: ${_character.deck.length}');
                });
                widget.onCharacterUpdated(_character);
              }
            },
          ),
        ]
    );
  }
   */

  /// Dialog to show when a stat such as Evasion or Hit points needs to be changed
  Future<int?> _showStatAdjustDialog({
    required String label,
    required int initialValue,
    int min = 0,
    int max = 50,
  }) {
    TextEditingController controller = TextEditingController(text: initialValue.toString());
    int currentValue = initialValue;

    return showDialog<int>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Set $label'),
          content: StatefulBuilder(
            builder: (context, setState) {
              void updateValue(int newVal) {
                if (newVal < min) newVal = min;
                if (newVal > max) newVal = max;
                currentValue = newVal;
                controller.text = newVal.toString();
                setState(() {});
              }

              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: currentValue > min ? () => updateValue(currentValue - 1) : null,
                  ),
                  SizedBox(
                    width: 50,
                    child: TextField(
                      controller: controller,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      onChanged: (val) {
                        final parsed = int.tryParse(val);
                        if (parsed != null && parsed >= min && parsed <= max) {
                          currentValue = parsed;
                          setState(() {});
                        }
                      },
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: currentValue < max ? () => updateValue(currentValue + 1) : null,
                  ),
                ],
              );
            },
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
            TextButton(onPressed: () => Navigator.pop(context, currentValue), child: Text('OK')),
          ],
        );
      },
    );
  }

  /// Adjust a stat where the user has to tap on the number to open a dialog to
  /// change the number
  Widget _buildAdjustableStat({
    required String label,
    required int? currentValue,
    required int defaultValue,
    required void Function(int) onChanged,
    int min = 0,
    int max = 50,
    String? tooltipMsg,
  }) {
    final displayValue = currentValue ?? defaultValue;

    return GestureDetector(
      onTap: () async {
        final newValue = await _showStatAdjustDialog(
          label: label,
          initialValue: displayValue,
          min: min,
          max: max,
        );

        if (newValue != null && newValue != currentValue) {
          onChanged(newValue);
        }
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          tooltipMsg != null
            ? Tooltip(
              message: tooltipMsg,
              child: Text('$label: ',style: TextStyle(fontWeight: FontWeight.bold),),
            )
            : Text('$label: ', style: TextStyle(fontWeight: FontWeight.bold)),
          Text(displayValue.toString()),
          SizedBox(width: 4),
          Icon(Icons.edit, size: 16, color: Colors.grey),
        ],
      ),
    );
  }

  /// Main build for Character Class section
  @override
  Widget build(BuildContext context) {
    final appData = Provider.of<AppDataProvider>(context);
    final availableClasses = appData.classes;
    // Find equipped armour (or null if none)
    final equippedArmour = _character.armours.firstWhereOrNull((a) => a.equipped);
    // Get its score or default to 0 if none equipped
    final armourScore = equippedArmour?.baseScore ?? 0;

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
              //_buildLevelSelector(),
              //SizedBox(width: 16,),
              _buildAdjustableStat(
                  label: 'Level',
                  currentValue: _character.characterLevel,
                  defaultValue: 1,
                  min: _minLevel,
                  max: _maxLevel,
                  onChanged: (val) {
                    setState(() {
                      _character = _character.copyWith(characterLevel: val);
                    });
                  },
              ),
              SizedBox(width: 16,),
              _buildAdjustableStat(
                  label: 'Evasion',
                  currentValue: _character.characterEvasion,
                  defaultValue: selectedClass?.evasion ?? 0,
                  min:0,
                  max:20,
                  onChanged: (val) {
                    setState(() {
                      _character = _character.copyWith(characterEvasion: val);
                    });
                    debugLog('Updated evasion: $val, deck size: ${_character.deck.length}');
                    widget.onCharacterUpdated(_character);
                  }
              ),
              SizedBox(width: 16,),
              // Armour score
              Text('Armour Score: ', style: TextStyle(fontWeight: FontWeight.bold)),
              Text(armourScore.toString()),
              // Proficiency
              SizedBox(width: 16,),
              _buildAdjustableStat(
                  label: 'Proficiency',
                  currentValue: _character.totalProficiency,
                  defaultValue: 0,
                  tooltipMsg: 'Base: ${_character.baseProficiency}, Bonus: ${_character.bonusProficiency}',
                  onChanged: (newTotal) {
                    setState(() {
                      _character = _character.withUpdatedProficiency(newTotal);
                    });
                    widget.onCharacterUpdated(_character);
                  }
              ),
            ], // 1st row children
          ),
          Row(
            children: [
              _buildAdjustableStat(
                  label: 'Hit Points',
                  currentValue: _character.characterHitpoints,
                  defaultValue: selectedClass?.hitPoints ?? 0,
                  min:0,
                  max:20,
                  onChanged: (val) {
                    setState(() {
                      _character = _character.copyWith(characterHitpoints: val);
                    });
                    debugLog('Updated evasion: $val, deck size: ${_character.deck.length}');
                    widget.onCharacterUpdated(_character);
                  }
              ),
              // Stress
              SizedBox(width: 16,),
              _buildAdjustableStat(
                  label: 'Stress',
                  currentValue: _character.characterStress,
                  defaultValue: 6,
                  onChanged: (val) {
                    setState(() {
                      _character = _character.copyWith(characterStress: val);
                    });
                    widget.onCharacterUpdated(_character);
                  }
              ),
              // Hope
              SizedBox(width: 16,),
              _buildAdjustableStat(
                  label: 'Hope',
                  currentValue: _character.characterHope,
                  defaultValue: 2,
                  onChanged: (val) {
                    setState(() {
                      _character = _character.copyWith(characterHope: val);
                    });
                    widget.onCharacterUpdated(_character);
                  }
              ),
            ], //2nd row children
          ),
        ], // Column Children
      ),
    );
  }
}