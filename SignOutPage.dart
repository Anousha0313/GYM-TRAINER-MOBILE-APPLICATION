// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:newproject/LoginPage.dart';
//
// class SignOutPage extends StatefulWidget {
//   @override
//   _SignOutPageState createState() => _SignOutPageState();
// }
//
// class _SignOutPageState extends State<SignOutPage> {
//   bool _isLoading = false;
//
//   void signOutUser(BuildContext context) async {
//     setState(() {
//       _isLoading = true;
//     });
//
//     try {
//       await FirebaseAuth.instance.signOut();
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (_) => LoginPage()),
//             // This removes all previous routes
//       );
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Sign out failed: ${e.toString()}'),
//             backgroundColor: Colors.red.shade600,
//             behavior: SnackBarBehavior.floating,
//           ),
//         );
//       }
//     } finally {
//       if (mounted) {
//         setState(() {
//           _isLoading = false;
//         });
//       }
//     }
//   }
//
//   void cancelSignOut(BuildContext context) {
//     Navigator.pop(context);
//   }
//
//   ButtonStyle get primaryButtonStyle => ElevatedButton.styleFrom(
//     padding: EdgeInsets.symmetric(vertical: 16, horizontal: 60),
//     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
//     elevation: 15,
//     shadowColor: Colors.black.withOpacity(0.3),
//   );
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: BackButton(
//           color: Colors.white,
//           onPressed: _isLoading ? null : () => Navigator.pop(context),
//         ),
//       ),
//       body: SafeArea(
//         child: Container(
//           decoration: BoxDecoration(
//             gradient: RadialGradient(
//               center: Alignment.topLeft,
//               radius: 1.5,
//               colors: [
//                 Colors.blue.shade900,
//                 Colors.indigo.shade600,
//                 Colors.purple.shade400
//               ],
//             ),
//           ),
//           child: Center(
//             child: SingleChildScrollView(
//               padding: EdgeInsets.symmetric(horizontal: 30, vertical: 80),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   // Sign out icon with animation
//                   AnimatedContainer(
//                     duration: Duration(milliseconds: 300),
//                     child: Icon(
//                       Icons.logout_rounded,
//                       size: 90,
//                       color: Colors.yellowAccent.shade700,
//                       semanticLabel: 'Sign out icon',
//                     ),
//                   ),
//                   SizedBox(height: 30),
//
//                   // Title
//                   Text(
//                     "Sign Out",
//                     style: TextStyle(
//                       fontSize: 34,
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                       letterSpacing: 1.2,
//                     ),
//                   ),
//                   SizedBox(height: 20),
//
//                   // Subtitle
//                   Text(
//                     "Are you sure you want to sign out of EliteFit?",
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.white70,
//                       height: 1.4,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   SizedBox(height: 40),
//
//                   // Sign Out Button
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       onPressed: _isLoading ? null : () => signOutUser(context),
//                       style: primaryButtonStyle.copyWith(
//                         backgroundColor: MaterialStateProperty.resolveWith<Color>(
//                               (Set<MaterialState> states) {
//                             if (states.contains(MaterialState.disabled)) {
//                               return Colors.grey.shade600;
//                             }
//                             return Colors.red.shade600;
//                           },
//                         ),
//                       ),
//                       child: _isLoading
//                           ? Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           SizedBox(
//                             height: 20,
//                             width: 20,
//                             child: CircularProgressIndicator(
//                               strokeWidth: 2,
//                               valueColor: AlwaysStoppedAnimation<Color>(
//                                 Colors.white,
//                               ),
//                             ),
//                           ),
//                           SizedBox(width: 12),
//                           Text(
//                             "Signing Out...",
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 18,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ],
//                       )
//                           : Text(
//                         "Yes, Sign Out",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 18,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 15),
//
//                   // Cancel Button
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       onPressed: _isLoading ? null : () => cancelSignOut(context),
//                       style: primaryButtonStyle.copyWith(
//                         backgroundColor: MaterialStateProperty.resolveWith<Color>(
//                               (Set<MaterialState> states) {
//                             if (states.contains(MaterialState.disabled)) {
//                               return Colors.grey.shade400;
//                             }
//                             return Colors.yellowAccent.shade700;
//                           },
//                         ),
//                       ),
//                       child: Text(
//                         "Cancel",
//                         style: TextStyle(
//                           color: _isLoading ? Colors.grey.shade600 : Colors.black,
//                           fontSize: 18,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   ),
//
//                   // Additional spacing for better visual balance
//                   SizedBox(height: 20),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:newproject/LoginPage.dart';
//
// class SignOutPage extends StatefulWidget {
//   @override
//   _SignOutPageState createState() => _SignOutPageState();
// }
//
// class _SignOutPageState extends State<SignOutPage> {
//   bool _isLoading = false;
//
//   void signOutUser(BuildContext context) async {
//     setState(() {
//       _isLoading = true;
//     });
//
//     try {
//       await FirebaseAuth.instance.signOut();
//
//       // Clear the navigation stack and go to LoginPage
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (_) => LoginPage()),
//         // This removes all previous routes
//       );
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Sign out failed: ${e.toString()}'),
//             backgroundColor: Colors.red.shade600,
//             behavior: SnackBarBehavior.floating,
//           ),
//         );
//       }
//     } finally {
//       if (mounted) {
//         setState(() {
//           _isLoading = false;
//         });
//       }
//     }
//   }
//
//   void cancelSignOut(BuildContext context) {
//     Navigator.pop(context);
//   }
//
//   ButtonStyle get primaryButtonStyle => ElevatedButton.styleFrom(
//     padding: EdgeInsets.symmetric(vertical: 16, horizontal: 60),
//     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
//     elevation: 15,
//     shadowColor: Colors.black.withOpacity(0.3),
//   );
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: BackButton(
//           color: Colors.white,
//           onPressed: _isLoading ? null : () => Navigator.pop(context),
//         ),
//       ),
//       body: SafeArea(
//         child: Container(
//           decoration: BoxDecoration(
//             gradient: RadialGradient(
//               center: Alignment.topLeft,
//               radius: 1.5,
//               colors: [
//                 Colors.blue.shade900,
//                 Colors.indigo.shade600,
//                 Colors.purple.shade400
//               ],
//             ),
//           ),
//           child: Center(
//             child: SingleChildScrollView(
//               padding: EdgeInsets.symmetric(horizontal: 30, vertical: 80),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   // Sign out icon with animation
//                   AnimatedContainer(
//                     duration: Duration(milliseconds: 300),
//                     child: Icon(
//                       Icons.logout_rounded,
//                       size: 90,
//                       color: Colors.yellowAccent.shade700,
//                       semanticLabel: 'Sign out icon',
//                     ),
//                   ),
//                   SizedBox(height: 30),
//
//                   // Title
//                   Text(
//                     "Sign Out",
//                     style: TextStyle(
//                       fontSize: 34,
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                       letterSpacing: 1.2,
//                     ),
//                   ),
//                   SizedBox(height: 20),
//
//                   // Subtitle
//                   Text(
//                     "Are you sure you want to sign out of EliteFit?",
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.white70,
//                       height: 1.4,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   SizedBox(height: 40),
//
//                   // Sign Out Button
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       onPressed: _isLoading ? null : () => signOutUser(context),
//                       style: primaryButtonStyle.copyWith(
//                         backgroundColor: MaterialStateProperty.resolveWith<Color>(
//                               (Set<MaterialState> states) {
//                             if (states.contains(MaterialState.disabled)) {
//                               return Colors.grey.shade600;
//                             }
//                             return Colors.red.shade600;
//                           },
//                         ),
//                       ),
//                       child: _isLoading
//                           ? Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           SizedBox(
//                             height: 20,
//                             width: 20,
//                             child: CircularProgressIndicator(
//                               strokeWidth: 2,
//                               valueColor: AlwaysStoppedAnimation<Color>(
//                                 Colors.white,
//                               ),
//                             ),
//                           ),
//                           SizedBox(width: 12),
//                           Text(
//                             "Signing Out...",
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 18,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ],
//                       )
//                           : Text(
//                         "Yes, Sign Out",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 18,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 15),
//
//                   // Cancel Button
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       onPressed: _isLoading ? null : () => cancelSignOut(context),
//                       style: primaryButtonStyle.copyWith(
//                         backgroundColor: MaterialStateProperty.resolveWith<Color>(
//                               (Set<MaterialState> states) {
//                             if (states.contains(MaterialState.disabled)) {
//                               return Colors.grey.shade400;
//                             }
//                             return Colors.yellowAccent.shade700;
//                           },
//                         ),
//                       ),
//                       child: Text(
//                         "Cancel",
//                         style: TextStyle(
//                           color: _isLoading ? Colors.grey.shade600 : Colors.black,
//                           fontSize: 18,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   ),
//
//                   // Additional spacing for better visual balance
//                   SizedBox(height: 20),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newproject/LoginPage.dart';

