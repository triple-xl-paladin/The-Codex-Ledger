import 'package:daggerheart/models/character_subclass.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:daggerheart/theme/markdown_theme.dart';
import 'package:daggerheart/providers/app_data_provider.dart'; // adjust path as needed

class SubclassCardsListScreen extends StatefulWidget {

  const SubclassCardsListScreen({
    super.key,
  });

  @override
  State <SubclassCardsListScreen> createState() => _SubclassCardsListScreenState();
}

class _SubclassCardsListScreenState extends State<SubclassCardsListScreen> {
  List<CharacterSubclass> _filteredCards = [];
  String _searchQuery = '';
  String? currentSubclass;

  void _applyFilters(List<CharacterSubclass> cards) {
    setState(() {
      _filteredCards = cards.where((card) {
        final matchesSearch = _searchQuery.isEmpty ||
            card.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            card.description.toLowerCase().contains(_searchQuery.toLowerCase());

        final matchesSubclass = currentSubclass == null || card.name == currentSubclass;

        return matchesSearch && matchesSubclass;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final appData = Provider.of<AppDataProvider>(context);
    final theme = Theme.of(context);

    if (appData.isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text('Sub Classes')),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (appData.error != null) {
      return Scaffold(
        appBar: AppBar(title: Text('Sub Classes')),
        body: Center(child: Text('Error loading cards: ${appData.error}')),
      );
    }

    final allCards = appData.subclasses.where((card) => card.name.isNotEmpty).toList();

    // Initialize filtered cards on first build or when search is cleared
    if (_filteredCards.isEmpty && _searchQuery.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _applyFilters(allCards);
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Sub Classes'),
      ),
      body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value) {
                    _searchQuery = value;
                    _applyFilters(allCards);
                  },
                  decoration: InputDecoration(
                    labelText: 'Search',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Expanded(
                child: _filteredCards.isEmpty
                    ? Center(child: Text('No subclass cards found'))
                    :ListView.builder(
                        itemCount: _filteredCards.length,
                        itemBuilder: (context, index) {
                          final card = _filteredCards[index];
                          return ListTile(
                            leading: (card.image.isNotEmpty)
                              ? Image.asset(
                                  'assets/${card.image}',
                                  width: 50,
                                  height: 50,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Icon(Icons.image_not_supported),
                              )
                              : Icon(Icons.image_not_supported, size: 50),
                            title: Text(card.name),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MarkdownWidget(
                                  data: card.description,
                                  config: buildMarkdownConfigFromTheme(theme), // from your custom config file
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  //config: MarkdownConfig.darkConfig,
                                ),
                                const SizedBox(height: 4),
                              ],
                            ),
                            isThreeLine: true,
                          );
                        }, // itemBuilder
                    ),
              ),
            ], // Column - Children
          ),
    );
  } // build
} // _SubclassCardsListScreenState
