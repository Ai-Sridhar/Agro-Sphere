import 'package:flutter/material.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "🛒 Shop Page\n(Marketplace)",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 18, fontFamily: "Poppins", color: Colors.black87),
      ),
    );
  }
}
