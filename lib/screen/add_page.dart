import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController stepsController = TextEditingController();

  List<TextEditingController> ingredientControllers = [TextEditingController()];
  List<TextEditingController> qtyControllers = [TextEditingController()];

  bool isSubmitting = false;

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    stepsController.dispose();
    for (var controller in ingredientControllers) {
      controller.dispose();
    }
    for (var controller in qtyControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF4F2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAF4F2),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Add New Recipe',
          style: TextStyle(
            color: Color(0xFF4A2518),
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.close, color: Color(0xFF4A2518)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Card(
              color: Colors.white,
              child: SizedBox(
                height: 130,
                width: double.infinity,
                child: Icon(Icons.camera_alt, color: Color(0xFF4A2518), size: 45),
              ),
            ),
            const SizedBox(height: 16),

            Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Recipe Title', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    TextField(controller: titleController),
                    const SizedBox(height: 16),
                    const Text('Description', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    TextField(controller: descController, maxLines: 3),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Ingredients', style: TextStyle(fontWeight: FontWeight.bold)),
                        IconButton(
                          icon: const Icon(Icons.add_circle, color: Color(0xFF4A2518)),
                          onPressed: () {
                            setState(() {
                              ingredientControllers.add(TextEditingController());
                              qtyControllers.add(TextEditingController());
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    for (int i = 0; i < ingredientControllers.length; i++)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(controller: ingredientControllers[i]),
                            ),
                            const SizedBox(width: 8),
                            SizedBox(
                              width: 80,
                              child: TextField(controller: qtyControllers[i]),
                            ),
                            if (ingredientControllers.length > 1)
                              IconButton(
                                icon: const Icon(Icons.remove_circle, color: Colors.red),
                                onPressed: () {
                                  setState(() {
                                    ingredientControllers.removeAt(i).dispose();
                                    qtyControllers.removeAt(i).dispose();
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
            const SizedBox(height: 16),

            Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Cooking Steps', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    TextField(controller: stepsController, maxLines: 4),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4A2518),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
              ),
              onPressed: isSubmitting
                  ? null
                  : () async {
                if (titleController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter a recipe title!')),
                  );
                  return;
                }

                setState(() => isSubmitting = true);

                try {
                  // 1. Get logged-in user ID
                  final user = FirebaseAuth.instance.currentUser;

                  // 2. Save recipe linked to this user's UID
                  await FirebaseFirestore.instance.collection('recipes').add({
                    'title': titleController.text.trim(),
                    'description': descController.text.trim(),
                    'steps': stepsController.text.trim(),
                    'status': 'Pending',
                    'userId': user?.uid ?? 'guest_user',
                    'authorName': user?.displayName ?? 'Chef',
                    'createdAt': FieldValue.serverTimestamp(),
                  });

                  if (context.mounted) {
                    showDialog(
                      context: context,
                      builder: (dialogContext) => AlertDialog(
                        title: const Text('Success'),
                        content: const Text('Recipe saved to your profile!'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(dialogContext);
                              Navigator.pop(context);
                            },
                            child: const Text('OK', style: TextStyle(color: Color(0xFF4A2518))),
                          ),
                        ],
                      ),
                    );
                  }
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error saving recipe: $e')),
                    );
                  }
                } finally {
                  if (mounted) setState(() => isSubmitting = false);
                }
              },
              child: isSubmitting
                  ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
              )
                  : const Text('Submit Recipe', style: TextStyle(fontSize: 16)),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}