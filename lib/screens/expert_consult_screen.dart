import 'package:flutter/material.dart';

class ExpertConsultScreen extends StatefulWidget {
  const ExpertConsultScreen({super.key});

  @override
  _ExpertConsultScreenState createState() => _ExpertConsultScreenState();
}

class _ExpertConsultScreenState extends State<ExpertConsultScreen> {
  // Sample expert list
  final List<Map<String, String>> experts = [
    {
      "name": "Dr. Ram Bhandari",
      "specialization": "Soil & Crop Management",
      "contact": "+977 9801234567",
    },
    {
      "name": "Prof. Sita Sharma",
      "specialization": "Pesticides & Organic Farming",
      "contact": "+977 9812345678",
    },
    {
      "name": "Dr. Arjun K.C.",
      "specialization": "Irrigation & Water Management",
      "contact": "+977 9823456789",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Consult an Expert"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Available Experts",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: experts.length,
                itemBuilder: (context, index) {
                  final expert = experts[index];
                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      leading: const Icon(Icons.person, color: Colors.green),
                      title: Text(expert["name"]!, style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(expert["specialization"]!),
                      trailing: IconButton(
                        icon: const Icon(Icons.phone, color: Colors.blue),
                        onPressed: () {
                          // Implement call functionality
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.chat),
                label: const Text("Chat with AI"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                onPressed: () {
                  // Implement AI chatbot functionality
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
