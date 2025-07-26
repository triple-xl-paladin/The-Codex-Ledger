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
