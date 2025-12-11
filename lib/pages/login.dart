import 'package:agro_sphere_project/home/BuyerPage.dart';
import 'package:agro_sphere_project/home/FarmerPage.dart';
import 'package:agro_sphere_project/pages/forgot_password.dart';
import 'package:agro_sphere_project/pages/sigup.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:agro_sphere_project/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String? selectedRole;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final AuthService _authService = AuthService();

  void loginUser() async {
  String email = emailController.text.trim();
  String password = passwordController.text.trim();

  if (email.isEmpty || password.isEmpty || selectedRole == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Please enter email, password, and role")),
    );
    return;
  }

  User? user = await _authService.login(email, password);

  if (user != null) {
    String? role = await _authService.getRole(user.uid);
    String? name = await _authService.getName(user.uid);

    if (role == selectedRole) {
  // ✅ Save role and name locally
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString("userRole", selectedRole!);
  await prefs.setString("userName", name ?? "User");

  if (role == "Farmer") {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => FarmerPage(name: name ?? "Farmer")),
    );
  } else {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => BuyerPage(name: name ?? "Buyer")),
    );
  }
}
  } 

  }

  @override
  Widget build(BuildContext context) {
    // ⚡ keep your existing UI, only loginUser() changed
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          // same UI as before
		children: [
            Image.asset(
              'assets/images/curvedbg.png',
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2.5,
              fit: BoxFit.cover,
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back Button
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(top: 50.0, left: 20.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(60),
                      ),
                      child: Icon(Icons.arrow_back, color: Color.fromARGB(255, 11, 104, 14)),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 4),

                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        children: [
                          Text("Welcome Back",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 11, 104, 14),
                                  fontSize: 30.0,
                                  fontFamily: 'Poppins')),
                          Text("Login to your account",
                              style: TextStyle(
                                  color: Color.fromARGB(95, 4, 26, 5),
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w500))
                        ],
                      ),
                      Image.asset('assets/images/leaf.png', height: 150, width: 150),
                    ],
                  ),
                  SizedBox(height: 15.0),

                  // Email Field
                  Container(
                    height: 60,
                    margin: EdgeInsets.symmetric(horizontal: 30.0),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(89, 11, 104, 14),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.mail, color: Color.fromARGB(255, 11, 104, 14)),
                          hintText: "Enter Email",
                          hintStyle: TextStyle(
                              color: Color.fromARGB(255, 11, 104, 14),
                              fontFamily: 'Poppins',
                              fontSize: 18.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15.0),

                  // Password Field
                  Container(
                    height: 60,
                    margin: EdgeInsets.symmetric(horizontal: 30.0),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(89, 11, 104, 14),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.password, color: Color.fromARGB(255, 11, 104, 14)),
                          hintText: "Enter Password",
                          hintStyle: TextStyle(
                              color: Color.fromARGB(255, 11, 104, 14),
                              fontFamily: 'Poppins',
                              fontSize: 18.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15.0),

                  // Role Dropdown
                  Container(
                    height: 60,
                    margin: EdgeInsets.symmetric(horizontal: 30.0),
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(89, 11, 104, 14),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedRole,
                        hint: Text("Select Role (Farmer / Buyer)",
                            style: TextStyle(
                                color: Color.fromARGB(255, 11, 104, 14),
                                fontFamily: 'Poppins',
                                fontSize: 16.0)),
                        isExpanded: true,
                        items: ["Farmer", "Buyer"]
                            .map((role) => DropdownMenuItem(
                                  value: role,
                                  child: Text(role,
                                      style: TextStyle(
                                          color: Color.fromARGB(255, 11, 104, 14),
                                          fontFamily: 'Poppins',
                                          fontSize: 16.0)),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedRole = value;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 5.0),

                  // Forgot Password
                  Padding(
                    padding: EdgeInsets.only(right: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ForgotPassword()),
                          ),
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                                color: Color.fromARGB(255, 11, 104, 14),
                                fontSize: 15.0,
                                fontFamily: 'Poppins'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.0),

                  // Login Button
                  GestureDetector(
                    onTap: loginUser,
                    child: Container(
                      height: 40,
                      margin: EdgeInsets.symmetric(horizontal: 20.0),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 11, 104, 14),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Center(
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.white, fontSize: 15.0, fontFamily: 'Poppins'),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),

                  // Signup Redirect
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?",
                          style: TextStyle(
                              color: Color.fromARGB(106, 0, 0, 0),
                              fontSize: 16.0,
                              fontFamily: 'Poppins')),
                      GestureDetector(
                        onTap: () => Navigator.push(
                            context, MaterialPageRoute(builder: (context) => Signup())),
                        child: Text(" Sign up",
                            style: TextStyle(
                                color: Color.fromARGB(255, 11, 104, 14),
                                fontSize: 15.0,
                                fontFamily: 'Poppins')),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
