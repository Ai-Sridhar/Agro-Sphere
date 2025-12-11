import 'package:agro_sphere_project/pages/onboard.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatelessWidget {
  final String name;
  const ProfilePage({super.key, required this.name});

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

          // Name
          Text(
            name,
            style: const TextStyle(
              fontFamily: "Poppins",
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 4),

          // Role (for now static, you can fetch from Firestore later)
          const Text(
            "Farmer",
            style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 14,
              color: Colors.black54,
            ),
          ),

          const SizedBox(height: 20),

          // Email card
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: const Icon(Icons.email_outlined),
              title: const Text("Email"),
              subtitle: Text(user?.email ?? "not-set@example.com"),
            ),
          ),

          const SizedBox(height: 10),

          // Settings card
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: const ListTile(
              leading: Icon(Icons.settings_outlined),
              title: Text("Settings"),
            ),
          ),

          const SizedBox(height: 20),

          // Logout Button
          ElevatedButton.icon(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const Onboard() ), 
                (route) => false,
              );
            },
            icon: const Icon(Icons.logout),
            label: const Text("Logout"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }
}
