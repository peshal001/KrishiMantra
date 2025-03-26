import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart'; // Firebase Database package
import 'package:firebase_core/firebase_core.dart'; // Firebase Core package
import 'package:kri/screens/login_screen.dart'; // Navigate to login screen

void main() async {
  // Ensure Firebase is initialized before the app starts
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

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
  // Firebase Database reference
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

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

  // Fetch user data from Firebase Realtime Database
  Future<void> _fetchUserData() async {
    String userId = "sampleUserId"; // Replace with actual UID (e.g., from FirebaseAuth)

    _database.child('users').child(userId).once().then((DatabaseEvent event) {
      if (event.snapshot.exists) {
        Map<dynamic, dynamic> userData = event.snapshot.value as Map<dynamic, dynamic>;

        setState(() {
          uid = userData['uid'] ?? "Not Available";
          username = userData['username'] ?? "Not Available";
          firstName = userData['firstName'] ?? "Not Available";
          lastName = userData['lastName'] ?? "Not Available";
          email = userData['email'] ?? "Not Available";
          phoneNumber = userData['phoneNumber'] ?? "Not Available";
        });
      } else {
        print('User not found');
      }
    }).catchError((error) {
      print('Error fetching user data: $error');
    });
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
                  backgroundImage: AssetImage("assets/user/user.png"),
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
              // Logout Button
              Center(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.exit_to_app),
                  label: const Text("Logout"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                  onPressed: () {
                    // Navigate to LoginScreen (replace with your own navigation)
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
