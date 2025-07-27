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
      final weaponTier = armour.tier;
      final allowedTier = levelToTier[characterLevel ?? 1] ?? 1;
      return weaponTier <= allowedTier;
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

    if (selectedArmour != null && selectedArmour.isNotEmpty) {
      final updated = widget.character.copyWith(armours: selectedArmour);
      debugLog('CharacterArmourSection: Updated armour size: ${updated.weapons.length}');
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
          'Weapons',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
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
            ...armours.map((armours) => ListTile(
              title: Text(armours.name),
              subtitle: Text('Base Score ${armours.baseScore} • Threshold ${armours.baseThreshold1}/${armours.baseThreshold2} • Tier ${armours.tier}'),
            )),
          ],
        )
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
                'No domain cards in deck\nTap to add cards',
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
              return ListTile(
                title: Text(armour.name),
                subtitle: Text('Base Score ${armour.baseScore} • Threshold ${armour.baseThreshold1}/${armour.baseThreshold2} • Tier ${armour.tier}'),
              );
            },
          ),
        ),
      ],
    );
  }
}
