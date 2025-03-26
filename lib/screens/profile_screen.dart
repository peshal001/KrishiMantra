import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart'; // Firebase Database package
import 'package:firebase_core/firebase_core.dart'; // Firebase Core package
import 'package:firebase_auth/firebase_auth.dart'; // Firebase Authentication package
import 'package:kri/screens/disease_detection_screen.dart';
import 'package:kri/screens/login_screen.dart'; // Navigate to login screen
import 'package:kri/screens/home_screen.dart'; // Import Home Screen (you can adjust it according to your app's structure)

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
  String uid = "YPmv8tk7SmWOQz88AsT2prPtVKe2";
  String username = "Peshal Bastola";
  String firstName = "Peshal";
  String lastName = "Bastola";
  String email = "peshalb123@gmail.com";
  String phoneNumber = "9860173773";

  // Bottom Navigation Bar Index
  int _currentNavIndex = 0;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  // Fetch user data from Firebase Realtime Database
  Future<void> _fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userId = user.uid;

      // Fetch data from Firebase Database
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

  // Handle bottom navigation item tap
  void _onBottomNavItemTapped(int index) {
    setState(() {
      _currentNavIndex = index;
    });

    // Navigate based on the selected index
    switch (index) {
      case 0:
        // Navigate to Home Screen
        Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
        break;
      case 1:
        // Navigate to Scan Crops Screen
        Navigator.push(context, MaterialPageRoute(builder: (context) => const DiseaseDetectionScreen()));
        break;
      case 2:
        // Navigate to Ask AI Screen
        Navigator.push(context, MaterialPageRoute(builder: (context) => const DiseaseDetectionScreen()));
        break;
      case 3:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen()));
        break;
      case 4:
        // Navigate to Help Screen
        Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
        break;
    }
  }

  // Profile UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Add functionality for the edit button if needed
            },
          ),
        ],
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
                    // Sign out and navigate to Login Screen
                    FirebaseAuth.instance.signOut();
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
      // Add Bottom Navigation Bar
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  // Bottom Navigation Bar Widget
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
}
