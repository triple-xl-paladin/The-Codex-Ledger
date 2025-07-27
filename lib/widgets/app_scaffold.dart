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
import 'sidebar_menu.dart';

class AppScaffold extends StatelessWidget {
  final Widget content;
  final String title;
  final ValueChanged<Widget> onSelectContent;  // add this
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;
  final List<Map<String, dynamic>> features;

  const AppScaffold({
    required this.content,
    required this.title,
    required this.onSelectContent,
    required this.isDarkMode,
    required this.onThemeChanged,
    required this.features,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      drawer: SidebarMenu(
          features: features,
          onSelectContent: onSelectContent,
        isDarkMode: isDarkMode,
        onThemeChanged: onThemeChanged,
      ),
      body: content,
    );
  }
}
