import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class KnowledgeHubScreen extends StatefulWidget {
  const KnowledgeHubScreen({super.key});

  @override
  _KnowledgeHubScreenState createState() => _KnowledgeHubScreenState();
}

class _KnowledgeHubScreenState extends State<KnowledgeHubScreen> {
  String selectedCategory = "All";

  final List<Map<String, String>> articles = [
    {
      "title": "Best Crops for Nepal's Climate",
      "description": "Learn about the best crops to grow in different regions of Nepal.",
      "url": "https://example.com/crops-nepal",
      "image": "assets/banners/AI Crop Planning.png",
      "category": "Farming"
    },
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
    final bool isWideScreen = MediaQuery.of(context).size.width > 600;
    final List<Map<String, String>> filteredArticles = selectedCategory == "All"
        ? articles
        : articles.where((article) => article["category"] == selectedCategory).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Knowledge Hub", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Category Filter Dropdown
            Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: DropdownButton<String>(
                value: selectedCategory,
                isExpanded: true,
                underline: const SizedBox(),
                items: ["All", "Farming", "Health", "Water", "Technology"].map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category, style: const TextStyle(fontSize: 16)),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value!;
                  });
                },
              ),
            ),

            // Content Grid/List
            Expanded(
              child: isWideScreen
                  ? GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.85,
                      ),
                      itemCount: filteredArticles.length,
                      itemBuilder: (context, index) => _buildArticleCard(filteredArticles[index]),
                    )
                  : ListView.builder(
                      itemCount: filteredArticles.length,
                      itemBuilder: (context, index) => _buildArticleCard(filteredArticles[index]),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildArticleCard(Map<String, String> article) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Article Image
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
                // Article Title
                Text(
                  article["title"]!,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),

                // Article Description
                Text(
                  article["description"]!,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),

                // Read More Button
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
          ),
        ],
      ),
    );
  }
}
