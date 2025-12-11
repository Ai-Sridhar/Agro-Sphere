import 'package:agro_sphere_project/home/BuyerPage.dart';
import 'package:agro_sphere_project/home/FarmerPage.dart';
import 'package:flutter/material.dart';
import 'package:agro_sphere_project/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

Future<void> saveUserRole(String role) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString("userRole", role);
}


class _SignupState extends State<Signup> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? selectedRole;

  final AuthService _authService = AuthService();

  void signupUser() async {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty || selectedRole == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields and select a role")),
      );
      return;
    }

    final user = await _authService.signup(email, password, name, selectedRole!);

    if (user != null) {
  // ✅ Save role and name locally
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString("userRole", selectedRole!);
  await prefs.setString("userName", name);

  if (selectedRole == "Farmer") {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => FarmerPage(name: name)),
    );
  } else {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => BuyerPage(name: name)),
    );
  }
}

  }

  @override
  Widget build(BuildContext context) {
    // ⚡ keep your existing UI, only signupUser() changed
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          // same UI as before
		crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Back button
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(top: 50.0, left: 20.0),
                decoration: BoxDecoration(
                  color: Color.fromARGB(70, 6, 101, 9),
                  borderRadius: BorderRadius.circular(60),
                ),
                child: Icon(Icons.arrow_back, color: Color.fromARGB(255, 11, 104, 14)),
              ),
            ),

            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      "Register",
                      style: TextStyle(
                        color: Color.fromARGB(255, 11, 104, 14),
                        fontSize: 35.0,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    Text(
                      "Create your new account",
                      style: TextStyle(
                        color: Color.fromARGB(95, 4, 26, 5),
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ],
            ),
            SizedBox(height: 20.0),

            // Name Field
            Container(
              height: 60,
              margin: EdgeInsets.symmetric(horizontal: 30.0),
              decoration: BoxDecoration(
                color: Color.fromARGB(89, 11, 104, 14),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.person, color: Color.fromARGB(255, 11, 104, 14)),
                    hintText: "Enter Name",
                    hintStyle: TextStyle(color: Color.fromARGB(255, 11, 104, 14), fontFamily: 'Poppins', fontSize: 18.0),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),

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
                    hintStyle: TextStyle(color: Color.fromARGB(255, 11, 104, 14), fontFamily: 'Poppins', fontSize: 18.0),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),

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
                    hintStyle: TextStyle(color: Color.fromARGB(255, 11, 104, 14), fontFamily: 'Poppins', fontSize: 18.0),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),

            // Role Selection
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
                      style: TextStyle(color: Color.fromARGB(255, 11, 104, 14), fontFamily: 'Poppins', fontSize: 16.0)),
                  isExpanded: true,
                  items: ["Farmer", "Buyer"]
                      .map((role) => DropdownMenuItem(
                            value: role,
                            child: Text(role,
                                style: TextStyle(color: Color.fromARGB(255, 11, 104, 14), fontFamily: 'Poppins', fontSize: 16.0)),
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
            SizedBox(height: 70.0),

            // Signup Button
            GestureDetector(
              onTap: signupUser,
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
                    "SignUp",
                    style: TextStyle(color: Colors.white, fontSize: 15.0, fontFamily: 'Poppins'),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),

            // Login redirect
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account?",
                    style: TextStyle(color: Color.fromARGB(106, 0, 0, 0), fontSize: 16.0, fontFamily: 'Poppins')),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Text(" Login",
                      style: TextStyle(color: Color.fromARGB(255, 11, 104, 14), fontSize: 15.0, fontFamily: 'Poppins')),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
