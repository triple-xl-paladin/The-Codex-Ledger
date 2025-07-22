// deck_section.dart
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:daggerheart/models/domain_card.dart';
import 'package:daggerheart/models/character.dart';
import 'package:daggerheart/providers/app_data_provider.dart';
import 'package:daggerheart/screens/character_sheet/dialogs/domain_card_selection_dialog.dart';
import 'package:daggerheart/utils/debug_utils.dart';
import 'package:provider/provider.dart';
import 'package:daggerheart/extensions/iterable_extensions.dart';

class DomainDeckSection extends StatefulWidget {
  final Character character;
  final ValueChanged<Character> onCharacterUpdated;

  const DomainDeckSection({
    super.key,
    required this.character,
    required this.onCharacterUpdated,
  });

  @override
  State<DomainDeckSection> createState() => _DomainDeckSectionState();
}

class _DomainDeckSectionState extends State<DomainDeckSection> {
  Future<void> _handleDomainDeckSelection() async {
    final appData = Provider.of<AppDataProvider>(context, listen: false);
    final allDomainCards = appData.domainCards;

    final selectedClass = appData.classes.firstWhereOrNull(
          (cls) => cls.name == widget.character.characterClass,
    );

    final domainCards = allDomainCards.where((domainCard) {
      final characterLevel = widget.character.characterLevel;
      final cardLevelInt = domainCard.level;
      final levelMatch = characterLevel == null || cardLevelInt <= characterLevel;
      final classMatch = selectedClass == null ||
          selectedClass.domainClasses.contains(domainCard.domain);
      return levelMatch && classMatch;
    }).toList();

    if (!mounted) return;

    final selectedCards = await showDialog<List<DomainCardModel>>(
      context: context,
      builder: (context) => Dialog(
        child: SizedBox(
          width: 600,
          height: 700,
          child: DomainCardSelectionDialog(
            availableCards: domainCards,
            initiallySelected: widget.character.deck,
          ),
        ),
      ),
    );

    if (selectedCards != null && selectedCards.isNotEmpty) {
      final updated = widget.character.copyWith(deck: selectedCards);
      debugLog('DomainDeckSection: Updated deck size: ${updated.deck.length}');
      widget.onCharacterUpdated(updated);
    }
  }

  @override
  Widget build(BuildContext context) {
    final deck = widget.character.deck;
    final isDesktop = defaultTargetPlatform == TargetPlatform.macOS ||
        defaultTargetPlatform == TargetPlatform.windows ||
        defaultTargetPlatform == TargetPlatform.linux;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Domain Deck',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        isDesktop
            ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton.icon(
              onPressed: _handleDomainDeckSelection,
              icon: Icon(Icons.library_add),
              label: Text('Add Domain Cards'),
            ),
            const SizedBox(height: 8),
            ...deck.map((domainCard) => ListTile(
              title: Text(domainCard.name),
              subtitle: Text('${domainCard.domain} • Level ${domainCard.level}'),
            )),
          ],
        )
            : GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: _handleDomainDeckSelection,
          child: deck.isEmpty
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
            itemCount: deck.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final domainCard = deck[index];
              return ListTile(
                title: Text(domainCard.name),
                subtitle: Text('${domainCard.domain} • Level ${domainCard.level}'),
              );
            },
          ),
        ),
      ],
    );
  }
}
