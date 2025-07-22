class CharacterAncestry {
  final String? id;
  final String name;
  final String description;
  final String? image;

  CharacterAncestry({
    required this.id,
    required this.name,
    required this.description,
    this.image,
  });

  factory CharacterAncestry.fromJson(Map<String, dynamic> json) {
    return CharacterAncestry(
      id: json['id'],
      name: json['name'],
      description: json['feature'],
      image: json['image'],
    );
  }
}
