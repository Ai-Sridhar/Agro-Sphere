import 'package:flutter/material.dart';

class BuyerShop extends StatelessWidget {
  const BuyerShop({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "🛒 Buyer Shop Page",
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
    );
  }
}
