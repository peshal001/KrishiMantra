import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:kri/screens/disease_detection_screen.dart';
import 'package:kri/screens/expert_consult_screen.dart';
import 'package:kri/screens/market_screen.dart';
import 'package:kri/screens/profile_screen.dart';

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
  int _currentNavIndex = 0;

  final List<String> _expertBanners = [
    "assets/banners/AI Crop Planning.png",
    "assets/banners/Market Price.png",
    "assets/banners/Weather Alerts.png"
  ];

  final List<String> _premiumBanners = [
    "assets/banners/Direct Chat.png",
    "assets/banners/Bundle Pricing.png",
    "assets/banners/Combo Pack.png"
  ];

  final List<Map<String, dynamic>> _features = [
    {"title": "Manage Crop", "icon": Icons.agriculture},
    {"title": "Crop Health", "icon": Icons.healing},
    {"title": "Expert Advice", "icon": Icons.support_agent, "screen": const ExpertConsultScreen()},
    {"title": "Weather Forecasts", "icon": Icons.wb_sunny},
    {"title": "Market Insights", "icon": Icons.store, "screen": const MarketScreen()},
    {"title": "Buy Supplies", "icon": Icons.shopping_cart},
    {"title": "Sell Your Produce", "icon": Icons.sell},
    {"title": "AI Assistance", "icon": Icons.smart_toy},
  ];

  final List<Map<String, String>> _whyKrishiMantra = [
    {"title": "AI-powered Insights", "description": "Smart farming recommendations with AI-driven data."},
    {"title": "Market Network", "description": "Connect with buyers and sellers across the country."},
    {"title": "Expert Consultation", "description": "Get professional advice from agricultural experts."},
    {"title": "Weather Forecasting", "description": "Accurate weather predictions for better planning."},
    {"title": "Disease Detection", "description": "Identify and treat crop diseases efficiently."},
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

  void _onFeatureTap(String title) {
    if (title == "Expert Advice") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ExpertConsultScreen()),
      );
    } else if (title == "Manage Crop") {
      // Navigate to Manage Crop screen
    } else if (title == "Crop Health") {
      // Navigate to Crop Health screen
    } else if (title == "Weather Forecasts") {
      // Navigate to Weather Forecasts screen
    } else if (title == "Market Insights") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MarketScreen()),
      );
    } else if (title == "Buy Supplies") {
      // Navigate to Buy Supplies screen
    } else if (title == "Sell Your Produce") {
      // Navigate to Sell Your Produce screen
    } else if (title == "AI Assistance") {
      // Navigate to AI Assistance screen
    }
  }

  void _onBottomNavItemTapped(int index) {
    setState(() {
      _currentNavIndex = index;
    });
    if (index == 0) {
      // Navigate to Home screen (if already on it, do nothing)
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const DiseaseDetectionScreen()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProfileScreen()),
      );
    } else if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProfileScreen()),
      );
    } else if (index == 4) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProfileScreen()),
      );
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
      title: Text("Welcome, $userName", style: const TextStyle(fontSize: 18)),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications),
          onPressed: () {},
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfileScreen()),
            );
          },
          child: CircleAvatar(
            backgroundImage: AssetImage("assets/user/user.png"),
          ),
        ),
        const SizedBox(width: 10),
      ],
    );
  }

  Widget _buildLoadingIndicator() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildMainContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
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
    return Text(
      title,
      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green.shade800),
    );
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
        return _buildFeatureCard(item["title"], item["icon"], item["screen"]);
      },
    );
  }

  Widget _buildFeatureCard(String title, IconData icon, Widget? screen) {
    return GestureDetector(
      onTap: () {
        if (screen != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => screen),
          );
        } else {
          _onFeatureTap(title);
        }
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 6,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: Colors.green.shade700),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWhyKrishiMantra() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _whyKrishiMantra.map((item) {
          return Container(
            margin: const EdgeInsets.only(right: 20),
            padding: const EdgeInsets.all(16),
            width: 250,
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(color: Colors.grey.shade300, blurRadius: 6, spreadRadius: 2),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['title']!,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  item['description']!,
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          );
        }).toList(),
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
}
