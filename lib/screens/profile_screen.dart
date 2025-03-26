import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:kri/screens/disease_detection_screen.dart';
import 'package:kri/screens/login_screen.dart';
import 'package:kri/screens/home_screen.dart';

void main() async {
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
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  String uid = "YPmv8tk7SmWOQz88AsT2prPtVKe2";
  String username = "Peshal Bastola";
  String firstName = "Peshal";
  String lastName = "Bastola";
  String email = "peshalb123@gmail.com";
  String phoneNumber = "9860173773";
  int _currentNavIndex = 0;
  
  // Image picker
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userId = user.uid;
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
    } else {
      print("No user is logged in");
    }
  }

  // Function to pick an image from the gallery
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  Widget _buildProfileField(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text(value, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Image with Editable Functionality
              Center(
                child: GestureDetector(
                  onTap: _pickImage,
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: _profileImage != null
                            ? FileImage(_profileImage!)
                            : const AssetImage("assets/user/user.png") as ImageProvider,
                        backgroundColor: Colors.grey[200],
                      ),
                      const CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.camera_alt, color: Colors.green),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Profile Fields
              _buildProfileCard("UID", uid),
              _buildProfileCard("Username", username),
              _buildProfileCard("First Name", firstName),
              _buildProfileCard("Last Name", lastName),
              _buildProfileCard("Email", email),
              _buildProfileCard("Phone Number", phoneNumber),
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
                    FirebaseAuth.instance.signOut();
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildProfileCard(String title, String value) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _buildProfileField(title, value),
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _currentNavIndex,
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.grey,
      onTap: _onBottomNavItemTapped,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.qr_code_scanner), label: "Scan Crops"),
        BottomNavigationBarItem(icon: Icon(Icons.smart_toy), label: "Ask AI"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Account"),
        BottomNavigationBarItem(icon: Icon(Icons.help), label: "Help"),
      ],
    );
  }

  void _onBottomNavItemTapped(int index) {
    setState(() {
      _currentNavIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
        break;
      case 1:
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const DiseaseDetectionScreen()));
        break;
      case 3:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen()));
        break;
      case 4:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
        break;
    }
  }
}
