import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newproject/TrainerPage.dart';
import 'package:newproject/WelcomePage.dart';
class AuthGate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasData) {
          // User logged in, go to TrainerPage
          return WelcomePage();//TrainerPage();
        } else {
          // User not logged in, show WelcomePage
          return WelcomePage();
        }
      },
    );
  }
}