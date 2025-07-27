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

import 'package:flutter/material.dart';
import 'card_screens/domain_cards_list_screen.dart';
import 'card_screens/ancestry_cards_list_screen.dart';
import 'card_screens/communities_cards_list_screen.dart';
import 'card_screens/subclasses_cards_list_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CardCategoryScreenContent extends StatelessWidget {
  final void Function(Widget) onCategorySelected;

  const CardCategoryScreenContent({required this.onCategorySelected});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> cardCategories = [
      {
        'title': 'Domain Cards',
        'icon': Icon(Icons.book, size: 40, color: Theme.of(context).iconTheme.color),
        'content': DomainCardsListScreen(),
      },
      {
        'title': 'Ancestry Cards',
        'icon': FaIcon(FontAwesomeIcons.dna, size: 40, color: Theme.of(context).iconTheme.color),
        'content': AncestryCardsListScreen(),
      },
      {
        'title': 'Community Cards',
        'icon': Icon(Icons.groups, size: 40, color: Theme.of(context).iconTheme.color),
        'content': CommunitiesCardsListScreen(),
      },
      {
        'title': 'Sub-Class Cards',
        'icon': Icon(Icons.assignment_ind, size: 40, color: Theme.of(context).iconTheme.color),
        'content': SubclassCardsListScreen(),
      },
    ];
    return GridView(
      padding: EdgeInsets.all(8),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 1,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      children: cardCategories.map((cat) {
        return GestureDetector(
          onTap: () => onCategorySelected(cat['content']),
          child: Card(
            margin: EdgeInsets.all(6),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 40,
                    child: cat['icon'],
                  ),
                  SizedBox(height: 4),
                  Text(
                    cat['title'],
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
