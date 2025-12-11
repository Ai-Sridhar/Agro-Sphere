import 'package:flutter/material.dart';
import 'package:agro_sphere_project/pages/onboard.dart';
import 'package:shared_preferences/shared_preferences.dart';


class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  // List of slides
  final List<Map<String, String>> _slides = [
    {
      "title": "Welcome to\n Agro Sphere",
      "desc": "Your all-in-one app solution for farmers and buyers.",
      "img": "assets/images/1.jpeg"
    },
    {
      "title": "Disease Identification",
      "desc": "Identify plant diseases instantly with AI-powered detection.",
      "img": "assets/images/2.png"
    },
    {
      "title": "Direct Purchase",
      "desc": "Buyers can directly purchase fresh vegetables from farmers.",
      "img": "assets/images/3.jpg"
    },
  ];

  void _goToOnboard() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool("firstTime", true);

  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => const Onboard()),
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // PageView for slides
          PageView.builder(
            controller: _controller,
            itemCount: _slides.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.all(20),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(_slides[index]["img"]!, height: 200,width: 450,),
                    const SizedBox(height: 30),
                    Text(
                      _slides[index]["title"]!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Poppins",
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      _slides[index]["desc"]!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                        fontFamily: "Poppins",
                      ),
                    ),
                  ],
                ),
              );
            },
          ),

          // Bottom controls
          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Skip Button
                TextButton(
                  onPressed: _goToOnboard,
                  child: const Text(
                    "Skip",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: "Poppins",
                      color: Colors.green,
                    ),
                  ),
                ),

                // Next / Done Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    if (_currentPage == _slides.length - 1) {
                      _goToOnboard(); // Last page → Onboard
                    } else {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    }
                  },
                  child: Text(
                    _currentPage == _slides.length - 1 ? "Done" : "Next",
                    style: const TextStyle(
                      fontSize: 18,
                      fontFamily: "Poppins",
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
