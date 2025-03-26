import 'package:flutter/material.dart';

class ExpertConsultScreen extends StatefulWidget {
  const ExpertConsultScreen({super.key});

  @override
  _ExpertConsultScreenState createState() => _ExpertConsultScreenState();
}

class _ExpertConsultScreenState extends State<ExpertConsultScreen> {
  // Updated list with more experts
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
    {
      "name": "Dr. Sunita Joshi",
      "specialization": "Plant Pathology & Pest Control",
      "contact": "+977 9845678901",
    },
    {
      "name": "Dr. Bikash Thapa",
      "specialization": "Agroforestry & Climate Resilience",
      "contact": "+977 9856789012",
    },
    {
      "name": "Dr. Suman Lama",
      "specialization": "Dairy & Livestock Farming",
      "contact": "+977 9867890123",
    },
  ];

  // Function to make a phone call (placeholder)
  void _makePhoneCall(String contact) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Calling $contact...")),
    );
    // Use `url_launcher` package to implement actual calling functionality
  }

  // Function to start a video call (placeholder)
  void _startVideoCall(String expertName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Starting video call with $expertName...")),
    );
    // You can integrate Jitsi Meet, Zoom SDK, or Agora for real video calling
  }

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
                      title: Text(
                        expert["name"]!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(expert["specialization"]!),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.phone, color: Colors.blue),
                            onPressed: () => _makePhoneCall(expert["contact"]!),
                          ),
                          IconButton(
                            icon: const Icon(Icons.video_call, color: Colors.red),
                            onPressed: () => _startVideoCall(expert["name"]!),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
