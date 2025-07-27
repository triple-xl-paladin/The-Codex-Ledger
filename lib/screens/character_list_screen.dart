import 'package:daggerheart/screens/character_sheet/character_sheet_screen.dart';
import 'package:flutter/material.dart';
import '../models/character.dart';
import '../services/database_helper.dart';
//import 'character_deck_screen.dart'; // (we’ll create this next)

class CharacterListScreen extends StatefulWidget {
  const CharacterListScreen({super.key});

  @override
  State<CharacterListScreen> createState() => _CharacterListScreenState();
}

class _CharacterListScreenState extends State<CharacterListScreen> {
  List<Character> characters = [];

  @override
  void initState() {
    super.initState();
    _loadCharacters();
  }

  Future<void> _loadCharacters() async {
    final chars = await DatabaseHelper.instance.getCharacters();
    setState(() {
      characters = chars;
    });
  }

  void _deleteCharacter(Character character) async {
    await DatabaseHelper.instance.deleteCharacter(character.characterId!);
    _loadCharacters();
  }

  void _showCreateCharacterDialog() {
    final nameController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('New Character'),
        content: TextField(
          controller: nameController,
          decoration: InputDecoration(labelText: 'Character Name'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final name = nameController.text.trim();
              if (name.isNotEmpty) {
                final newCharacter = Character.newCharacter(name);
                await DatabaseHelper.instance.insertCharacter(newCharacter);
                if(!mounted) return;
                Navigator.of(context).pop();
                _loadCharacters();
              }
            },
            child: Text('Create'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Characters')),
      body: ListView.builder(
        itemCount: characters.length,
        itemBuilder: (context, index) {
          final character = characters[index];
          return ListTile(
            title: Text(character.name),
            //subtitle: Text('${character.deck.length} cards'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CharacterSheetScreen(characterId: character.characterId!),
                ),
              ).then((_) => _loadCharacters());
            },
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _deleteCharacter(character),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showCreateCharacterDialog,
        tooltip: 'Add New Character',
        child: Icon(Icons.add),
      ),
    );
  }
}
