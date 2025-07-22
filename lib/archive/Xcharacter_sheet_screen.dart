/*
import 'package:daggerheart/widgets/character/character_class_section.dart';
import 'package:flutter/material.dart';
//import 'package:url_launcher/url_launcher.dart';
import 'package:daggerheart/services/database_helper.dart';
import 'package:daggerheart/models/character.dart';
import 'package:daggerheart/models/domain_card.dart';
import 'package:daggerheart/models/character_class.dart';
import 'package:daggerheart/services/class_service.dart';
//import 'dart:async';

/// The Character Sheet screen shows the details of the character. The
/// constructor expects a Character object.
class CharacterSheetScreen extends StatefulWidget {
  final Character character;

  /// Constructor expects a Character object
  const CharacterSheetScreen({
    Key? key,
    required this.character,
  }) : super(key: key);

  @override
  State<CharacterSheetScreen> createState() => _CharacterSheetScreenState();
}

/// Private class that contains the layout and widgets for the character screen
class _CharacterSheetScreenState extends State<CharacterSheetScreen> {
  Character? _character;
  List<CharacterClass> _availableClasses = [];

  // assigns widget.character to _character as I didn't want to refactor
  // my whole code.
  @override
  void initState() {
    super.initState();
    _character = widget.character;
    _loadClasses();
  }

  void _loadClasses() async {
    final classes = await loadClasses(jsonAssetPath: 'assets/classes.json');
    if (!mounted) return;
    setState(() {
      _availableClasses = classes;
    });
  }

  // Table to hold all the attributes
  Widget _buildAttributeTable(Map<Attribute, int>? attributes) {
    if (attributes == null || attributes.isEmpty) {
      return Text('No attributes provided');
    }

    return Table(
      border: TableBorder.all(color: Colors.grey),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        TableRow(
          decoration: BoxDecoration(color: Colors.grey[800]),
          children: attributes.keys.map((attr) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                attr.name.toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            );
          }).toList(),
        ),
        TableRow(
          children: attributes.values.map((value) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                value.toString(),
                textAlign: TextAlign.center,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  // Holds all the domain cards for the character
  Widget _buildDeckList(List<CardModel> deck) {
    if (deck.isEmpty) {
      return Text('No cards in deck');
    }

    return ListView.builder(
      itemCount: deck.length,
      shrinkWrap: true, // Important to work inside a column
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final card = deck[index];
        return ListTile(
          title: Text(card.name),
          subtitle: Text('${card.domain} • Level ${card.level}'),
        );
      },
    );
  }

  // Save a character to db method
  void _saveCharacter() async {
    if (_character == null) return;

    try {
      // Call your DatabaseHelper update method (assuming you have one)
      await DatabaseHelper.instance.updateCharacter(_character!);

      if (!mounted) return;  // <-- guard here

      // Show a simple confirmation/snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Character saved successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save character: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_character!.name),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveCharacter,
            tooltip: 'Save changes',
          ),
        ],
      ),
      body:
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Text('Name: ${widget.character.name}'),
              SizedBox(height: 8),
              // The section for Class, sub-class, ancestry and heritage are
              // handled in a separate custom widget CharacterClassSection
              CharacterClassSection(
                  character: _character!, // ✅ Force unwrap because we know it's non-null at this point
                  onCharacterUpdated: (updated) {
                    setState(() {
                      _character = updated;
                    });
                  }),
              SizedBox(height: 16),
              Text(
                'Attributes',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 8),
              _buildAttributeTable(_character!.attributes),
              SizedBox(height: 16),
              Text(
                'Deck',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 8),
              _buildDeckList(_character!.deck),
            ],
          ),
        ),
    );
  }
}

 */