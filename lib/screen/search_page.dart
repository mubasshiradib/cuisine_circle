import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/recipe_model.dart';
import 'recepie_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController srch = TextEditingController();
  List<String> recipe = [
    'Chicken Biryani',
    'Chicken Curry',
    'Fried Rice',
    'Pasta',
    'Butter Chicken',
    'Chicken Tikka',
    'Vegetable Khichuri',
  ];
  List<String> recent = [];
  List<Recipe> result = []; // Recipe অবজেক্ট সংরক্ষণের জন্য
  bool found = false;

  // Firestore থেকে সার্চ করার মেথড
  Future<void> doSrch() async {
    String text = srch.text.trim();
    if (text.isEmpty) {
      return;
    }
    if (!recent.contains(text)) {
      recent.add(text);
    }

    final snapshot =
    await FirebaseFirestore.instance.collection('recipes').get();
    result.clear();

    for (var doc in snapshot.docs) {
      final data = doc.data();
      final title = data['title']?.toString() ?? '';
      if (title.toLowerCase().contains(text.toLowerCase())) {
        // HomePage-এর মতো সরাসরি fromMap দিয়ে অবজেক্ট তৈরি
        result.add(Recipe.fromMap(data, doc.id));
      }
    }

    setState(() {
      found = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.brown),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Image.asset('Assets/Logo_for_all_screen.png', height: 40),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.only(left: 16),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.brown),
              ),
              child: TextField(
                controller: srch,
                onSubmitted: (_) => doSrch(),
                decoration: InputDecoration(
                  hintText: 'Search for recipes',
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search, color: Colors.brown),
                    onPressed: doSrch,
                  ),
                ),
              ),
            ),
            if (recent.isNotEmpty) ...[
              const SizedBox(height: 20),
              const Text(
                'Recent Searches',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                ),
              ),
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (String i in recent)
                    Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.brown),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.history,
                              size: 16, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(i,
                              style: const TextStyle(color: Colors.brown)),
                          const SizedBox(width: 6),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                recent.remove(i);
                              });
                            },
                            child: const Icon(
                              Icons.close,
                              size: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ],
            const SizedBox(height: 20),
            const Text(
              'Popular searches in recipes',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.brown,
              ),
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (String i in recipe)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        srch.text = i;
                      });
                      doSrch();
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.brown),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.trending_up,
                            size: 16,
                            color: Colors.brown,
                          ),
                          const SizedBox(width: 4),
                          Text(i,
                              style: const TextStyle(color: Colors.brown)),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
            if (found) ...[
              const SizedBox(height: 20),
              const Text(
                'Search Results',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                ),
              ),
              const SizedBox(height: 10),
              if (result.isEmpty)
                const Text(
                  'No recipes found',
                  style: TextStyle(color: Colors.grey),
                )
              else
                for (Recipe r in result)
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RecipePage(
                            recipe: r,
                            isLiked: false,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.restaurant, color: Colors.brown),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              r.title,
                              style:
                              const TextStyle(color: Colors.brown),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
            ],
          ],
        ),
      ),
    );
  }
}