class SignOutPage extends StatefulWidget {
  const SignOutPage({Key? key}) : super(key: key);

  @override
  _SignOutPageState createState() => _SignOutPageState();
}

class _SignOutPageState extends State<SignOutPage> {
  bool _isLoading = false;

  void signOutUser() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await FirebaseAuth.instance.signOut();

      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => LoginPage()),
              (route) => false,
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Sign out failed: ${e.toString()}'),
            backgroundColor: Colors.red.shade600,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  void cancelSignOut() {
    Navigator.pop(context);
  }

  ButtonStyle get primaryButtonStyle => ElevatedButton.styleFrom(
    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 60),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    elevation: 15,
    shadowColor: Colors.black.withOpacity(0.3),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(
          color: Colors.white,
          onPressed: _isLoading ? null : () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Container(
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
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 80),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Sign out icon with animation
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    child: Icon(
                      Icons.logout_rounded,
                      size: 90,
                      color: Colors.yellowAccent.shade700,
                      semanticLabel: 'Sign out icon',
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Title
                  const Text(
                    "Sign Out",
                    style: TextStyle(
                      fontSize: 34,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Subtitle
                  const Text(
                    "Are you sure you want to sign out of EliteFit?",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),

                  // Sign Out Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : signOutUser,
                      style: primaryButtonStyle.copyWith(
                        backgroundColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                            if (states.contains(MaterialState.disabled)) {
                              return Colors.grey.shade600;
                            }
                            return Colors.red.shade600;
                          },
                        ),
                      ),
                      child: _isLoading
                          ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(width: 12),
                          Text(
                            "Signing Out...",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      )
                          : const Text(
                        "Yes, Sign Out",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Cancel Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : cancelSignOut,
                      style: primaryButtonStyle.copyWith(
                        backgroundColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                            if (states.contains(MaterialState.disabled)) {
                              return Colors.grey.shade400;
                            }
                            return Colors.yellowAccent.shade700;
                          },
                        ),
                      ),
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          color: _isLoading ? Colors.grey.shade600 : Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  // Additional spacing for better visual balance
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}