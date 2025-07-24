import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math' as math;
import 'package:newproject/TrainerPage.dart';
import 'package:newproject/SignupPage.dart';

import 'WelcomePage.dart';
// import 'package:newproject/WelcomePage.dart'; // Add your welcome page import

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void loginUser() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in both fields'),
          backgroundColor: Colors.red.shade600,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

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
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => TrainerPage()),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login failed: ${e.toString()}'),
            backgroundColor: Colors.red.shade600,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _handleBackButton() {
    // Check if there's a route to pop back to
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      // If no route to pop back to, navigate to welcome page
      // Replace 'WelcomePage()' with your actual welcome page
     // Navigator.pushReplacementNamed(context, '/welcome');
     Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => WelcomePage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(
          color: Colors.white,
          onPressed: _isLoading ? null : _handleBackButton,
        ),
        // Alternative: Hide back button if no previous route
        // automaticallyImplyLeading: Navigator.canPop(context),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topLeft,
            radius: 1.5,
            colors: [
              Colors.blue.shade900,
              Colors.indigo.shade600,
              Colors.purple.shade400
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 80),
              child: Column(
                children: [
                  // App Logo/Icon
                  Hero(
                    tag: 'app_logo',
                    child: Icon(
                      Icons.lock_open_rounded,
                      size: 90,
                      color: Colors.yellowAccent.shade700,
                    ),
                  ),
                  SizedBox(height: 30),

                  // Title
                  Text(
                    "Login to EliteFit",
                    style: TextStyle(
                      fontSize: 34,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  SizedBox(height: 40),

                  // Email Field
                  buildInputField("Email", emailController, false),
                  SizedBox(height: 20),

                  // Password Field
                  buildInputField("Password", passwordController, true),
                  SizedBox(height: 30),

                  // Login Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : loginUser,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 60),
                        backgroundColor: _isLoading
                            ? Colors.grey.shade600
                            : Colors.yellowAccent.shade700,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 15,
                        shadowColor: Colors.black.withOpacity(0.3),
                      ),
                      child: _isLoading
                          ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(width: 12),
                          Text(
                            "Logging in...",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      )
                          : Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Sign Up Link
                  TextButton(
                    onPressed: _isLoading
                        ? null
                        : () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => SignupPage()),
                    ),
                    child: Text(
                      "Don't have an account? Sign Up",
                      style: TextStyle(
                        color: _isLoading ? Colors.grey : Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                  ),

                  // Forgot Password (Optional)
                  TextButton(
                    onPressed: _isLoading ? null : () {
                      // Add forgot password functionality
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Forgot password feature coming soon!'),
                          backgroundColor: Colors.blue.shade600,
                        ),
                      );
                    },
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                        color: _isLoading ? Colors.grey : Colors.white54,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInputField(String label, TextEditingController controller, bool obscure) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      enabled: !_isLoading,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: _isLoading ? Colors.grey : Colors.white70,
        ),
        filled: true,
        fillColor: _isLoading
            ? Colors.white.withOpacity(0.05)
            : Colors.white.withOpacity(0.15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Colors.yellowAccent,
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Colors.white.withOpacity(0.3),
            width: 1,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Colors.grey.withOpacity(0.3),
            width: 1,
          ),
        ),
      ),
    );
  }
}