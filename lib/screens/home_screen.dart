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

import 'package:daggerheart/screens/card_screens/armour_list_screen.dart';
import 'package:daggerheart/screens/debug_test_screen.dart';
import 'package:daggerheart/screens/card_screens/items_list_screen.dart';
import 'package:daggerheart/screens/card_screens/weapon_list_screen.dart';
import 'package:daggerheart/screens/rules_content_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:daggerheart/widgets/sidebar_menu.dart';
import 'package:daggerheart/widgets/feature_grid_tile.dart';

import 'package:daggerheart/screens/character_list_screen.dart';
import 'package:daggerheart/screens/card_category_screen.dart';
import 'package:daggerheart/screens/debug_database_screen.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget _selectedContent = Placeholder(); // default content
  bool _isDarkMode = false;

  void _setContent(Widget content) {
    setState(() {
      _selectedContent = content;
    });
  }

  void _handleThemeChanged(bool newValue) {
    setState(() {
      _isDarkMode = newValue;
    });
  }

  final List<Map<String, dynamic>> features = [];

  @override
  void initState() {
    super.initState();
    features.addAll([
      {
        'title': 'Cards',
        'icon': Icons.style,
        'content': CardCategoryScreenContent(onCategorySelected: _setContent),
      },
      {
        'title': 'Characters',
        'icon': Icons.people,
        'content': CharacterListScreen(),
      },
      {
        'title': 'Weapons',
        'icon': FontAwesomeIcons.hammer,
        'content': WeaponListScreen(),
      },
      {
        'title': 'Armour',
        'icon': Icons.shield,
        'content': ArmourListScreen(),
      },
      {
        'title': 'Items',
        'icon': Icons.inventory_2,
        'content': ItemsListScreen(),
      },
      {
        'title': 'Rules',
        'icon': Icons.library_books,
        'content': RulesContentScreen(),
      },
    ]);

    if (kDebugMode) {
      features.add({
        'title': 'Debug Database',
        'icon': Icons.bug_report,
        'content': DebugDatabaseScreen(),
      });
      features.add({
        'title': 'Debug Screen Test',
        'icon': Icons.bug_report,
        'content': DebugTestScreen(),
      });

    }
  }

  @override
  Widget build(BuildContext context) {
    // Access the provider to force initialization
    //final appData = Provider.of<AppDataProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: Text('Daggerheart')),
      drawer: SidebarMenu(
        features: features,
        onSelectContent: _setContent,
        isDarkMode: _isDarkMode,
        onThemeChanged: _handleThemeChanged,
      ),
      body: Column(
        children: [
          Expanded(
            child: _selectedContent is Placeholder
                ? GridView.count(
              crossAxisCount: 4,
              crossAxisSpacing: 10,
              children: features.map((feature) {
                return FeatureGridTile(
                  title: feature['title'],
                  icon: feature['icon'],
                  onTap: () => _setContent(feature['content']),
                );
              }).toList(),
            )
                : _selectedContent,
          ),
        ],
      ),
    );
  }
}
