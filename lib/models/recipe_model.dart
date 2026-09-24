class Recipe {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String userId;
  final String authorName;
  final int likes;

  Recipe({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.userId,
    this.authorName = 'Chef',
    this.likes = 0,
  });

  factory Recipe.fromMap(Map<String, dynamic> data, String documentId) {
    return Recipe(
      id: documentId,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      userId: data['userId'] ?? '',
      authorName: (data['authorName'] != null && data['authorName'].toString().trim().isNotEmpty)
          ? data['authorName']
          : 'Chef',
      likes: (data['likes'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'userId': userId,
      'authorName': authorName,
      'likes': likes,
    };
  }
}