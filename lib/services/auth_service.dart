import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Signup
  Future<User?> signup(String email, String password, String name, String role) async {
    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // For now we can store role & name in displayName (since no Firestore is used)
      await cred.user?.updateDisplayName("$name|$role");

      return cred.user;
    } on FirebaseAuthException catch (e) {
      print("Signup Error: ${e.message}");
      return null;
    }
  }

  // Login
  Future<User?> login(String email, String password) async {
    try {
      UserCredential cred = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return cred.user;
    } on FirebaseAuthException catch (e) {
      print("Login Error: ${e.message}");
      return null;
    }
  }

  // Get Role
  Future<String?> getRole(String uid) async {
    User? user = _auth.currentUser;
    if (user?.displayName != null) {
      return user!.displayName!.split("|").last; // extract role
    }
    return null;
  }

  // Get Name
  Future<String?> getName(String uid) async {
    User? user = _auth.currentUser;
    if (user?.displayName != null) {
      return user!.displayName!.split("|").first; // extract name
    }
    return null;
  }

  // Forgot Password
  Future<void> sendPasswordReset(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      print("Forgot Password Error: ${e.message}");
    }
  }
}
