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

import 'package:daggerheart/screens/rule_page_screen.dart';
import 'package:daggerheart/services/rules_manifest_service.dart';
import 'package:flutter/material.dart';
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