// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:newproject/AuthGate.dart';
// final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.dark);
// void main()async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(EliteFitApp());
// }
// class EliteFitApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder<ThemeMode>(
//       valueListenable: themeNotifier,
//       builder: (context, mode, _) {
//         return MaterialApp(
//           title: 'EliteFit',
//           theme: ThemeData(
//             brightness: Brightness.light,
//             primaryColor: Color(0xFFFFD700),
//             scaffoldBackgroundColor: Colors.white,
//             elevatedButtonTheme: ElevatedButtonThemeData(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Color(0xFF2196F3),
//                 foregroundColor: Colors.white,
//                 elevation: 10,
//                 textStyle: TextStyle(fontWeight: FontWeight.bold),
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
//                 minimumSize: Size(double.infinity, 50),
//               ),
//             ),
//             inputDecorationTheme: InputDecorationTheme(
//               filled: true,
//               fillColor: Colors.grey[200],
//               border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//               labelStyle: TextStyle(color: Colors.black),
//             ),
//           ),
//           darkTheme: ThemeData(
//             brightness: Brightness.dark,
//             primaryColor: Color(0xFFFFD700),
//             scaffoldBackgroundColor: Colors.black,
//             elevatedButtonTheme: ElevatedButtonThemeData(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Color(0xFF2196F3),
//                 foregroundColor: Colors.white,
//                 elevation: 10,
//                 textStyle: TextStyle(fontWeight: FontWeight.bold),
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
//                 minimumSize: Size(double.infinity, 50),
//               ),
//             ),
//             inputDecorationTheme: InputDecorationTheme(
//               filled: true,
//               fillColor: Colors.grey[900],
//               border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//               labelStyle: TextStyle(color: Colors.white),
//             ),
//           ),
//           themeMode: mode,
//           debugShowCheckedModeBanner: false,
//           home: AuthGate(),
//         );
//       },
//     );
//   }
// }
//
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart'; // 🔔 FCM import
import 'package:flutter/material.dart';
import 'package:newproject/AuthGate.dart';

final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.dark);

// 🔕 Handle background/terminated messages
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('🔕 Background message: ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // 📩 Background handler setup
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(EliteFitApp());
}

class EliteFitApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 📲 Setup FCM listeners
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('📥 Foreground notification: ${message.notification?.title}');
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('📤 Notification opened: ${message.notification?.title}');
    });

    // 📲 Get and log token
    FirebaseMessaging.instance.getToken().then((token) {
      print('📲 FCM Token: $token');
    });

    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, mode, _) {
        return MaterialApp(
          title: 'EliteFit',
          theme: ThemeData(
            brightness: Brightness.light,
            primaryColor: Color(0xFFFFD700),
            scaffoldBackgroundColor: Colors.white,
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF2196F3),
                foregroundColor: Colors.white,
                elevation: 10,
                textStyle: TextStyle(fontWeight: FontWeight.bold),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                minimumSize: Size(double.infinity, 50),
              ),
            ),
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              labelStyle: TextStyle(color: Colors.black),
            ),
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: Color(0xFFFFD700),
            scaffoldBackgroundColor: Colors.black,
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF2196F3),
                foregroundColor: Colors.white,
                elevation: 10,
                textStyle: TextStyle(fontWeight: FontWeight.bold),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                minimumSize: Size(double.infinity, 50),
              ),
            ),
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: Colors.grey[900],
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              labelStyle: TextStyle(color: Colors.white),
            ),
          ),
          themeMode: mode,
          debugShowCheckedModeBanner: false,
          home: AuthGate(),
        );
      },
    );
  }
}
