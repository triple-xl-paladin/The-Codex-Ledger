// lib/widgets/app_scaffold.dart
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
