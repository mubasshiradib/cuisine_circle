import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? currentUser = FirebaseAuth.instance.currentUser;

  late String name;
  String phoneNumber = "";
  String bio = "Food enthusiast and home cook.";

  @override
  void initState() {
    super.initState();
    if (currentUser?.displayName != null && currentUser!.displayName!.trim().isNotEmpty) {
      name = currentUser!.displayName!;
    } else if (currentUser?.email != null && currentUser!.email!.isNotEmpty) {
      name = currentUser!.email!.split('@')[0];
    } else {
      name = "My Profile";
    }

    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    if (currentUser != null) {
      try {
        final doc = await FirebaseFirestore.instance.collection('users').doc(currentUser!.uid).get();
        if (doc.exists && mounted) {
          final data = doc.data();
          setState(() {
            if (data?['name'] != null && data!['name'].toString().isNotEmpty) {
              name = data['name'];
            }
            if (data?['phoneNumber'] != null) {
              phoneNumber = data!['phoneNumber'];
            }
          });
        }
      } catch (_) {}
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
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('recipes')
            .where('userId', isEqualTo: currentUser?.uid ?? '')
            .snapshots(),
        builder: (context, snapshot) {
          final bool isLoading = snapshot.connectionState == ConnectionState.waiting;
          final recipes = snapshot.data?.docs ?? [];

          final int approvedCount = recipes.where((doc) {
            final data = doc.data() as Map<String, dynamic>?;
            return data != null && data['status'] == 'Approved';
          }).length;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 10),

                const CircleAvatar(
                  radius: 45,
                  backgroundImage: AssetImage('Assets/hi.jpeg'),
                ),
                const SizedBox(height: 12),

                Text(
                  name,
                  style: const TextStyle(
                    color: Color(0xFF4A2518),
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),

                if (phoneNumber.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.phone, size: 16, color: Colors.grey),
                        const SizedBox(width: 6),
                        Text(
                          phoneNumber,
                          style: const TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),

                Text(
                  bio,
                  style: const TextStyle(fontSize: 15, color: Colors.grey),
                ),
                const SizedBox(height: 20),

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

                if (snapshot.hasError)
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      "Firebase Error: ${snapshot.error}",
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  )
                else if (isLoading)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24.0),
                    child: CircularProgressIndicator(color: Color(0xFF4A2518)),
                  )
                else if (recipes.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.0),
                      child: Text(
                        "No recipes added yet.",
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  else
                    for (var doc in recipes) ...[
                      Builder(
                        builder: (context) {
                          final data = doc.data() as Map<String, dynamic>? ?? {};
                          final title = (data['title'] as String?)?.isNotEmpty == true
                              ? data['title'] as String
                              : 'Untitled Recipe';
                          final status = data['status'] as String? ?? 'Pending';
                          final isApproved = status == 'Approved';

                          return Card(
                            color: Colors.white,
                            margin: const EdgeInsets.only(bottom: 8.0),
                            child: ListTile(
                              title: Text(
                                title,
                                style: const TextStyle(fontWeight: FontWeight.w600),
                              ),
                              trailing: Text(
                                status,
                                style: TextStyle(
                                  color: isApproved ? Colors.green : Colors.orange,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
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
