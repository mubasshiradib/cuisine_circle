import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/recipe_model.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _procedureController = TextEditingController();

  final List<TextEditingController> _ingredientControllers = [
    TextEditingController(),
  ];
  final List<TextEditingController> _quantityControllers = [
    TextEditingController(),
  ];

  XFile? _selectedImage;

  bool _isLoading = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _procedureController.dispose();
    for (var c in _ingredientControllers) {
      c.dispose();
    }
    for (var c in _quantityControllers) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = pickedFile;
      });
    }
  }

  void _addIngredientRow() {
    setState(() {
      _ingredientControllers.add(TextEditingController());
      _quantityControllers.add(TextEditingController());
    });
  }

  void _removeIngredientRow(int index) {
    if (_ingredientControllers.length > 1) {
      setState(() {
        _ingredientControllers[index].dispose();
        _quantityControllers[index].dispose();
        _ingredientControllers.removeAt(index);
        _quantityControllers.removeAt(index);
      });
    }
  }

  Future<void> _submitRecipe() async {
    // Validation: Title cannot be empty
    if (_titleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a recipe title')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      List<String> ingredients = [];
      for (int i = 0; i < _ingredientControllers.length; i++) {
        String name = _ingredientControllers[i].text.trim();
        String qty = _quantityControllers[i].text.trim();
        if (name.isNotEmpty) {
          ingredients.add(qty.isNotEmpty ? '$qty $name' : name);
        }
      }

      final docRef = FirebaseFirestore.instance.collection('recipes').doc();
      final recipe = Recipe(
        id: docRef.id,
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        imageUrl: '',
        ingredients: ingredients,
        procedure: _procedureController.text.trim(),
      );

      await docRef.set(recipe.toMap());

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Recipe added successfully!')),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error saving recipe: $e')));
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
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
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: SizedBox(
                  height: 150,
                  width: double.infinity,
                  child: _selectedImage != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            _selectedImage!.path,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        )
                      : const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.camera_alt,
                              color: Color(0xFF4A2518),
                              size: 45,
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Tap to select recipe photo',
                              style: TextStyle(color: Color(0xFF4A2518)),
                            ),
                          ],
                        ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Recipe Title',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        hintText: 'e.g. Chicken Biryani',
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Description',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _descriptionController,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        hintText: 'A short description of this dish...',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Ingredients',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.add_circle,
                            color: Color(0xFF4A2518),
                          ),
                          onPressed: _addIngredientRow,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    for (int i = 0; i < _ingredientControllers.length; i++)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _ingredientControllers[i],
                                decoration: const InputDecoration(
                                  hintText: 'Ingredient (e.g. Flour)',
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            SizedBox(
                              width: 90,
                              child: TextField(
                                controller: _quantityControllers[i],
                                decoration: const InputDecoration(
                                  hintText: 'Qty (e.g. 2 cups)',
                                ),
                              ),
                            ),
                            if (_ingredientControllers.length > 1)
                              IconButton(
                                icon: const Icon(
                                  Icons.remove_circle,
                                  color: Colors.red,
                                ),
                                onPressed: () => _removeIngredientRow(i),
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
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Cooking Steps',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _procedureController,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        hintText:
                            '1. Chop onions...\n2. Cook chicken on medium heat...',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4A2518),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 14,
                ),
              ),
              onPressed: _isLoading ? null : _submitRecipe,
              child: _isLoading
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2.5,
                      ),
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
