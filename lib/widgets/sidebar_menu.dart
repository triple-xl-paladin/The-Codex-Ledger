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
import 'package:daggerheart/screens/card_screens/items_list_screen.dart';
import 'package:daggerheart/screens/card_screens/weapon_list_screen.dart';
import 'package:daggerheart/screens/rules_content_screen.dart';
import '../screens/character_list_screen.dart';
import 'package:flutter/material.dart';
import '../screens/settings_screen.dart';
import '../screens/card_category_screen.dart';
import 'package:daggerheart/utils/other_utils.dart';

class SidebarMenu extends StatefulWidget {
  final void Function(Widget) onSelectContent;
  final bool isDarkMode;
  final void Function(bool) onThemeChanged;
  final List<Map<String, dynamic>> features;

  const SidebarMenu({
    required this.onSelectContent,
    required this.isDarkMode,
    required this.onThemeChanged,
    required this.features,
    super.key,
  });

  @override
  State<SidebarMenu> createState() => _SidebarMenuState();

}

class _SidebarMenuState extends State<SidebarMenu> {
  String _versionString = '';

  @override
  void initState() {
    super.initState();
    getBuildVersionString().then((str) {
      setState(() {
        _versionString = str;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            DrawerHeader(
              child: Text(
                'Daggerheart Menu',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            Expanded (
              child: ListView(
                children: [
                  ListTile(
                    leading: Icon(Icons.grid_view),
                    title: Text('Home'),
                    // Leave this as Placeholder as it will reset the screen to home
                    // If it points to homescreen, it will keep recreating the screen
                    // within the homescreen, duplicating everything.
                    onTap: () {
                      Navigator.of(context).pop();
                      widget.onSelectContent(Placeholder());
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.style),
                    title: Text('Cards'),
                    onTap: () {
                      Navigator.of(context).pop();
                      widget.onSelectContent(CardCategoryScreenContent(onCategorySelected: widget.onSelectContent));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.style),
                    title: Text('Characters'),
                    onTap: () {
                      Navigator.of(context).pop();
                      widget.onSelectContent(CharacterListScreen());
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.style),
                    title: Text('Weapons'),
                    onTap: () {
                      Navigator.of(context).pop();
                      widget.onSelectContent(WeaponListScreen());
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.style),
                    title: Text('Armour'),
                    onTap: () {
                      Navigator.of(context).pop();
                      widget.onSelectContent(ArmourListScreen());
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.style),
                    title: Text('Items'),
                    onTap: () {
                      Navigator.of(context).pop();
                      widget.onSelectContent(ItemsListScreen());
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.style),
                    title: Text('Rules'),
                    onTap: () {
                      Navigator.of(context).pop();
                      widget.onSelectContent(RulesContentScreen());
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Settings'),
                    onTap: () {
                      Navigator.of(context).pop();
                      widget.onSelectContent(SettingsScreen(
                        isDarkMode: widget.isDarkMode,
                        onThemeChanged: widget.onThemeChanged,
                      ));
                    },
                  ),
                ], // Children in expanded
              ),
            ),

            const Divider(),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _versionString.isNotEmpty ? _versionString:'Loading version...',
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
          ], // Children in column
        ),
      ),
    );
  }
}
