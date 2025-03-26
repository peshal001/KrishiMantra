import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  String userName = "Farmer";
  bool _isLoading = true;
  int _expertCurrentIndex = 0;
  int _premiumCurrentIndex = 0;

  final List<String> _expertBanners = [
    "assets/images/logo.png",
    "assets/images/logo.png",
    "assets/images/logo.png"
  ];

  final List<String> _premiumBanners = [
    "assets/images/logo.png",
    "assets/images/logo.png",
    "assets/images/logo.png"
  ];

  final List<Map<String, dynamic>> _features = [
    {"title": "Manage Crop", "icon": Icons.agriculture},
    {"title": "Crop Health", "icon": Icons.healing},
    {"title": "Expert Advice", "icon": Icons.support_agent},
    {"title": "Weather Forecasts", "icon": Icons.wb_sunny},
    {"title": "Market Insights", "icon": Icons.store},
    {"title": "Buy Supplies", "icon": Icons.shopping_cart},
    {"title": "Sell Your Produce", "icon": Icons.sell},
    {"title": "AI Assistance", "icon": Icons.smart_toy},
  ];

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
    _fetchUserName();
  }

  Future<void> _fetchUserName() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(_user?.uid)
          .get();
      if (snapshot.exists) {
        setState(() {
          userName = snapshot['username'] ?? 'Farmer';
        });
      }
    } catch (e) {
      debugPrint("Error fetching user data: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _isLoading ? _buildLoadingIndicator() : _buildMainContent(),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.green.shade700,
      title: Text("Welcome, $userName!", style: const TextStyle(fontSize: 18)),
        actions: [
        IconButton(icon: const Icon(Icons.notifications), onPressed: () {}),
        CircleAvatar(backgroundImage: AssetImage("assets/images/logo.png")),
        const SizedBox(width: 10),
      ],
    );
  }

  Widget _buildLoadingIndicator() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildMainContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSlider(_expertBanners, _expertCurrentIndex, (index) {
            setState(() => _expertCurrentIndex = index);
          }),
          _buildDotsIndicator(_expertBanners.length, _expertCurrentIndex),
          const SizedBox(height: 20),
          _buildSectionTitle("Features"),
          _buildFeatureGrid(),
          const SizedBox(height: 20),
          _buildSectionTitle("Why KrishiMantra?"),
          _buildWhyKrishiMantra(),
          const SizedBox(height: 20),
          _buildSectionTitle("Premium Plus"),
          _buildSlider(_premiumBanners, _premiumCurrentIndex, (index) {
            setState(() => _premiumCurrentIndex = index);
          }),
          _buildDotsIndicator(_premiumBanners.length, _premiumCurrentIndex),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(title, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green.shade800));
  }

  Widget _buildSlider(List<String> images, int currentIndex, Function(int) onPageChanged) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        height: 180,
        enlargeCenterPage: true,
        onPageChanged: (index, reason) => onPageChanged(index),
      ),
      items: images.map((img) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(img, fit: BoxFit.cover, width: double.infinity),
        );
      }).toList(),
    );
  }

  Widget _buildDotsIndicator(int length, int currentIndex) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(length, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          width: currentIndex == index ? 12 : 8,
          height: currentIndex == index ? 12 : 8,
          decoration: BoxDecoration(
            color: currentIndex == index ? Colors.green : Colors.grey,
            shape: BoxShape.circle,
          ),
        );
      }),
    );
  }

  Widget _buildFeatureGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1,
      ),
      itemCount: _features.length,
      itemBuilder: (context, index) {
        final item = _features[index];
        return _buildFeatureCard(item["title"], item["icon"]);
      },
    );
  }

  Widget _buildFeatureCard(String title, IconData icon) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 6,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 50, color: Colors.green.shade700),
          const SizedBox(height: 10),
          Text(title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  // Updated Why KrishiMantra section
  Widget _buildWhyKrishiMantra() {
    final List<Map<String, dynamic>> whyKrishiMantraFeatures = [
      {"title": "Smart Insights", "icon": Icons.lightbulb, "description": "Get AI-powered insights for smarter farming."},
      {"title": "Marketplace", "icon": Icons.store, "description": "Access a wide network of buyers and sellers."},
      {"title": "Expert Consultation", "icon": Icons.support_agent, "description": "Connect with agricultural experts for advice."},
      {"title": "Weather Forecast", "icon": Icons.wb_sunny, "description": "Stay updated with accurate weather forecasts."},
      {"title": "Disease Detection", "icon": Icons.healing, "description": "Detect and manage crop diseases with AI assistance."},
      {"title": "Crop Recommendation", "icon": Icons.agriculture, "description": "Get crop suggestions based on the season and region."},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1,
      ),
      itemCount: whyKrishiMantraFeatures.length,
      itemBuilder: (context, index) {
        final feature = whyKrishiMantraFeatures[index];
        return _buildWhyKrishiMantraCard(feature["title"], feature["icon"], feature["description"]);
      },
    );
  }

  Widget _buildWhyKrishiMantraCard(String title, IconData icon, String description) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 6,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 50, color: Colors.green.shade700),
          const SizedBox(height: 10),
          Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.grey,
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
