class RuleEntry {
  final String title;
  final String file;

  RuleEntry({required this.title, required this.file});

  factory RuleEntry.fromJson(Map<String, dynamic> json) {
    return RuleEntry(
      title: json['title'],
      file: json['file'],
    );
  }
}
