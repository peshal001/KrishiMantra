import 'package:flutter/material.dart';

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
      "url": "https://example.com/crops-nepal"
    },
    {
      "title": "Organic Farming Techniques",
      "description": "A complete guide to organic farming and its benefits.",
      "url": "https://example.com/organic-farming"
    },
    {
      "title": "Common Crop Diseases & Prevention",
      "description": "Identify common crop diseases and how to prevent them.",
      "url": "https://example.com/crop-diseases"
    },
    {
      "title": "Efficient Water Management",
      "description": "Tips on saving water and improving irrigation techniques.",
      "url": "https://example.com/water-management"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Knowledge Hub"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: articles.length,
          itemBuilder: (context, index) {
            final article = articles[index];
            return Card(
              elevation: 3,
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                leading: const Icon(Icons.book, color: Colors.green),
                title: Text(article["title"]!, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(article["description"]!),
                trailing: IconButton(
                  icon: const Icon(Icons.open_in_new, color: Colors.blue),
                  onPressed: () {
                    // Open the article URL
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
