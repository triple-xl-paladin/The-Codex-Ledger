/*
import 'package:daggerheart/providers/app_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:markdown_widget/widget/markdown.dart';
import 'package:provider/provider.dart';
import '../models/domain_card.dart';
import '../services/card_service.dart';
import '../theme/markdown_theme.dart';
import '../utils/debug_utils.dart';

class CardListScreen extends StatefulWidget {

  const CardListScreen({
   super.key,
  });

  @override
  State <CardListScreen> createState() => _CardListScreenState();
}

class _CardListScreenState extends State<CardListScreen> {
  //late Future<List<CardModel>> _cardsFuture;
  //List<CardModel> _allCards = [];

  String? _selectedDomain;
  final List<int> _tiers = [0,1,2,3,4,5];

  String _searchQuery = '';
  int _selectedTier = 0; // 0 means "no tier filter"
  int _selectedLevel =0;


  @override
  void initState() {
    super.initState();
    //_cardsFuture = loadCards().then((cards) {
    //  _allCards = cards;
    //  return cards;
    }

  List<CardModel> _filteredCards(List<CardModel> cardList) {
    return cardList.where((card) {
      final matchesTier = _selectedTier == 0 || card.tier == _selectedTier;
      final matchesLevel = _selectedLevel == 0 || card.level == _selectedLevel;
      final matchesDomain = _selectedDomain == null || card.domain == _selectedDomain;
      final matchesSearch = _searchQuery.isEmpty ||
          card.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          card.feature.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesTier && matchesLevel && matchesDomain && matchesSearch;
    }).toList();
  }

  Widget _buildStringDropdown(String label, String? selectedValue, List<String> items, ValueChanged<String?> onChanged) {
    return DropdownButton<String>(
      value: selectedValue,
      onChanged: onChanged,
      items: [
        DropdownMenuItem<String>(
          value: null,
          child: Text('All domains'),
        ),
        ...items.map((item) => DropdownMenuItem(
          value: item,
          child: Text(item),
        ))
      ],
    );
  }

  Widget _buildIntDropdown(String label, int selectedValue, List<int> items, ValueChanged<int?> onChanged, String labelPrefix) {
    final displayItems = items.toSet().toList()..sort();

    return DropdownButton<int>(
      value: selectedValue,
      onChanged: onChanged,
      items: displayItems.map<DropdownMenuItem<int>>((item) {
        return DropdownMenuItem<int>(
          value: item,
          child: Text(item == 0 ? 'All $label' : '$labelPrefix $item'),
        );
      }).toList(),
    );
  }

  Widget _buildCardTile(CardModel card) {
    return ListTile(
      leading: (card.image != null)
          ? SizedBox(
        width: 50,
        height: 50,
        child: Image.asset(
          'assets/images/${card.image}',
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) =>
              Icon(Icons.image_not_supported),
        ),
      )
          : Icon(Icons.image_not_supported, size: 50),
      title: Text(card.name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MarkdownWidget(
            data: card.feature,
            config: darkFantasyMarkdownConfig,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
          ),
          const SizedBox(height: 4),
          Text(
            '[Level: ${card.level} | Domain: ${card.domain} | Type: ${card.type} | Recall Cost: ${card.recallCost} | Tier ${card.tier}]',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.grey[400],
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
      isThreeLine: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppDataProvider>(
        builder: (context, appData, _) {
          if (appData.isLoading) {
            return Scaffold(
              appBar: AppBar(title: Text("Domain Cards")),
              body: Center(child: CircularProgressIndicator(),),
            );
          } // if

          final List<CardModel> filteredCards = _filteredCards(appData.cards);
          final List<CardModel> allCards = appData.cards;

          // Debugging wrong type for levels
          for (var card in allCards) {
            debugLog('CardListScreen: Card: ${card.name}, level: ${card.level} (${card.level.runtimeType})');
          }

          // Extract domain, level, tier lists from the cards
          final List<String> domains = allCards.map((c) => c.domain).toSet().toList()..sort();
          final List<int> levels = allCards.map((c) => c.level).whereType<int>().toSet().toList()..sort();
          final List<int> tiers = allCards.map((c) => c.tier).toSet().toList()..sort();

          return Scaffold(
            appBar: AppBar(
              title: Text('Domain Cards'),
            ),
            body: Column(
              children: [
                Wrap(
                  spacing: 10,
                  children: [
                    _buildStringDropdown(
                      'Domain', _selectedDomain, domains, (val) {
                        setState(() {
                          _selectedDomain = val!;
                        });
                      }
                    ), // _buildFilterDropDown(
                    _buildIntDropdown(
                      'Tier', _selectedTier, [0, ...tiers], (val) {
                        setState(() {
                          _selectedTier = val ?? 0;
                        });
                      }, 'Tier'
                    ), //_buildIntDropdown
                    _buildIntDropdown(
                      'Level', _selectedLevel, [0, ...levels], (val) {
                        setState(() {
                          _selectedLevel = val ?? 0;
                        });
                      }, 'Level'
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredCards.length,
                    itemBuilder: (context, index) {
                      final card = filteredCards[index];
                      return _buildCardTile(card);
                    } // itemBuilder
                  ), //ListView
                ), // Expanded
              ], // children
            ),
          );
        } //builder
    );
  }
}



 */