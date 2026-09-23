class Recipe {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final List<String> ingredients;
  final String procedure;

  Recipe({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.ingredients,
    required this.procedure,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'ingredients': ingredients,
      'procedure': procedure,
    };
  }

  factory Recipe.fromMap(Map<String, dynamic> map, String docId) {
    return Recipe(
      id: docId,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      ingredients: List<String>.from(map['ingredients'] ?? []),
      procedure: map['procedure'] ?? '',
    );
  }
}
