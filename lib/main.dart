import 'package:agro_sphere_project/home/FarmerPage.dart';
import 'package:agro_sphere_project/home/BuyerPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:agro_sphere_project/pages/onboard.dart';
import 'package:agro_sphere_project/pages/welcome.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? seen = prefs.getBool("firstTime");
  String? role = prefs.getString("userRole");   // 👈 load saved role
  String? name = prefs.getString("userName");  // 👈 load saved name

  runApp(MyApp(seen: seen ?? false, role: role, name: name));
}

class MyApp extends StatelessWidget {
  final bool seen;
  final String? role;
  final String? name;

  const MyApp({super.key, required this.seen, this.role, this.name});

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    // 👇 App decides which page to open
    Widget home;
    if (user != null && role != null) {
      if (role == "Buyer") {
        home = BuyerPage(name: name ?? user.email ?? "Buyer");
      } else {
        home = FarmerPage(name: name ?? user.email ?? "Farmer");
      }
    } else {
      home = seen ? const Onboard() : const WelcomeScreen();
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Agro Sphere",
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: "Poppins",
      ),
      home: home,
    );
  }
}
