import 'package:flutter/material.dart';
import 'search_page.dart';
import 'profile_page.dart';
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

  bool isLiked = false;

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
                //menu button
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
          // top title
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
                    MaterialPageRoute(builder: (context) => SearchPage()),
                  );
                },
              ),
            ),
          ),
        ],
      ),

      body: ListView(
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

          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      RecipePage(title: 'Recipe 1', isLiked: isLiked),
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
                  Container(
                    height: 160,
                    decoration: const BoxDecoration(
                      color: Color(0xFFECE7DF),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.restaurant_menu_rounded,
                        size: 48,
                        color: Color(0xFF9E978E),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 12.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Recipe 1',
                          style: TextStyle(
                            color: darkBrownColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'serif',
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            isLiked
                                ? Icons.favorite
                                : Icons.favorite_border_rounded,
                            color: isLiked ? Colors.redAccent : darkBrownColor,
                          ),
                          onPressed: () {
                            setState(() {
                              isLiked = !isLiked;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: Container(
        height: 60,
        decoration: BoxDecoration(
          // bottomnavigation border box
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 18,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Icon(
              // Home Icon
              Icons.home_filled,
              color: darkBrownColor,
              size: 28,
            ),
            const Icon(
              // Add Icon
              Icons.add_circle,
              color: darkBrownColor,
              size: 40,
            ),
            IconButton(
              // Profile Icon
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
