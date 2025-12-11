import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pages/onboard.dart'; // 👈 adjust path if different

class BuyerProfile extends StatelessWidget {
  final String name;
  const BuyerProfile({super.key, required this.name});

  Future<void> logout(BuildContext context) async {
    // Clear login data
    await FirebaseAuth.instance.signOut();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("firstTime", true); // so onboard shows again

    // Navigate to Onboard
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const Onboard()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return SafeArea(
      child: Column(
        children: [
          CircleAvatar(
            radius: 44,
            backgroundImage: const AssetImage("assets/images/bg.png"),
            backgroundColor: Colors.grey.shade200,
          ),
          const SizedBox(height: 12),
          Text(
            name,
            style: const TextStyle(
              fontFamily: "Poppins",
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            "Buyer",
            style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 20),

          // Email Card
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: const Icon(Icons.email_outlined),
              title: const Text("Email"),
              subtitle: Text(user?.email ?? "not-set@example.com"),
            ),
          ),
          const SizedBox(height: 10),

          // Settings Card
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: const ListTile(
              leading: Icon(Icons.settings_outlined),
              title: Text("Settings"),
            ),
          ),
          const SizedBox(height: 30),

          // Logout Button
          ElevatedButton.icon(
            onPressed: () => logout(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
            ),
            icon: const Icon(Icons.logout, color: Colors.white),
            label: const Text(
              "Logout",
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
