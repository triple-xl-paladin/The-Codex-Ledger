class CharacterClass {
  final String id;
  final String name;
  final String description;
  final int evasion;
  final int hitPoints;
  final List<String> domainClasses;
  final List<String> classItems;
  final String hopeFeature;
  final List<String> classFeatures;
  final List<String> availableSubClasses;

  CharacterClass({
    required this.id,
    required this.name,
    required this.description,
    required this.evasion,
    required this.hitPoints,
    required this.domainClasses,
    required this.classItems,
    required this.hopeFeature,
    required this.classFeatures,
    required this.availableSubClasses,
  });

  factory CharacterClass.fromJson(Map<String, dynamic> json) {
    return CharacterClass(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      evasion: json['evasion'],
      hitPoints: json['hitPoints'],
      domainClasses: List<String>.from(json['domainClasses']),
      classItems: List<String>.from(json['classItems']),
      hopeFeature: json['hopeFeature'],
      classFeatures: List<String>.from(json['classFeatures']),
      availableSubClasses: List<String>.from(json['availableSubClasses']),
    );
  }
}
