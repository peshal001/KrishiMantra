import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';

class ExpertConsultScreen extends StatefulWidget {
  const ExpertConsultScreen({super.key});

  @override
  _ExpertConsultScreenState createState() => _ExpertConsultScreenState();
}

class _ExpertConsultScreenState extends State<ExpertConsultScreen> {
  final List<Map<String, String>> experts = [
    {
      "name": "Dr. Ram Bhandari",
      "specialization": "Soil & Crop Management",
      "contact": "+9779801234567",
    },
    {
      "name": "Prof. Sita Sharma",
      "specialization": "Pesticides & Organic Farming",
      "contact": "+9779812345678",
    },
    {
      "name": "Dr. Arjun K.C.",
      "specialization": "Irrigation & Water Management",
      "contact": "+9779823456789",
    },
    {
      "name": "Dr. Sunita Joshi",
      "specialization": "Plant Pathology & Pest Control",
      "contact": "+9779845678901",
    },
  ];

  final JitsiMeet _jitsiMeet = JitsiMeet();

  // Function to make a real-time phone call
  void _makePhoneCall(String contact) async {
    final Uri phoneUri = Uri.parse("tel:$contact");
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Could not launch phone call to $contact")),
      );
    }
  }

  // Function to start a Jitsi Meet video call
  void _startVideoCall(String expertName) async {
    try {
      final options = JitsiMeetConferenceOptions(
        room: "ConsultationWith$expertName",
        serverURL: "https://meet.jit.si",
        userInfo: JitsiMeetUserInfo(displayName: "User"),
        configOverrides: {
          "startWithAudioMuted": false, // Ensure audio is enabled
          "startWithVideoMuted": false, // Ensure video is enabled
        },
      );

      await _jitsiMeet.join(options);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error starting video call: $error")),
      );
    }
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
