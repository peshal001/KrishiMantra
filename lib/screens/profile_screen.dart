import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Sample profile data
  String name = "Ram Kumar";
  String location = "Chitwan, Nepal";
  String contact = "+977 9801234567";
  String email = "ram.kumar@example.com";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Profile"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Personal Information",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ListTile(
              title: const Text("Name", style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(name),
            ),
            ListTile(
              title: const Text("Location", style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(location),
            ),
            ListTile(
              title: const Text("Contact", style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(contact),
            ),
            ListTile(
              title: const Text("Email", style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(email),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.edit),
                label: const Text("Edit Profile"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                onPressed: () {
                  // Implement profile editing
                },
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.logout),
                label: const Text("Logout"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                onPressed: () {
                  // Implement logout functionality
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
