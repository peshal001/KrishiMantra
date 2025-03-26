import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class KnowledgeHubScreen extends StatefulWidget {
  const KnowledgeHubScreen({super.key});

  @override
  _KnowledgeHubScreenState createState() => _KnowledgeHubScreenState();
}

class _KnowledgeHubScreenState extends State<KnowledgeHubScreen> {
  // Sample articles and guides
  final List<Map<String, String>> articles = [
    {
      "title": "Best Crops for Nepal's Climate",
      "description": "Learn about the best crops to grow in different regions of Nepal.",
      "url": "https://example.com/crops-nepal",
      "image": "assets/images/crops.jpg"
    },
    {
      "title": "Organic Farming Techniques",
      "description": "A complete guide to organic farming and its benefits.",
      "url": "https://example.com/organic-farming",
      "image": "assets/images/organic.jpg"
    },
    {
      "title": "Common Crop Diseases & Prevention",
      "description": "Identify common crop diseases and how to prevent them.",
      "url": "https://example.com/crop-diseases",
      "image": "assets/images/diseases.jpg"
    },
    {
      "title": "Efficient Water Management",
      "description": "Tips on saving water and improving irrigation techniques.",
      "url": "https://example.com/water-management",
      "image": "assets/images/water.jpg"
    },
    {
      "title": "Smart Farming with Technology",
      "description": "How AI and IoT are transforming modern agriculture.",
      "url": "https://example.com/smart-farming",
      "image": "assets/images/smart_farming.jpg"
    }
  ];

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Could not open the link")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Knowledge Hub", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: articles.length,
          itemBuilder: (context, index) {
            final article = articles[index];
            return Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                    child: Image.asset(
                      article["image"]!,
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          article["title"]!,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          article["description"]!,
                          style: const TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        const SizedBox(height: 8),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton.icon(
                            onPressed: () => _launchURL(article["url"]!),
                            icon: const Icon(Icons.open_in_new, color: Colors.blue),
                            label: const Text("Read More", style: TextStyle(color: Colors.blue)),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}