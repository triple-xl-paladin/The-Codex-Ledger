// deck_section.dart
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:daggerheart/models/character.dart';
import 'package:daggerheart/models/weapon.dart';
import 'package:daggerheart/providers/app_data_provider.dart';
import 'package:daggerheart/screens/character_sheet/dialogs/weapon_selection_dialog.dart';
import 'package:daggerheart/utils/debug_utils.dart';
import 'package:daggerheart/utils/tier_lookup.dart';
import 'package:provider/provider.dart';
//import 'package:daggerheart/extensions/iterable_extensions.dart';

class CharacterWeaponsSection extends StatefulWidget {
  final Character character;
  final ValueChanged<Character> onCharacterUpdated;

  const CharacterWeaponsSection({
    super.key,
    required this.character,
    required this.onCharacterUpdated,
  });

  @override
  State<CharacterWeaponsSection> createState() => _CharacterWeaponsSectionState();
}

class _CharacterWeaponsSectionState extends State<CharacterWeaponsSection> {
  Future<void> _handleWeaponSelection() async {
    final appData = Provider.of<AppDataProvider>(context, listen: false);
    final allWeapons = appData.weapons;

    final characterLevel = widget.character.characterLevel;

    final weapons = allWeapons.where((weapon) {
      final weaponTier = weapon.tier;
      final allowedTier = levelToTier[characterLevel ?? 1] ?? 1;
      return weaponTier <= allowedTier;
    }).toList();

    if (!mounted) return;

    final selectedWeapons = await showDialog<List<WeaponModel>>(
      context: context,
      builder: (context) => Dialog(
        child: SizedBox(
          width: 600,
          height: 700,
          child: WeaponSelectionDialog(
            availableWeapons: weapons,
            initiallySelected: widget.character.weapons,
          ),
        ),
      ),
    );

    if (selectedWeapons != null && selectedWeapons.isNotEmpty) {
      final updated = widget.character.copyWith(weapons: selectedWeapons);
      debugLog('CharacterWeaponSection: Updated weapons size: ${updated.weapons.length}');
      widget.onCharacterUpdated(updated);
    }
  }

  @override
  Widget build(BuildContext context) {
    final weapons = widget.character.weapons;
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
              onPressed: _handleWeaponSelection,
              icon: Icon(Icons.library_add),
              label: Text('Add Weapons'),
            ),
            const SizedBox(height: 8),
            ...weapons.map((weapons) => ListTile(
              title: Text(weapons.name),
              subtitle: Text('${weapons.type} • Tier ${weapons.tier}'),
            )),
          ],
        )
            : GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: _handleWeaponSelection,
          child: weapons.isEmpty
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
            itemCount: weapons.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final weapon = weapons[index];
              return ListTile(
                title: Text(weapon.name),
                subtitle: Text('Type ${weapon.type} • Level ${weapon.tier}'),
              );
            },
          ),
        ),
      ],
    );
  }
}
