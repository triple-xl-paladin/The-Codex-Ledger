class CharacterSubclass {
  final String name;
  final String description;

  CharacterSubclass({
    required this.name,
    required this.description,
  });

  factory CharacterSubclass.fromJson(Map<String, dynamic> json) {
    return CharacterSubclass(
      name: json['name'],
      description: json['feature'],
    );
  }
}
