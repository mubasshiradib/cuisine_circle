import 'package:flutter/material.dart';
import '../models/recipe_model.dart';

class RecipePage extends StatelessWidget {
  final Recipe recipe;
  final bool isLiked;

  const RecipePage({
    super.key,
    required this.recipe,
    this.isLiked = false,
  });

  static const Color scaffoldBgColor = Color(0xFFF8F5F2);
  static const Color darkBrownColor = Color(0xFF2D2013);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: darkBrownColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          recipe.title.isNotEmpty ? recipe.title : 'Recipe Details',
          style: const TextStyle(
            color: darkBrownColor,
            fontWeight: FontWeight.bold,
            fontFamily: 'serif',
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Recipe Image
            Container(
              height: 220,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFECE7DF),
                borderRadius: BorderRadius.circular(16),
              ),
              child: recipe.imageUrl.isNotEmpty
                  ? ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  recipe.imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) =>
                  const Center(
                    child: Icon(
                      Icons.restaurant_menu_rounded,
                      size: 60,
                      color: Color(0xFF9E978E),
                    ),
                  ),
                ),
              )
                  : const Center(
                child: Icon(
                  Icons.restaurant_menu_rounded,
                  size: 60,
                  color: Color(0xFF9E978E),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Title & Author row
            Text(
              recipe.title.isNotEmpty ? recipe.title : 'Untitled Recipe',
              style: const TextStyle(
                color: darkBrownColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'serif',
              ),
            ),
            const SizedBox(height: 6),

            // Author Name
            Row(
              children: [
                const Icon(Icons.person_outline, size: 18, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  'Recipe by ${recipe.authorName}',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 12),

            const Text(
              'Description & Method',
              style: TextStyle(
                color: darkBrownColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'serif',
              ),
            ),
            const SizedBox(height: 8),

            Text(
              recipe.description.isNotEmpty
                  ? recipe.description
                  : 'No description provided.',
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 15,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}