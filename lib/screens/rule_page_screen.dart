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
