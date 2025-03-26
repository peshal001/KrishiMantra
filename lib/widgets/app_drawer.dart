import 'package:flutter/material.dart';
import 'package:kri/screens/home_screen.dart';
import 'package:kri/screens/crop_recommendation_screen.dart';
import 'package:kri/screens/disease_detection_screen.dart';
import 'package:kri/screens/market_screen.dart';
import 'package:kri/screens/knowledge_hub_screen.dart';
import 'package:kri/screens/profile_screen.dart';
import 'package:kri/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          // Header
          UserAccountsDrawerHeader(
            accountName: Text('Farmer Name'), // Replace with user's name
            accountEmail: Text('farmer@example.com'), // Replace with user's email
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, size: 50.0),
            ),
          ),
          
          // Navigation options
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.grain),
            title: Text('Crop Recommendation'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => CropRecommendationScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.health_and_safety),
            title: Text('Disease Detection'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => DiseaseDetectionScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.store),
            title: Text('Market'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MarketScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.school),
            title: Text('Knowledge Hub'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => KnowledgeHubScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Profile'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
          ),
          
          // Logout button
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
