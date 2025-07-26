class RuleManifestEntry {
  final String title;
  final String file;

  RuleManifestEntry({required this.title, required this.file});

  factory RuleManifestEntry.fromJson(Map<String, dynamic> json) {
    return RuleManifestEntry(
      title: json['title'],
      file: json['file'],
    );
  }
}