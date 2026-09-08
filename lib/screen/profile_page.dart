import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            const CircleAvatar(
              radius: 45,
              backgroundImage: AssetImage('Assets/hi.jpeg'),
            ),
            const SizedBox(height: 12),
            const Text(
              "John Doe",
              style: TextStyle(
                color: Color(0xFF4A2518),
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              "Food enthusiast and home cook.",
              style: TextStyle(fontSize: 15, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            const Card(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text("2", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        Text("Recipes", style: TextStyle(color: Colors.grey, fontSize: 13)),
                      ],
                    ),
                    Column(
                      children: [
                        Text("1", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        Text("Approved", style: TextStyle(color: Colors.grey, fontSize: 13)),
                      ],
                    ),
                    Column(
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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EditProfilePage()),
                );
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
            const Card(
              color: Colors.white,
              child: ListTile(
                title: Text("Kacchi Biryani"),
                trailing: Text(
                  "Approved",
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const Card(
              color: Colors.white,
              child: ListTile(
                title: Text("Pasta"),
                trailing: Text(
                  "Pending",
                  style: TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

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
            const TextField(),
            const SizedBox(height: 20),
            const Text(
              "Bio",
              style: TextStyle(
                color: Color(0xFF4A2518),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const TextField(
              maxLines: 4,
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
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
