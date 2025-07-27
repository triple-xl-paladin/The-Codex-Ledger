// deck_section.dart
import 'package:daggerheart/models/armour.dart';
import 'package:daggerheart/screens/character_sheet/dialogs/armour_selection_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:daggerheart/models/character.dart';
import 'package:daggerheart/providers/app_data_provider.dart';
import 'package:daggerheart/utils/debug_utils.dart';
import 'package:daggerheart/utils/tier_lookup.dart';
import 'package:provider/provider.dart';
//import 'package:daggerheart/extensions/iterable_extensions.dart';

class CharacterArmourSection extends StatefulWidget {
  final Character character;
  final ValueChanged<Character> onCharacterUpdated;

  const CharacterArmourSection({
    super.key,
    required this.character,
    required this.onCharacterUpdated,
  });

  @override
  State<CharacterArmourSection> createState() => _CharacterArmourSectionState();
}

class _CharacterArmourSectionState extends State<CharacterArmourSection> {
  Future<void> _handleArmourSelection() async {
    final appData = Provider.of<AppDataProvider>(context, listen: false);
    final allArmour = appData.armours;

    final characterLevel = widget.character.characterLevel;

    final armours = allArmour.where((armour) {
      final armourTier = armour.tier;
      final allowedTier = levelToTier[characterLevel ?? 1] ?? 1;
      return armourTier <= allowedTier;
    }).toList();

    if (!mounted) return;

    final selectedArmour = await showDialog<List<ArmourModel>>(
      context: context,
      builder: (context) => Dialog(
        child: SizedBox(
          width: 600,
          height: 700,
          child: ArmourSelectionDialog(
            availableArmour: armours,
            initiallySelected: widget.character.armours,
          ),
        ),
      ),
    );

    if (selectedArmour != null) {
      // Only if there is still an armour equipped
      if (selectedArmour.isNotEmpty) {
        // Ensure exactly one armour is equipped
        bool anyEquipped = selectedArmour.any((a) => a.equipped);
        if (!anyEquipped) {
          selectedArmour[0].equipped = true;
        }
      }

      final updated = widget.character.copyWith(armours: selectedArmour);
      debugLog('CharacterArmourSection: Updated armour size: ${updated.armours.length}');
      widget.onCharacterUpdated(updated);
    }
  }

  @override
  Widget build(BuildContext context) {
    final armours = widget.character.armours;
    final isDesktop = defaultTargetPlatform == TargetPlatform.macOS ||
        defaultTargetPlatform == TargetPlatform.windows ||
        defaultTargetPlatform == TargetPlatform.linux;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Armour',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        // Desktop view
        isDesktop
            ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton.icon(
              onPressed: _handleArmourSelection,
              icon: Icon(Icons.library_add),
              label: Text('Add Armour'),
            ),
            const SizedBox(height: 8),
            ...armours.map((armour) => RadioListTile<int?>(
              title: Text(armour.displayName),
              subtitle: Text('Base Score ${armour.baseScore} • Threshold ${armour.baseThreshold1}/${armour.baseThreshold2} • Tier ${armour.tier}'),
              value: armour.armourId,
              groupValue: armours.firstWhere((a) => a.equipped, orElse: () => armours.first).armourId,
              onChanged: (selectedId) {
                setState(() {
                  for (var a in armours) {
                    a.equipped = (a.armourId == selectedId);
                  }
                  final updatedCharacter = widget.character.copyWith(armours: armours);
                  widget.onCharacterUpdated(updatedCharacter);
                });
              },
            )),
          ],
        )
        // Mobile view
            : GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: _handleArmourSelection,
          child: armours.isEmpty
              ? Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Text(
                'Tap to add armour',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white70),
              ),
            ),
          )
              : ListView.builder(
            itemCount: armours.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final armour = armours[index];
              return RadioListTile<int?>(
                title: Text(armour.displayName),
                subtitle: Text('Base Score ${armour.baseScore} • Threshold ${armour.baseThreshold1}/${armour.baseThreshold2} • Tier ${armour.tier}'),
                value: armour.armourId,
                groupValue: armours.any((a) => a.equipped)
                  ? armours.firstWhere((a) => a.equipped).armourId
                  :null,
                onChanged: (selectedId) {
                  setState(() {
                    for (var a in armours) {
                      a.equipped = a.armourId == selectedId;
                    }
                    final updatedCharacter = widget.character.copyWith(armours: armours);
                    widget.onCharacterUpdated(updatedCharacter);
                  });
                }, // onChanged
              );
            }, // itemBuilder
          ),
        ),
      ], // children
    );
  } // build
}
