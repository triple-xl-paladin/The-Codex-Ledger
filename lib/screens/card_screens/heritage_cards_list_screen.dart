import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/character_heritage.dart';
import '../../providers/app_data_provider.dart';
import 'package:markdown_widget/markdown_widget.dart';
import '../../theme/markdown_theme.dart';

class HeritageCardsListScreen extends StatefulWidget {

  const HeritageCardsListScreen({
    super.key
  });

  @override
  State <HeritageCardsListScreen> createState() => _HeritageCardsListScreenState();
}

class _HeritageCardsListScreenState extends State<HeritageCardsListScreen> {
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
  }

  List<CharacterHeritage> _filteredCards(List<CharacterHeritage> cardList) {
    return cardList.where((card) {
      final matchesSearch = _searchQuery.isEmpty ||
          card.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          card.description.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesSearch;
    }).toList();
  }

  Widget _buildCardTile(CharacterHeritage card) {
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
            data: card.description,
            config: darkFantasyMarkdownConfig,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
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
              appBar: AppBar(title: Text("Community Cards")),
              body: Center(child: CircularProgressIndicator(),),
            );
          } // if

          final List<CharacterHeritage> filteredCards = _filteredCards(appData.heritages);
          //final List<CharacterHeritage> allCards = appData.heritages;

          return Scaffold(
            appBar: AppBar(
              title: Text('Community Cards'),
            ),
            body: Column(
              children: [
                ListView.builder(
                  itemCount: filteredCards.length,
                  itemBuilder: (context, index) {
                    final card = filteredCards[index];
                    return _buildCardTile(card);
                  } // itemBuilder
                ),
              ]//ListView
            ),
          );
        } //builder
    );
  }


}
