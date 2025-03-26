import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kri/services/ai_model_service.dart';
import 'package:kri/screens/home_screen.dart'; // Import your HomeScreen
import 'package:kri/screens/profile_screen.dart'; // Import ProfileScreen

class DiseaseDetectionScreen extends StatefulWidget {
  const DiseaseDetectionScreen({super.key});

  @override
  _DiseaseDetectionScreenState createState() => _DiseaseDetectionScreenState();
}

class _DiseaseDetectionScreenState extends State<DiseaseDetectionScreen> {
  File? _image;
  String _result = "No detection yet.";
  bool _isLoading = false;
  final ImagePicker _picker = ImagePicker();
  final AIModelService _aiModelService = AIModelService();

  int _currentNavIndex = 1; // Default is DiseaseDetectionScreen

  @override
  void initState() {
    super.initState();
    _aiModelService.loadModels(); // Ensure models are loaded
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _result = "Analyzing...";
      });
      await _detectDisease(pickedFile);
    }
  }

  Future<void> _detectDisease(XFile imageFile) async {
    setState(() => _isLoading = true);
    String detectionResult = await _aiModelService.detectDisease(imageFile);
    setState(() {
      _result = detectionResult;
      _isLoading = false;
    });
  }

  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _currentNavIndex,
      selectedItemColor: Colors.green, // Active color
      unselectedItemColor: Colors.grey, // Inactive color
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
    if (_currentNavIndex == index) return; // Prevent reloading the same screen

    setState(() {
      _currentNavIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const HomeScreen()));
        break;
      case 1:
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const DiseaseDetectionScreen()));
        break;
      case 2:
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const ProfileScreen()));
        break;
      case 3:
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const ProfileScreen()));
        break;
      case 4:
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const ProfileScreen()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Disease Detection"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image == null
                ? const Icon(Icons.image, size: 100, color: Colors.grey)
                : Image.file(_image!, height: 250),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : Text(
                    _result,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () => _pickImage(ImageSource.gallery),
                  icon: const Icon(Icons.photo_library),
                  label: const Text("Gallery"),
                ),
                const SizedBox(width: 20),
                ElevatedButton.icon(
                  onPressed: () => _pickImage(ImageSource.camera),
                  icon: const Icon(Icons.camera_alt),
                  label: const Text("Camera"),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }
}
