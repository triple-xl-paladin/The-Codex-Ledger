import 'rule_manifest_entry_model.dart';

class RuleManifestCategory {
  final String category;
  final List<RuleManifestEntry> entries;

  RuleManifestCategory({required this.category, required this.entries});

  factory RuleManifestCategory.fromJson(Map<String, dynamic> json) {
    return RuleManifestCategory(
      category: json['category'],
      entries: (json['entries'] as List<dynamic>)
          .map((e) => RuleManifestEntry.fromJson(e))
          .toList(),
    );
  }
}
