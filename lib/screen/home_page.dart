import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/recipe_model.dart';
import 'search_page.dart';
import 'profile_page.dart';
import 'add_page.dart';
import 'recepie_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const Color scaffoldBgColor = Color(0xFFF8F5F2);
  static const Color darkBrownColor = Color(0xFF2D2013);
  static const Color iconContainerColor = Color(0xFFECEBE8);

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
          child: Center(
            child: Container(
              width: 42,
              height: 42,
              decoration: const BoxDecoration(
                color: iconContainerColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.menu_rounded,
                color: darkBrownColor,
                size: 22,
              ),
            ),
          ),
        ),
        title: const Text(
          'Cuisine Circle',
          style: TextStyle(
            color: darkBrownColor,
            fontWeight: FontWeight.w700,
            fontSize: 22,
            fontFamily: 'serif',
            letterSpacing: 0.5,
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
                icon: const Icon(
                  Icons.search_rounded,
                  color: darkBrownColor,
                  size: 22,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SearchPage()),
                  );
                },
              ),
            ),
          ),
        ],
      ),

      // Firestore theke top 4 likes onujayi recipe load hocche
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('recipes')
            .orderBy('likes', descending: true)
            .limit(4)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Error loading recipes: ${snapshot.error}',
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(32.0),
                child: CircularProgressIndicator(color: darkBrownColor),
              ),
            );
          }

          final docs = snapshot.data?.docs ?? [];

          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              const Text(
                'Trending',
                style: TextStyle(
                  color: darkBrownColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'serif',
                ),
              ),
              const SizedBox(height: 16),

              if (docs.isEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 40.0),
                  child: Center(
                    child: Text(
                      'No trending recipes yet.',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ),
                )
              else
                for (var doc in docs) ...[
                  Builder(
                    builder: (context) {
                      final data = doc.data() as Map<String, dynamic>? ?? {};
                      final recipe = Recipe.fromMap(data, doc.id);
                      bool isLiked = false;

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RecipePage(
                                  recipe: recipe,
                                  isLiked: isLiked,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 10,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Recipe Image container
                                Container(
                                  height: 160,
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFECE7DF),
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(16),
                                    ),
                                  ),
                                  child: recipe.imageUrl.isNotEmpty
                                      ? ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(16),
                                    ),
                                    child: Image.network(
                                      recipe.imageUrl,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      errorBuilder: (context, error, stackTrace) =>
                                      const Center(
                                        child: Icon(
                                          Icons.restaurant_menu_rounded,
                                          size: 48,
                                          color: Color(0xFF9E978E),
                                        ),
                                      ),
                                    ),
                                  )
                                      : const Center(
                                    child: Icon(
                                      Icons.restaurant_menu_rounded,
                                      size: 48,
                                      color: Color(0xFF9E978E),
                                    ),
                                  ),
                                ),

                                // Recipe Title, Author name & Favorite Icon
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                    vertical: 12.0,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              recipe.title.isNotEmpty
                                                  ? recipe.title
                                                  : 'Untitled Recipe',
                                              style: const TextStyle(
                                                color: darkBrownColor,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'serif',
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 2),
                                            // অথরের নাম ডিসপ্লে
                                            Text(
                                              'By ${recipe.authorName}',
                                              style: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Screen flicker মুক্ত হার্ট বাটন
                                      StatefulBuilder(
                                        builder: (context, setHeartState) {
                                          return IconButton(
                                            icon: Icon(
                                              isLiked
                                                  ? Icons.favorite
                                                  : Icons.favorite_border_rounded,
                                              color: isLiked
                                                  ? Colors.redAccent
                                                  : darkBrownColor,
                                            ),
                                            onPressed: () {
                                              setHeartState(() {
                                                isLiked = !isLiked;
                                              });
                                            },
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
            ],
          );
        },
      ),

      bottomNavigationBar: Container(
        height: 60,
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 18,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Icon(
              Icons.home_filled,
              color: darkBrownColor,
              size: 28,
            ),
            IconButton(
              icon: const Icon(
                Icons.add_circle,
                color: darkBrownColor,
                size: 40,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddPage()),
                );
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.person_outline_rounded,
                color: darkBrownColor,
                size: 28,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}