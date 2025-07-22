// deck_section.dart
import 'package:daggerheart/models/items.dart';
import 'package:daggerheart/screens/character_sheet/dialogs/item_selection_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:daggerheart/models/character.dart';
import 'package:daggerheart/providers/app_data_provider.dart';
import 'package:daggerheart/utils/debug_utils.dart';
import 'package:provider/provider.dart';

class CharacterItemsSection extends StatefulWidget {
  final Character character;
  final ValueChanged<Character> onCharacterUpdated;

  const CharacterItemsSection({
    super.key,
    required this.character,
    required this.onCharacterUpdated,
  });

  @override
  State<CharacterItemsSection> createState() => _CharacterItemsSectionState();
}

class _CharacterItemsSectionState extends State<CharacterItemsSection> {
  Future<void> _handleItemSelection() async {
    final appData = Provider.of<AppDataProvider>(context, listen: false);
    final allItems = appData.items;

    if (!mounted) return;

    final selectedItems = await showDialog<List<ItemsModel>>(
      context: context,
      builder: (context) => Dialog(
        child: SizedBox(
          width: 600,
          height: 700,
          child: ItemSelectionDialog(
            availableItems: allItems,
            initiallySelected: widget.character.items,
          ),
        ),
      ),
    );

    if (selectedItems != null && selectedItems.isNotEmpty) {
      final updated = widget.character.copyWith(items: selectedItems);
      debugLog('CharacterItemSection: Updated items size: ${updated.weapons.length}');
      widget.onCharacterUpdated(updated);
    }
  }

  @override
  Widget build(BuildContext context) {
    final items = widget.character.items;
    final isDesktop = defaultTargetPlatform == TargetPlatform.macOS ||
        defaultTargetPlatform == TargetPlatform.windows ||
        defaultTargetPlatform == TargetPlatform.linux;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Items',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        isDesktop
            ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton.icon(
              onPressed: _handleItemSelection,
              icon: Icon(Icons.library_add),
              label: Text('Add Items'),
            ),
            const SizedBox(height: 8),
            ...items.map((items) => ListTile(
              title: Text(items.itemName),
              subtitle: Text('Type ${items.itemType}'),
            )),
          ],
        )
            : GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: _handleItemSelection,
          child: items.isEmpty
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
            itemCount: items.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final item = items[index];
              return ListTile(
                title: Text(item.itemName),
                subtitle: Text('Type ${item.itemType}'),
              );
            },
          ),
        ),
      ],
    );
  }
}
