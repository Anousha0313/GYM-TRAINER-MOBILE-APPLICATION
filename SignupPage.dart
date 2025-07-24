import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math' as math;
import 'package:newproject/TrainerPage.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final nameController = TextEditingController();
  final contactController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    contactController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void registerUser() async {
    final name = nameController.text.trim();
    final contact = contactController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (name.isEmpty || contact.isEmpty || email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    try {
      final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = userCredential.user?.uid;

      // Store in Firestore
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'name': name,
        'contact': contact,
        'email': email,
        'createdAt': Timestamp.now(),
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => TrainerPage()),
      );
    }
    catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Signup failed: ${e.toString()}')),
      );
    }
  }

  void saveTokenToFirestore() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final fcmToken = await FirebaseMessaging.instance.getToken();

      if (fcmToken != null) {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'fcmToken': fcmToken,
        }, SetOptions(merge: true));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: Colors.white),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.bottomRight,
            radius: 1.4,
            colors: [
              Colors.purple.shade900,
              Colors.pink.shade600,
              Colors.deepPurple.shade400,
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 80),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.person_add, size: 90, color: Colors.cyanAccent.shade400),
                SizedBox(height: 30),
                Text(
                  "Create Your Account",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.3,
                    shadows: [Shadow(color: Colors.purpleAccent, blurRadius: 15)],
                  ),
                ),
                SizedBox(height: 40),

                buildInputField("Full Name", nameController, false),
                SizedBox(height: 20),
                buildInputField("Contact Number", contactController, false, isPhone: true),
                SizedBox(height: 20),
                buildInputField("Email", emailController, false),
                SizedBox(height: 20),
                buildInputField("Password", passwordController, true),
                SizedBox(height: 25),

                ElevatedButton(
                  onPressed: registerUser,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 60),
                    backgroundColor: Colors.cyanAccent.shade400,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    elevation: 15,
                    shadowColor: Colors.cyanAccent,
                  ),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),

                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account? ", style: TextStyle(color: Colors.white)),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.cyanAccent.shade400,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInputField(String label, TextEditingController controller, bool obscure, {bool isPhone = false}) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      keyboardType: isPhone ? TextInputType.phone : TextInputType.text,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.white.withOpacity(0.15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.cyanAccent, width: 2),
        ),
      ),
    );
  }
}