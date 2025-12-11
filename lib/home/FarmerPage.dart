import 'package:agro_sphere_project/Farmer/chatbot.dart';
import 'package:agro_sphere_project/Farmer/crop_recommendation.dart';
import 'package:agro_sphere_project/Farmer/farmer_home.dart';
import 'package:agro_sphere_project/Farmer/plant_disease.dart';
import 'package:agro_sphere_project/Farmer/profile.dart';
import 'package:agro_sphere_project/Farmer/shop.dart';
import 'package:flutter/material.dart';

class FarmerPage extends StatefulWidget {
  final String name;
  const FarmerPage({super.key, required this.name});

  @override
  State<FarmerPage> createState() => _FarmerPageState();
}

class _FarmerPageState extends State<FarmerPage> {
  int _selectedIndex = 0;
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      FarmerHome(name: widget.name), // 👈 pass name to Home
      const PlantDiseasePage(),
      const CropRecommendationPage(),
      const ShopPage(),
      const ChatbotPage(),
      ProfilePage(name: widget.name),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // show only the selected page
      body: _pages[_selectedIndex],

      // Floating-style, smaller bottom nav bar
      bottomNavigationBar: SafeArea(
  top: false,
  child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color.fromARGB(255, 11, 104, 14),
          unselectedItemColor: Colors.grey.shade600,
          onTap: (idx) => setState(() => _selectedIndex = idx),
          iconSize: 22,
          selectedFontSize: 13,
          unselectedFontSize: 12,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.local_florist), label: "Disease"),
            BottomNavigationBarItem(icon: Icon(Icons.eco_outlined), label: "Crops"),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined), label: "Shop"),
            BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: "Chatbot"),
            BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Profile"),
          ],
        ),
      ),
    ),
  ),
),

    );
  }
}
