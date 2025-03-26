import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kri/screens/login_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile Screen',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Firebase Firestore reference
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Profile data variables
  String uid = "Loading...";
  String username = "Loading...";
  String firstName = "Loading...";
  String lastName = "Loading...";
  String email = "Loading...";
  String phoneNumber = "Loading...";

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  // Fetch user data from Firestore
  Future<void> _fetchUserData() async {
    String userId = "sampleUserId"; // Replace with actual UID (e.g., from FirebaseAuth)
    DocumentSnapshot userSnapshot = await _firestore.collection('users').doc(userId).get();

    if (userSnapshot.exists) {
      setState(() {
        uid = userSnapshot['uid'] ?? "Not Available";
        username = userSnapshot['username'] ?? "Not Available";
        firstName = userSnapshot['firstName'] ?? "Not Available";
        lastName = userSnapshot['lastName'] ?? "Not Available";
        email = userSnapshot['email'] ?? "Not Available";
        phoneNumber = userSnapshot['phoneNumber'] ?? "Not Available";
      });
    } else {
      print('User not found');
    }
  }

  // Widget to display each profile field
  Widget _buildProfileField(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(value, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  // Profile UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Image Section
              Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage("assets/images/logo.png"),
                  backgroundColor: Colors.grey[200],
                ),
              ),
              const SizedBox(height: 20),
              // UID Section
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: _buildProfileField("UID", uid),
                ),
              ),
              const SizedBox(height: 10),
              // Username Section
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: _buildProfileField("Username", username),
                ),
              ),
              const SizedBox(height: 10),
              // First Name Section
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: _buildProfileField("First Name", firstName),
                ),
              ),
              const SizedBox(height: 10),
              // Last Name Section
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: _buildProfileField("Last Name", lastName),
                ),
              ),
              const SizedBox(height: 10),
              // Email Section
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: _buildProfileField("Email", email),
                ),
              ),
              const SizedBox(height: 10),
              // Phone Number Section
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: _buildProfileField("Phone Number", phoneNumber),
                ),
              ),
              const SizedBox(height: 20),
              // Edit Profile Button
              Center(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.edit),
                  label: const Text("Logout"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
