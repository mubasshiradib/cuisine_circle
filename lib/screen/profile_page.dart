import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // 1. Gets the logged-in user from Firebase Authentication
  User? currentUser = FirebaseAuth.instance.currentUser;

  late String name;
  String bio = "Food enthusiast and home cook.";

  @override
  void initState() {
    super.initState();
    // Safely reads display name, email prefix, or fallback
    if (currentUser?.displayName != null && currentUser!.displayName!.trim().isNotEmpty) {
      name = currentUser!.displayName!;
    } else if (currentUser?.email != null && currentUser!.email!.isNotEmpty) {
      name = currentUser!.email!.split('@')[0];
    } else {
      name = "My Profile";
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
          "My Profile",
          style: TextStyle(
            color: Color(0xFF4A2518),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      // StreamBuilder listens to Firestore without blocking the whole screen
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('recipes').snapshots(),
        builder: (context, snapshot) {
          final bool isLoading = snapshot.connectionState == ConnectionState.waiting;
          final recipes = snapshot.data?.docs ?? [];
          final int approvedCount = recipes.where((doc) => doc['status'] == 'Approved').length;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 10),

                // 1. User Photo (Always visible immediately)
                const CircleAvatar(
                  radius: 45,
                  backgroundImage: AssetImage('Assets/hi.jpeg'),
                ),
                const SizedBox(height: 12),

                // 2. Registered User Name (Always visible immediately)
                Text(
                  name,
                  style: const TextStyle(
                    color: Color(0xFF4A2518),
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),

                // 3. Bio (Always visible immediately)
                Text(
                  bio,
                  style: const TextStyle(fontSize: 15, color: Colors.grey),
                ),
                const SizedBox(height: 20),

                // Stats Row
                Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              isLoading ? "..." : "${recipes.length}",
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            const Text("Recipes", style: TextStyle(color: Colors.grey, fontSize: 13)),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              isLoading ? "..." : "$approvedCount",
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            const Text("Approved", style: TextStyle(color: Colors.grey, fontSize: 13)),
                          ],
                        ),
                        const Column(
                          children: [
                            Text("142", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                            Text("Likes", style: TextStyle(color: Colors.grey, fontSize: 13)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // 4. Edit Profile Button
                ElevatedButton(
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProfilePage(
                          currentName: name,
                          currentBio: bio,
                        ),
                      ),
                    );

                    if (result != null) {
                      setState(() {
                        name = result['name'];
                        bio = result['bio'];
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4A2518),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("Edit Profile"),
                ),
                const SizedBox(height: 24),

                // 5. Section Header
                const Row(
                  children: [
                    Text(
                      "My Recipes",
                      style: TextStyle(
                        color: Color(0xFF4A2518),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Case 1: Firebase Error (Shows error message clearly in red)
                if (snapshot.hasError)
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      "Firebase Error: ${snapshot.error}",
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  )

                // Case 2: Still Loading Recipes from Cloud
                else if (isLoading)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24.0),
                    child: CircularProgressIndicator(color: Color(0xFF4A2518)),
                  )

                // Case 3: Connected, but no recipes created yet
                else if (recipes.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.0),
                      child: Text(
                        "No recipes added yet.",
                        style: TextStyle(color: Colors.grey),
                      ),
                    )

                  // Case 4: Real Cloud Data Loaded Successfully
                  else
                    for (var doc in recipes)
                      Card(
                        color: Colors.white,
                        child: ListTile(
                          title: Text(doc['title'] ?? ''),
                          trailing: Text(
                            doc['status'] ?? 'Pending',
                            style: TextStyle(
                              color: doc['status'] == 'Approved' ? Colors.green : Colors.orange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class EditProfilePage extends StatefulWidget {
  final String currentName;
  final String currentBio;

  const EditProfilePage({
    super.key,
    required this.currentName,
    required this.currentBio,
  });

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController nameController;
  late TextEditingController bioController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.currentName);
    bioController = TextEditingController(text: widget.currentBio);
  }

  @override
  void dispose() {
    nameController.dispose();
    bioController.dispose();
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
          "Edit Profile",
          style: TextStyle(
            color: Color(0xFF4A2518),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Name",
              style: TextStyle(
                color: Color(0xFF4A2518),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextField(controller: nameController),
            const SizedBox(height: 20),
            const Text(
              "Bio",
              style: TextStyle(
                color: Color(0xFF4A2518),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextField(controller: bioController, maxLines: 4),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, {
                    'name': nameController.text,
                    'bio': bioController.text,
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4A2518),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                ),
                child: const Text("Save Changes"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}