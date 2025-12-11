import 'package:flutter/material.dart';

class ChatbotPage extends StatelessWidget {
  const ChatbotPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "🤖 Chatbot Assistant\n(Ask about crop care, prices, tips)",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 18, fontFamily: "Poppins", color: Colors.black87),
      ),
    );
  }
}
