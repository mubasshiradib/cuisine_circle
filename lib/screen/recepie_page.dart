import 'package:flutter/material.dart';
import '../models/recipe_model.dart';

class RecipePage extends StatefulWidget {
  final Recipe recipe;
  final bool isLiked;

  const RecipePage({super.key, required this.recipe, this.isLiked = false});

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  static const Color scaffoldBgColor = Color(0xFFF8F5F2);
  static const Color darkBrownColor = Color(0xFF2D2013);
  static const Color iconContainerColor = Color(0xFFECEBE8);

  late bool isLiked;

  @override
  void initState() {
    super.initState();
    isLiked = widget.isLiked;
  }

  Widget _buildPlaceholderImage() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: const Color(0xFFECE7DF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.restaurant_menu_rounded,
            size: 54,
            color: Color(0xFF9E978E),
          ),
          SizedBox(height: 8),
          Text(
            'Recipe Image',
            style: TextStyle(
              color: Color(0xFF9E978E),
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBgColor,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Container(
            width: 42,
            height: 42,
            decoration: const BoxDecoration(
              color: iconContainerColor,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: const Icon(
                Icons.arrow_back_rounded,
                color: darkBrownColor,
                size: 22,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        title: const Text(
          'Recipe Details',
          style: TextStyle(
            color: darkBrownColor,
            fontWeight: FontWeight.w700,
            fontSize: 20,
            fontFamily: 'serif',
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Container(
              width: 42,
              height: 42,
              decoration: const BoxDecoration(
                color: iconContainerColor,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: Icon(
                  isLiked ? Icons.favorite : Icons.favorite_border_rounded,
                  color: isLiked ? Colors.redAccent : darkBrownColor,
                  size: 22,
                ),
                onPressed: () {
                  setState(() {
                    isLiked = !isLiked;
                  });
                },
              ),
            ),
          ),
        ],
      ),

      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          widget.recipe.imageUrl.isNotEmpty
              ? Image.network(widget.recipe.imageUrl, height: 200)
              : _buildPlaceholderImage(),

          const SizedBox(height: 20),

          Text(
            widget.recipe.title,
            style: const TextStyle(
              color: darkBrownColor,
              fontSize: 26,
              fontWeight: FontWeight.bold,
              fontFamily: 'serif',
            ),
          ),

          const SizedBox(height: 24),

          const Text(
            'About',
            style: TextStyle(
              color: darkBrownColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'serif',
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              widget.recipe.description.isNotEmpty
                  ? widget.recipe.description
                  : 'No description provided.',
              style: const TextStyle(
                color: darkBrownColor,
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ),

          const SizedBox(height: 24),

          const Text(
            'Ingredients',
            style: TextStyle(
              color: darkBrownColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'serif',
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.recipe.ingredients.isEmpty)
                  const Text(
                    'No ingredients listed.',
                    style: TextStyle(color: Colors.grey),
                  )
                else
                  for (String ingredient in widget.recipe.ingredients)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: Text(
                        ingredient,
                        style: const TextStyle(
                          color: darkBrownColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          height: 1.4,
                        ),
                      ),
                    ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          const Text(
            'Procedure',
            style: TextStyle(
              color: darkBrownColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'serif',
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              widget.recipe.procedure.isNotEmpty
                  ? widget.recipe.procedure
                  : 'No procedure provided.',
              style: const TextStyle(
                color: darkBrownColor,
                fontSize: 14,
                height: 1.6,
              ),
            ),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
