import 'package:flutter/material.dart';
import 'package:kri/screens/disease_detection_screen.dart';
import 'package:kri/screens/profile_screen.dart';

class MarketScreen extends StatefulWidget {
  const MarketScreen({super.key});

  @override
  _MarketScreenState createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  int _currentNavIndex = 0;

  final List<Map<String, String>> marketItems = [
  {
    "name": "Organic Tomatoes",
    "price": "Rs. 120/kg",
    "location": "Kathmandu",
    "image": "https://drearth.com/wp-content/uploads/tomato-iStock-174932787.jpg"
  },
  {
    "name": "Fresh Potatoes",
    "price": "Rs. 80/kg",
    "location": "Chitwan",
    "image": "https://media-cdn2.greatbritishchefs.com/media/3o2bj2wa/img75602.whqc_1366x910q80.webp"
  },
  {
    "name": "Wheat Seeds",
    "price": "Rs. 150/kg",
    "location": "Pokhara",
    "image": "https://english.makalukhabar.com/wp-content/uploads/2024/11/SEEDS-MK.jpg"
  },
  {
    "name": "Milk (Buffalo)",
    "price": "Rs. 90/L",
    "location": "Lalitpur",
    "image": "https://static.toiimg.com/thumb/resizemode-4,width-1280,height-720,msid-69464837/69464837.jpg"
  },
  {
    "name": "Organic Apples",
    "price": "Rs. 250/kg",
    "location": "Mustang",
    "image": "https://rpcdn.ratopati.com/media/albums/156395230apple-09_njRCr04Yd5.jpeg"
  },
  {
    "name": "Fresh Carrots",
    "price": "Rs. 100/kg",
    "location": "Kavrepalanchok",
    "image": "https://farmher.com/wp-content/uploads/2024/04/carrots_adobe-stock.webp"
  },
  {
    "name": "Fresh Mangoes",
    "price": "Rs. 300/kg",
    "location": "Terhathum",
    "image": "https://mangonad.in/wp-content/uploads/2024/04/m4-scaled.jpg"
  },
  {
    "name": "Cucumber",
    "price": "Rs. 60/kg",
    "location": "Dang",
    "image": "https://static.toiimg.com/thumb/imgsize-23456,msid-107693007,width-600,resizemode-4/107693007.jpg"
  },
  {
    "name": "Fresh Spinach",
    "price": "Rs. 70/kg",
    "location": "Bhairahawa",
    "image": "https://c.ndtvimg.com/2023-05/me690ij_spinach_625x300_09_May_23.jpg"
  },
  {
    "name": "Organic Garlic",
    "price": "Rs. 200/kg",
    "location": "Ilam",
    "image": "https://basalticfarms.com/wp-content/uploads/2023/01/Lab-Testing-Your-Soil-For-The-Best-Garlic-Basaltic-Farms-scaled.jpeg"
  },
  {
    "name": "Banana Bunch",
    "price": "Rs. 110/kg",
    "location": "Sunsari",
    "image": "https://sdzwildlifeexplorers.org/sites/default/files/2019-01/banana-tree.jpg"
  },
  {
    "name": "Chili Powder",
    "price": "Rs. 350/kg",
    "location": "Nepalgunj",
    "image": "https://5.imimg.com/data5/SELLER/Default/2024/7/435552411/ER/JA/QJ/4080399/red-chilli-powder-500x500.jpg"
  },
  {
    "name": "Fresh Ginger",
    "price": "Rs. 180/kg",
    "location": "Biratnagar",
    "image": "https://www.tastingtable.com/img/gallery/the-absolute-best-ways-to-keep-ginger-fresh/l-intro-1648045297.jpg"
  },
  {
    "name": "Fresh Strawberries",
    "price": "Rs. 220/kg",
    "location": "Hetauda",
    "image": "https://canadianfoodfocus.org/wp-content/uploads/2020/09/buying-strawberries-1024x576.jpg"
  },
  {
    "name": "Cabbage",
    "price": "Rs. 80/kg",
    "location": "Dhanusha",
    "image": "https://assets.clevelandclinic.org/transform/871f96ae-a852-4801-8675-683191ce372d/Benefits-Of-Cabbage-589153824-770x533-1_jpg"
  },
  {
    "name": "Lemon",
    "price": "Rs. 50/kg",
    "location": "Ramechhap",
    "image": "https://moowy.co.uk/wp-content/uploads/2024/09/lemon-tree-750x400.jpg"
  }
  ];

  void _addNewItem() {
      setState(() {
    marketItems.addAll([
      {
        "name": "Organic Carrots",
        "price": "Rs. 120/kg",
        "location": "Kavrepalanchok",
        "image": "https://thumbs.dreamstime.com/b/bunches-organic-rainbow-carrots-display-colorful-copy-space-35261040.jpg"
      },
      {
        "name": "Tomato Paste",
        "price": "Rs. 160/kg",
        "location": "Nepalgunj",
        "image": "https://www.mediterraneanliving.com/wp-content/uploads/2022/08/Tomato-Paste.png"
      },
      {
        "name": "Fresh Spinach",
        "price": "Rs. 70/kg",
        "location": "Bhairahawa",
        "image": "https://cdn.sanity.io/images/eiijw0fc/production/03217beb069ecc662fee87793ad2787971bf47ae-3543x1329.jpg"
      },
    ]);
  });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double aspectRatio = screenWidth < 600 ? 0.75 : 0.9; // Responsive aspect ratio

    return Scaffold(
      appBar: AppBar(
        title: const Text("Market Place"),
        backgroundColor: Colors.green.shade700,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewItem,
        child: const Icon(Icons.add, size: 28),
        backgroundColor: Colors.green.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: screenWidth < 600 ? 2 : 3, // Adjust for tablets
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: aspectRatio,
          ),
          itemCount: marketItems.length,
          itemBuilder: (context, index) {
            final item = marketItems[index];
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                    child: Image.network(
                      item["image"]!,
                      height: 130,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(child: CircularProgressIndicator());
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 130,
                          color: Colors.grey.shade300,
                          child: const Center(child: Icon(Icons.broken_image, size: 50, color: Colors.grey)),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      item["name"]!,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "${item["price"]} • ${item["location"]}",
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
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

  void _onBottomNavItemTapped(int index) {
    if (_currentNavIndex == index) return;

    setState(() {
      _currentNavIndex = index;
    });

    // Use Navigator.push instead of pushReplacement
    switch (index) {
      case 0:
        // Stay on the current page
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const DiseaseDetectionScreen()),
        );
        break;
      case 2:
      case 3:
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProfileScreen()),
        );
        break;
    }
  }
}
