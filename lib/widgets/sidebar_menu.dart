import 'package:daggerheart/screens/card_screens/armour_list_screen.dart';
import 'package:daggerheart/screens/card_screens/weapon_list_screen.dart';

import '../screens/character_list_screen.dart';
import 'package:flutter/material.dart';
import '../screens/settings_screen.dart';
import '../screens/card_category_screen.dart';

class SidebarMenu extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(child: Text('Daggerheart Menu')),
          ListTile(
            leading: Icon(Icons.grid_view),
            title: Text('Home'),
            onTap: () => onSelectContent(Placeholder()), // show grid
          ),
          ListTile(
            leading: Icon(Icons.style),
            title: Text('Cards'),
            onTap: () => onSelectContent(CardCategoryScreenContent(onCategorySelected: onSelectContent)),
          ),
          ListTile(
            leading: Icon(Icons.style),
            title: Text('Characters'),
            onTap: () => onSelectContent(CharacterListScreen()),
          ),
          ListTile(
            leading: Icon(Icons.style),
            title: Text('Weapons'),
            onTap: () => onSelectContent(WeaponListScreen()),
          ),
          ListTile(
            leading: Icon(Icons.style),
            title: Text('Armour'),
            onTap: () => onSelectContent(ArmourListScreen()),
          ),
          ListTile(
            leading: Icon(Icons.style),
            title: Text('Items'),
            onTap: () => onSelectContent(Placeholder()),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => onSelectContent(SettingsScreen(
              isDarkMode: isDarkMode,
              onThemeChanged: onThemeChanged,
            )),
          ),
        ],
      ),
    );
  }
}
