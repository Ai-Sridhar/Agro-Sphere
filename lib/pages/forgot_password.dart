import 'package:flutter/material.dart';
import 'package:agro_sphere_project/services/auth_service.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController emailController = TextEditingController();
  final AuthService _authService = AuthService();

  void resetPassword() async {
    String email = emailController.text.trim();

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter your email")),
      );
      return;
    }

    await _authService.sendPasswordReset(email);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Password reset email sent!")),
    );

    Navigator.pop(context); // Go back to login
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(top: 50.0, left: 20.0),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(70, 6, 101, 9),
                  borderRadius: BorderRadius.circular(60),
                ),
                child: const Icon(Icons.arrow_back,
                    color: Color.fromARGB(255, 11, 104, 14)),
              ),
            ),
            const SizedBox(height: 40.0),
            Center(
              child: Column(
                children: [
                  const Text("Forgot Password?",
                      style: TextStyle(
                          color: Color.fromARGB(255, 11, 104, 14),
                          fontSize: 30.0,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10.0),
                  const Text("Enter your email to reset password",
                      style: TextStyle(
                          color: Color.fromARGB(95, 4, 26, 5),
                          fontSize: 18.0,
                          fontFamily: 'Poppins')),
                ],
              ),
            ),
            const SizedBox(height: 40.0),
            Container(
              height: 60,
              margin: const EdgeInsets.symmetric(horizontal: 30.0),
              decoration: BoxDecoration(
                color: const Color.fromARGB(89, 11, 104, 14),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.mail,
                        color: Color.fromARGB(255, 11, 104, 14)),
                    hintText: "Enter Email",
                    hintStyle: TextStyle(
                        color: Color.fromARGB(255, 11, 104, 14),
                        fontFamily: 'Poppins',
                        fontSize: 18.0),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30.0),
            GestureDetector(
              onTap: resetPassword,
              child: Container(
                height: 45,
                margin: const EdgeInsets.symmetric(horizontal: 30.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 11, 104, 14),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: const Center(
                  child: Text("Send Reset Email",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontFamily: 'Poppins')),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
