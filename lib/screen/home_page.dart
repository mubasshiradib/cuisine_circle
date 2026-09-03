import 'package:flutter/material.dart';
import 'search_page.dart';

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
              decoration: const BoxDecoration(    //menu button
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
        title: const Text(    // top title
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

      body: const Center(
        child: Text(
          'Content area (Recipes go here)',
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
      ),

      bottomNavigationBar: Container(
        height: 60,
        decoration: BoxDecoration(  // bottomnavigation border box
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 18,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(                 // Home Icon
              Icons.home_filled,
              color: darkBrownColor,
              size: 28,
            ),
            Icon(                  // Add Icon
              Icons.add_circle,
              color: darkBrownColor,
              size: 40,
            ),
            Icon(                  // Profile Icon
              Icons.person_outline_rounded,
              color: darkBrownColor,
              size: 28,
            ),
          ],
        ),
      ),
    );
  }
}
