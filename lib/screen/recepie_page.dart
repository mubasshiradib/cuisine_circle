import 'package:flutter/material.dart';

class RecipePage extends StatefulWidget {
  final String title;
  final bool isLiked;

  const RecipePage({super.key, this.title = 'Recipe 1', this.isLiked = false});

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  static const Color scaffoldBgColor = Color(0xFFF8F5F2);
  static const Color darkBrownColor = Color(0xFF2D2013);
  static const Color iconContainerColor = Color(0xFFECEBE8);

  late bool isLiked;

  final String briefAboutText =
      'A delicious and simple homemade dish prepared with fresh ingredients, balanced flavors, and easy-to-follow steps.';

  final List<String> ingredientsList = [
    '2 cups fresh flour or base ingredient',
    '1 tbsp olive oil or butter',
    '1 tsp salt and black pepper',
    'Fresh herbs for seasoning',
    '1 cup warm water or broth',
  ];

  final String procedureText =
      '1. Prepare all ingredients and wash fresh produce thoroughly.\n\n'
      '2. Combine the main ingredients in a mixing bowl and stir well.\n\n'
      '3. Cook over medium heat for 15-20 minutes until golden and aromatic.\n\n'
      '4. Garnish with fresh herbs and serve hot!';

  @override
  void initState() {
    super.initState();
    isLiked = widget.isLiked;
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
          Container(
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
          ),

          const SizedBox(height: 20),

          Text(
            widget.title,
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
              briefAboutText,
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
                for (String ingredient in ingredientsList)
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
              procedureText,
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
