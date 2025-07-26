import 'package:daggerheart/screens/rule_page_screen.dart';
import 'package:daggerheart/services/rules_manifest_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:markdown_widget/markdown_widget.dart';
import '../../theme/markdown_theme.dart';
import '../../utils/debug_utils.dart';
import '../models/rule_manifest_category_model.dart'; // adjust path as needed

class RulesContentScreen extends StatefulWidget {

  const RulesContentScreen({
    super.key,
  });

  @override
  State <RulesContentScreen> createState() => _RulesContentScreenState();
}

class _RulesContentScreenState extends State<RulesContentScreen> {

  late Future<List<RuleManifestCategory>> _rulesFuture;

  @override
  void initState() {
    super.initState();
    _rulesFuture = RulesManifestService().loadRulesManifest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rules Content'),
      ),
      body: FutureBuilder<List<RuleManifestCategory>>(
          future: _rulesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error loading rules: ${snapshot.error}'));
            }

            final categories = snapshot.data!;
            return ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, catIndex) {
                final category = categories[catIndex];

                return ExpansionTile(
                  title: Text(category.category),
                  children: category.entries.map((entry) {
                    return ListTile(
                      title: Text(entry.title),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => RulePage(
                              filePath: entry.file,
                              title: entry.title,
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                );
              },
            );
          },
      ),
    );
  }
}