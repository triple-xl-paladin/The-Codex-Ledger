/*
 * This file is part of The Codex Ledger.
 *
 * The Codex Ledger is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * The Codex Ledger is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with The Codex Ledger.  If not, see <https://www.gnu.org/licenses/>.
 */

import 'package:daggerheart/models/character_ancestry.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/app_data_provider.dart';
import 'package:markdown_widget/markdown_widget.dart';
import '../../theme/markdown_theme.dart'; // adjust path as needed

class AncestryCardsListScreen extends StatefulWidget {
  const AncestryCardsListScreen({
    super.key,
  });

  @override
  State <AncestryCardsListScreen> createState() => _AncestryCardsListScreenState();
}

class _AncestryCardsListScreenState extends State<AncestryCardsListScreen> {
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
  }

  List<CharacterAncestry> _filteredCards(List<CharacterAncestry> cardList) {
    return cardList.where((card) {
      final matchesSearch = _searchQuery.isEmpty ||
          card.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          card.description.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesSearch;
    }).toList();
  }

  Widget _buildCardTile(CharacterAncestry card) {
    final theme = Theme.of(context);

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
            config: buildMarkdownConfigFromTheme(theme),
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
              appBar: AppBar(title: Text("Ancestry Cards")),
              body: Center(child: CircularProgressIndicator(),),
            );
          } // if

          final List<CharacterAncestry> filteredCards = _filteredCards(appData.ancestries);

          return Scaffold(
            appBar: AppBar(
              title: Text('Ancestry Cards'),
            ),
            body: ListView.builder(
                itemCount: filteredCards.length,
                itemBuilder: (context, index) {
                  final card = filteredCards[index];
                  return _buildCardTile(card);
                } // itemBuilder
            ),
          );
        } //builder
    );
  }

}
