import 'package:agro_sphere_project/Buyer/buyer_farmer.dart';
import 'package:agro_sphere_project/Buyer/buyer_home.dart';
import 'package:agro_sphere_project/Buyer/buyer_profile.dart';
import 'package:agro_sphere_project/Buyer/buyer_shop.dart';
import 'package:flutter/material.dart';

class BuyerPage extends StatefulWidget {
  final String name;
  const BuyerPage({super.key, required this.name});

  @override
  State<BuyerPage> createState() => _BuyerPageState();
}

class _BuyerPageState extends State<BuyerPage> {
  int _selectedIndex = 0;
  late final List<Widget> _pages;
  

  @override
  void initState() {
    super.initState();
    _pages = [
      BuyerHome(name: widget.name),
      const BuyerShop(),
      const BuyerFarmers(),
      BuyerProfile(name: widget.name),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _pages[_selectedIndex]),

      // Modern pill-style bottom navigation
      bottomNavigationBar: SafeArea(
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22), // circular radius
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            type: BottomNavigationBarType.fixed,
            elevation: 0, // remove default shadow
            backgroundColor: Colors.transparent, // transparent inside container
            selectedItemColor: const Color.fromARGB(255, 11, 104, 14),
            unselectedItemColor: Colors.grey.shade600,
            onTap: (idx) => setState(() => _selectedIndex = idx),
            iconSize: 22,
            selectedFontSize: 13,
            unselectedFontSize: 12,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart_outlined),
                label: "Shop",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.people_outline),
                label: "Farmers",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                label: "Profile",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
