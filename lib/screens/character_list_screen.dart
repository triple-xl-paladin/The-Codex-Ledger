import 'package:daggerheart/screens/character_sheet/character_sheet_screen.dart';
import 'package:flutter/material.dart';
import '../models/character.dart';
import '../services/database_helper.dart';
import '../services/logging_service.dart';

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
    try {
      final chars = await DatabaseHelper.instance.getCharacters();
      setState(() {
        characters = chars;
      });
      LoggingService().info('${DateTime.now()}: Number of characters loaded: ${chars.length}');
    } catch (e, stack) {
      LoggingService().severe('Error loading character: $e\n$stack');
    }
  }

  void _deleteCharacter(Character character) async {
    try {
      await DatabaseHelper.instance.deleteCharacter(character.characterId!);
      LoggingService().info('${DateTime.now()}: Deleted character: ${character.characterId}/${character.name}');
      _loadCharacters();
    } catch (e,stack) {
      LoggingService().severe('Error deleting character: $e\n$stack');
    }
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
                try {
                  final newCharacter = Character.newCharacter(name);
                  await DatabaseHelper.instance.insertCharacter(newCharacter);

                  // Log successful character creation
                  LoggingService().info('${DateTime.now()}: New character ${newCharacter.name} created.');
                  if (!mounted) return;

                  Navigator.of(context).pop();
                  // Force a UI rebuild
                  setState(() {

                  });
                  await _loadCharacters();
                } catch (e,stack) {
                  LoggingService().severe('Error creating character: $e\n$stack');
                }
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
