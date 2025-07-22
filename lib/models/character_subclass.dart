class CharacterSubclass {
  final String name;
  final String description;
  final String image;

  CharacterSubclass({
    required this.name,
    required this.description,
    required this.image,
  });

  factory CharacterSubclass.fromJson(Map<String, dynamic> json) {
    return CharacterSubclass(
      name: json['name'],
      description: json['feature'],
      image: json['image'] ?? '',
    );
  }
}
