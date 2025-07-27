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

import 'package:daggerheart/services/markdown_loader_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:markdown_widget/markdown_widget.dart';
import '../../theme/markdown_theme.dart';
import '../utils/debug_utils.dart';

class RulePage extends StatelessWidget {
  final String filePath;
  final String title;

  const RulePage({required this.filePath, required this.title, super.key});

  Future<String> loadMarkdown(String path) async {
    debugLog('RulePage: loadMarkdown called');
    return await rootBundle.loadString(path);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: FutureBuilder<String>(
        future: MarkdownLoaderService().loadMarkdownFile(filePath),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          return MarkdownWidget(
            data: snapshot.data!,
            config: buildMarkdownConfigFromTheme(theme),
          );
        },
      ),
    );
  }
}
