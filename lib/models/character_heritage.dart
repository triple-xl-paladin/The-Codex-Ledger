class CharacterHeritage {
  final String? id;
  final String name;
  final String description;
  final String? image;

  CharacterHeritage({
    required this.id,
    required this.name,
    required this.description,
    this.image,
  });

  factory CharacterHeritage.fromJson(Map<String, dynamic> json) {
    return CharacterHeritage(
      id: json['id'],
      name: json['name'],
      description: json['feature'],
      image: json['image'],
    );
  }
}
