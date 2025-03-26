import 'package:flutter/material.dart';

class MarketScreen extends StatefulWidget {
  const MarketScreen({super.key});

  @override
  _MarketScreenState createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  // Sample data for market listings
  final List<Map<String, String>> marketItems = [
    {"name": "Organic Tomatoes", "price": "Rs. 120/kg", "location": "Kathmandu"},
    {"name": "Fresh Potatoes", "price": "Rs. 80/kg", "location": "Chitwan"},
    {"name": "Wheat Seeds", "price": "Rs. 150/kg", "location": "Pokhara"},
    {"name": "Milk (Buffalo)", "price": "Rs. 90/L", "location": "Lalitpur"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Market Place"),
        backgroundColor: Colors.green,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to sell product screen (to be created)
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: marketItems.length,
          itemBuilder: (context, index) {
            final item = marketItems[index];
            return Card(
              elevation: 3,
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                leading: const Icon(Icons.agriculture, color: Colors.green),
                title: Text(item["name"]!, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text("${item["price"]} • ${item["location"]}"),
                trailing: ElevatedButton(
                  onPressed: () {
                    // Navigate to details or buy screen
                  },
                  child: const Text("Buy"),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
