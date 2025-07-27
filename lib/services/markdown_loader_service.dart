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

import 'package:daggerheart/services/logging_service.dart';
import 'package:daggerheart/utils/debug_utils.dart';
import 'package:flutter/services.dart';

class MarkdownLoaderService {
  static final MarkdownLoaderService _instance = MarkdownLoaderService._internal();

  final Map<String, String> _cache = {};

  factory MarkdownLoaderService() => _instance;

  MarkdownLoaderService._internal();

  /// Loads a markdown file from the assets folder.
  Future<String> loadMarkdownFile(String markdownFile) async {
    debugLog('MarkdownLoaderService started');
    debugLog('MarkdownLoaderService: Markdown file: $markdownFile');
    if (_cache.containsKey(markdownFile)) {
      return _cache[markdownFile]!;
    }

    try {
      final content = await rootBundle.loadString(markdownFile);
      _cache[markdownFile] = content;
      return content;
    } catch (e) {
      LoggingService().severe('Error loading markdown: $e');
      debugLog('Error loading markdown: $e');
      return 'Error loading markdown: $e';
    }
  }

}
