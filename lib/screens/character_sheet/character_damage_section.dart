import 'package:flutter/material.dart';

import 'package:daggerheart/extensions/iterable_extensions.dart';
//import 'package:daggerheart/utils/debug_utils.dart';

import 'package:daggerheart/models/character.dart';

class CharacterDamageSection extends StatefulWidget {
  final Character character;
  final Function(Character) onCharacterUpdated;

  const CharacterDamageSection({
    super.key,
    required this.character,
    required this.onCharacterUpdated,
  });

  @override
  State<CharacterDamageSection> createState() => _CharacterDamageSectionState();
}

class _CharacterDamageSectionState extends State<CharacterDamageSection> {
  late Character _character;

  @override
  void initState() {
    super.initState();
    _character = widget.character;
  }

  @override
  void didUpdateWidget(covariant CharacterDamageSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.character != oldWidget.character) {
      _character = widget.character;
    }
  }

  Widget _thresholdColumn(String label, String note, [int? value]) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              note,
              style: const TextStyle(
                fontSize: 12,
                fontStyle: FontStyle.italic,
                color: Colors.grey,
              ),
            ),
          ], //children
        ),
        if(value != null) ...[
          const SizedBox(width: 18),
          Text('<',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value.toString(),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 18),
        ], // if
      ], //children
    );
  }

  /// Main build for Character Class section
  @override
  Widget build(BuildContext context) {
    // Find equipped armour (or null if none)
    final equippedArmour = _character.armours.firstWhereOrNull((a) => a.equipped);
    // Get its score or default to 0 if none equipped
    final armourBaseThreshold1 = equippedArmour?.baseThreshold1 ?? 0;
    final armourBaseThreshold2 = equippedArmour?.baseThreshold2 ?? 0;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _thresholdColumn('Minor Damage', '(Mark 1 HP)', armourBaseThreshold1),
              _thresholdColumn('Major Damage', '(Mark 2 HP)', armourBaseThreshold2),
              _thresholdColumn('Severe Damage', '(Mark 3 HP)'),
            ], // 2nd row children
          ),
        ], // Column Children
      ),
    );
  }
}