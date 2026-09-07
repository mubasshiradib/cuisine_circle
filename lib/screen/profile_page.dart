import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Profile")),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),

              // 1. User Photo
              const CircleAvatar(
                radius: 50,
                child: Icon(Icons.person, size: 50),
              ),

              // 2. Name
              const Text("John Doe",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold
                  )),
              const SizedBox(height: 30),

              // 3. Bio
              const Text("Food enthusiast and home cook.", style: TextStyle(fontSize: 16)),

              const SizedBox(height: 40),

              // 4. Edit Profile Button
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const EditProfilePage()),
                  );
                },
                child: const Text("Edit Profile"),
              ),

              const SizedBox(height: 30),
              const Text("My Recipes",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                  )),
              const SizedBox(height: 30),

              // First Recipe Card
              const SizedBox(
                width: 400,
                height: 55,
                child: Card(
                  elevation: 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Kacchi Biryani", style: TextStyle(fontSize: 16)),
                      Text("Approved",
                          style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 16
                          )),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Second Recipe Card
              const SizedBox(
                width: 400,
                height: 55,
                child: Card(
                  elevation: 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Pasta", style: TextStyle(fontSize: 16)),
                      Text("Pending",
                          style: TextStyle(
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                              fontSize: 16)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
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
      appBar: AppBar(title: const Text("Edit Profile")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Make changes here", style: TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Go back
              },
              child: const Text("Save/Back"),
            ),
          ],
        ),
      ),
    );
  }
}