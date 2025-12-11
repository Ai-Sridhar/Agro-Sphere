import 'package:flutter/material.dart';

class PlantDiseasePage extends StatelessWidget {
  const PlantDiseasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 28),
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              "assets/images/bg.png",
              height: 220,
              width: MediaQuery.of(context).size.width * 0.86,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            "🌿 Plant Disease Identification",
            style: TextStyle(
              fontSize: 20,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w600,
              color: Color.fromARGB(255, 11, 104, 14),
            ),
          ),
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 28.0),
            child: Text(
              "Upload or take a clear picture of the plant leaf and our model will detect possible diseases and suggest remedies.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, color: Colors.black54, fontFamily: "Poppins"),
            ),
          ),
          const SizedBox(height: 18),
          ElevatedButton.icon(
            onPressed: () {
              // implement image picker / model call later
            },
            icon: const Icon(Icons.upload_file_outlined),
            label: const Text("Upload Image"),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 11, 104, 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }
}
