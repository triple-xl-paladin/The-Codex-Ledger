/*
import 'package:flutter/material.dart';
import '../../models/character.dart';
import '../../models/domain_card.dart';
import '../../services/database_helper.dart';
import '../card_screens/domain_cards_list_screen.dart';

class CharacterDeckScreen extends StatefulWidget {
  final Character character;

  const CharacterDeckScreen({super.key, required this.character});

  @override
  State <CharacterDeckScreen> createState() => _CharacterDeckScreenState();
}

class _CharacterDeckScreenState extends State<CharacterDeckScreen> {
  late Character _character;

  @override
  void initState() {
    super.initState();
    _character = widget.character;
  }

  void _addCardFromDomainList() async {
    final selectedCard = await Navigator.of(context).push<DomainCardModel>(
      MaterialPageRoute(
        builder: (context) => DomainCardsListScreen(),
      ),
    );

    if (selectedCard != null) {
      final alreadyExists = _character.deck.any((card) => card.name == selectedCard.name);

      if (alreadyExists) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Card already in deck')),
        );
      } else {
        setState(() {
          _character.deck.add(selectedCard);
        });
        await _saveDeck();
      }
    }
  }

  /*
  void _addCardDialog() {
    final nameController = TextEditingController();
    final domainController = TextEditingController();
    final levelController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Add Card'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameController, decoration: InputDecoration(labelText: 'Card Name')),
            TextField(controller: domainController, decoration: InputDecoration(labelText: 'Domain')),
            TextField(controller: levelController, decoration: InputDecoration(labelText: 'Level')),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final card = CardModel(
                level: levelController.text.trim(),
                domain: domainController.text.trim(),
                name: nameController.text.trim(),
                type: '',
                recallCost: '',
                feature: '',
                image: '',
              );
              setState(() {
                _character.deck.add(card);
              });
              Navigator.pop(context);
            },
            child: Text('Add'),
          )
        ],
      ),
    );
  }
  */

  void _removeCard(DomainCardModel card) {
    setState(() {
      _character.deck.remove(card);
    });
  }

  Future<void> _saveDeck() async {
    await DatabaseHelper.instance.updateCharacter(_character);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Deck saved')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${_character.name}\'s Deck'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            tooltip: 'Save Deck',
            onPressed: _saveDeck,
          )
        ],
      ),
      body: ListView.builder(
        itemCount: _character.deck.length,
        itemBuilder: (context, index) {
          final card = _character.deck[index];
          return ListTile(
            title: Text(card.name),
            subtitle: Text('${card.domain} • Level ${card.level}'),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _removeCard(card),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addCardFromDomainList,
        tooltip: 'Add Card',
        child: Icon(Icons.add),
      ),
    );
  }
}


 */