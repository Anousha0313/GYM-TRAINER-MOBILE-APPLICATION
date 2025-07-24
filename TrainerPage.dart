// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'dart:math' as math;
// import 'package:newproject/WelcomePage.dart';
// import 'package:newproject/TrainerDetailPage.dart';
// class TrainerPage extends StatefulWidget {
//   @override
//   _TrainerPageState createState() => _TrainerPageState();
// }
//
// class _TrainerPageState extends State<TrainerPage> with TickerProviderStateMixin {
//   late AnimationController _fadeController;
//   late AnimationController _slideController;
//   late Animation<double> _fadeAnimation;
//   late Animation<Offset> _slideAnimation;
//
//   final List<Map<String, String>> trainerDetails = [
//     {
//       'trainerName': 'Fatima',
//       'gymName': 'FitLife Gym',
//       'exercise': 'Yoga, Cardio, HIIT',
//     },
//     {
//       'trainerName': 'Anousha',
//       'gymName': 'PowerHouse Gym',
//       'exercise': 'Weightlifting, CrossFit',
//     },
//     {
//       'trainerName': 'Aima',
//       'gymName': 'FlexZone Gym',
//       'exercise': 'Strength Training, Pilates',
//     },
//     {
//       'trainerName': 'Maria',
//       'gymName': 'GymX',
//       'exercise': 'Cycling, Aerobics',
//     },
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//
//     _fadeController = AnimationController(
//       duration: Duration(milliseconds: 800),
//       vsync: this,
//     );
//
//     _slideController = AnimationController(
//       duration: Duration(milliseconds: 1000),
//       vsync: this,
//     );
//
//     _fadeAnimation = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(CurvedAnimation(
//       parent: _fadeController,
//       curve: Curves.easeInOut,
//     ));
//
//     _slideAnimation = Tween<Offset>(
//       begin: Offset(0, 0.5),
//       end: Offset.zero,
//     ).animate(CurvedAnimation(
//       parent: _slideController,
//       curve: Curves.elasticOut,
//     ));
//
//     _fadeController.forward();
//     _slideController.forward();
//   }
//
//   @override
//   void dispose() {
//     _fadeController.dispose();
//     _slideController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: FadeTransition(
//           opacity: _fadeAnimation,
//           child: Text(
//             'Choose Your Trainer',
//             style: TextStyle(
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             ),
//           ),
//         ),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         flexibleSpace: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               colors: [Colors.black, Colors.blue.shade900],
//             ),
//           ),
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.logout, color: Colors.white),
//             tooltip: 'Logout',
//             onPressed: () async {
//               await FirebaseAuth.instance.signOut();
//               Navigator.of(context).pushReplacement(
//                 MaterialPageRoute(builder: (context) => WelcomePage()),
//               );
//             },
//           ),
//         ],
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [Colors.black, Colors.blue.shade900, Colors.purple.shade900],
//           ),
//         ),
//         child: SlideTransition(
//           position: _slideAnimation,
//           child: FadeTransition(
//             opacity: _fadeAnimation,
//             child: GridView.builder(
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 16,
//                 mainAxisSpacing: 16,
//                 childAspectRatio: 0.75,
//               ),
//               padding: EdgeInsets.all(16),
//               itemCount: trainerDetails.length,
//               itemBuilder: (context, index) {
//                 return AnimatedTrainerCard(
//                   trainer: trainerDetails[index],
//                   index: index,
//                   onTap: () => _showTrainerDialog(trainerDetails[index]),
//                 );
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _showTrainerDialog(Map<String, String> trainer) {
//     showGeneralDialog(
//       context: context,
//       barrierDismissible: true,
//       barrierLabel: '',
//       barrierColor: Colors.black54,
//       transitionDuration: Duration(milliseconds: 300),
//       pageBuilder: (context, animation1, animation2) {
//         return Container();
//       },
//       transitionBuilder: (context, animation1, animation2, widget) {
//         return Transform.scale(
//           scale: animation1.value,
//           child: Opacity(
//             opacity: animation1.value,
//             child: AlertDialog(
//               backgroundColor: Colors.grey.shade900,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               title: Text(
//                 'Trainer Info',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               content: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(15),
//                   gradient: LinearGradient(
//                     colors: [Colors.blue.shade800, Colors.purple.shade600],
//                   ),
//                 ),
//                 padding: EdgeInsets.all(16),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _buildInfoRow('Name', trainer['trainerName']!),
//                     SizedBox(height: 12),
//                     _buildInfoRow('Gym', trainer['gymName']!),
//                     SizedBox(height: 12),
//                     _buildInfoRow('Specializes in', trainer['exercise']!),
//                   ],
//                 ),
//               ),
//               actions: [
//                 TextButton(
//                   onPressed: () => Navigator.pop(context),
//                   child: Text(
//                     'Close',
//                     style: TextStyle(color: Colors.grey.shade300),
//                   ),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                     _navigateToTrainerDetail(trainer);
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.yellow.shade700,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   child: Text(
//                     'Select Trainer',
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   Widget _buildInfoRow(String label, String value) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           '$label: ',
//           style: TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//             fontSize: 14,
//           ),
//         ),
//         Expanded(
//           child: Text(
//             value,
//             style: TextStyle(
//               color: Colors.white70,
//               fontSize: 14,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   void _navigateToTrainerDetail(Map<String, String> trainer) {
//     Widget detailPage = TrainerDetailPage(trainer: trainer);
//
//     Navigator.push(
//       context,
//       PageRouteBuilder(
//         pageBuilder: (context, animation, secondaryAnimation) => detailPage,
//         transitionsBuilder: (context, animation, secondaryAnimation, child) {
//           return SlideTransition(
//             position: animation.drive(
//               Tween(begin: Offset(1.0, 0.0), end: Offset.zero)
//                   .chain(CurveTween(curve: Curves.elasticOut)),
//             ),
//             child: child,
//           );
//         },
//         transitionDuration: Duration(milliseconds: 800),
//       ),
//     );
//   }
// }
// class AnimatedTrainerCard extends StatefulWidget {
//   final Map<String, String> trainer;
//   final int index;
//   final VoidCallback onTap;
//
//   const AnimatedTrainerCard({
//     Key? key,
//     required this.trainer,
//     required this.index,
//     required this.onTap,
//   }) : super(key: key);
//
//   @override
//   _AnimatedTrainerCardState createState() => _AnimatedTrainerCardState();
// }
//
// class _AnimatedTrainerCardState extends State<AnimatedTrainerCard>
//     with TickerProviderStateMixin {
//   late AnimationController _controller;
//   late AnimationController _bounceController;
//   late Animation<double> _scaleAnimation;
//   late Animation<double> _rotationAnimation;
//   late Animation<double> _bounceAnimation;
//   bool _isHovered = false;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _controller = AnimationController(
//       duration: Duration(milliseconds: 200),
//       vsync: this,
//     );
//
//     _bounceController = AnimationController(
//       duration: Duration(milliseconds: 600),
//       vsync: this,
//     );
//
//     _scaleAnimation = Tween<double>(
//       begin: 1.0,
//       end: 1.05,
//     ).animate(CurvedAnimation(
//       parent: _controller,
//       curve: Curves.easeInOut,
//     ));
//
//     _rotationAnimation = Tween<double>(
//       begin: 0.0,
//       end: 0.02,
//     ).animate(CurvedAnimation(
//       parent: _controller,
//       curve: Curves.easeInOut,
//     ));
//
//     _bounceAnimation = Tween<double>(
//       begin: 1.0,
//       end: 1.1,
//     ).animate(CurvedAnimation(
//       parent: _bounceController,
//       curve: Curves.elasticOut,
//     ));
//
//     // Staggered entrance animation
//     Future.delayed(Duration(milliseconds: widget.index * 150), () {
//       if (mounted) {
//         _bounceController.forward();
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     _bounceController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ScaleTransition(
//       scale: _bounceAnimation,
//       child: AnimatedBuilder(
//         animation: _controller,
//         builder: (context, child) {
//           return Transform.scale(
//             scale: _scaleAnimation.value,
//             child: Transform.rotate(
//               angle: _rotationAnimation.value,
//               child: GestureDetector(
//                 onTapDown: (_) {
//                   _controller.forward();
//                 },
//                 onTapUp: (_) {
//                   _controller.reverse();
//                   widget.onTap();
//                 },
//                 onTapCancel: () {
//                   _controller.reverse();
//                 },
//                 child: MouseRegion(
//                   onEnter: (_) {
//                     setState(() => _isHovered = true);
//                     _controller.forward();
//                   },
//                   onExit: (_) {
//                     setState(() => _isHovered = false);
//                     _controller.reverse();
//                   },
//                   child: Card(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(25),
//                     ),
//                     elevation: _isHovered ? 12 : 8,
//                     clipBehavior: Clip.antiAlias,
//                     child: Container(
//                       padding: EdgeInsets.all(16),
//                       decoration: BoxDecoration(
//                         gradient: LinearGradient(
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomRight,
//                           colors: [
//                             Colors.blue.shade800,
//                             Colors.purple.shade600,
//                             Colors.pink.shade400,
//                           ],
//                         ),
//                       ),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           Hero(
//                             tag: 'trainer_${widget.trainer['trainerName']}',
//                             child: Container(
//                               width: 60,
//                               height: 60,
//                               decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 gradient: LinearGradient(
//                                   colors: [Colors.yellow.shade600, Colors.orange.shade400],
//                                 ),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.black26,
//                                     blurRadius: 8,
//                                     offset: Offset(0, 4),
//                                   ),
//                                 ],
//                               ),
//                               child: Icon(
//                                 Icons.person,
//                                 size: 30,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                           Text(
//                             widget.trainer['trainerName']!,
//                             style: TextStyle(
//                               fontSize: 22,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white,
//                               shadows: [
//                                 Shadow(
//                                   offset: Offset(0, 2),
//                                   blurRadius: 4,
//                                   color: Colors.black38,
//                                 ),
//                               ],
//                             ),
//                             textAlign: TextAlign.center,
//                           ),
//                           Text(
//                             widget.trainer['gymName']!,
//                             style: TextStyle(
//                               fontSize: 14,
//                               color: Colors.white70,
//                               fontWeight: FontWeight.w500,
//                             ),
//                             textAlign: TextAlign.center,
//                           ),
//                           Container(
//                             width: double.infinity,
//                             child: ElevatedButton(
//                               onPressed: widget.onTap,
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.yellow.shade700,
//                                 foregroundColor: Colors.black,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(20),
//                                 ),
//                                 elevation: 4,
//                                 padding: EdgeInsets.symmetric(vertical: 12),
//                               ),
//                               child: Text(
//                                 'View Details',
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 14,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
//
// class GradientAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final String title;
//   final List<Color> gradientColors;
//
//   const GradientAppBar({
//     Key? key,
//     required this.title,
//     required this.gradientColors,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       flexibleSpace: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: gradientColors,
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//       ),
//       title: Text(title),
//       centerTitle: true,
//       elevation: 0,
//     );
//   }
//
//   @override
//   Size get preferredSize => Size.fromHeight(kToolbarHeight);
// }
// i
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'TrainerDetailPage.dart';
//
// class TrainerPage extends StatelessWidget {
//   const TrainerPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Trainers")),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance.collection('trainers').snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.hasError) return Center(child: Text('Error: ${snapshot.error}'));
//           if (snapshot.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator());
//
//           final trainers = snapshot.data!.docs;
//
//           return ListView.builder(
//             itemCount: trainers.length,
//             itemBuilder: (context, index) {
//               final trainer = trainers[index];
//               return Card(
//                 elevation: 5,
//                 margin: const EdgeInsets.all(12),
//                 child: ListTile(
//                   title: Text(trainer['name']),
//                   subtitle: Text(trainer['gymName']),
//                   trailing: const Icon(Icons.arrow_forward_ios),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) => TrainerDetailPage(trainerId: trainer.id, trainer: {},),
//                       ),
//                     );
//                   },
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'TrainerDetailPage.dart';
//
// class TrainerPage extends StatelessWidget {
//   const TrainerPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Our Trainers"),
//         backgroundColor: Colors.deepPurple,
//         foregroundColor: Colors.white,
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance.collection('trainers').snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.hasError) return Center(child: Text('Error: ${snapshot.error}'));
//           if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
//
//           final trainers = snapshot.data!.docs;
//
//           if (trainers.isEmpty) {
//             return const Center(child: Text('No trainers found.'));
//           }
//
//           return ListView.builder(
//             itemCount: trainers.length,
//             itemBuilder: (context, index) {
//               final trainer = trainers[index];
//
//               return Card(
//                 elevation: 5,
//                 margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                 child: ListTile(
//                   contentPadding: const EdgeInsets.all(16),
//                   leading: const Icon(Icons.fitness_center, color: Colors.deepPurple),
//                   title: Text(trainer['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
//                   subtitle: Text(trainer['gymName']),
//                   trailing: const Icon(Icons.arrow_forward_ios),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) => TrainerDetailPage(trainerId: trainer.id),
//                       ),
//                     );
//                   },
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'TrainerDetailPage.dart';
//
// class TrainerPage extends StatelessWidget {
//   const TrainerPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "Our Trainers",
//           style: TextStyle(fontWeight: FontWeight.w600),
//         ),
//         backgroundColor: Colors.deepPurple,
//         foregroundColor: Colors.white,
//         elevation: 0,
//       ),
//       backgroundColor: Colors.grey[50],
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance
//             .collection('trainers')
//             .orderBy('name')
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
//                   const SizedBox(height: 16),
//                   Text(
//                     'Something went wrong',
//                     style: Theme.of(context).textTheme.headlineSmall,
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     'Please try again later',
//                     style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                       color: Colors.grey[600],
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           }
//
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   CircularProgressIndicator(
//                     valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),
//                   ),
//                   SizedBox(height: 16),
//                   Text('Loading trainers...'),
//                 ],
//               ),
//             );
//           }
//
//           final trainers = snapshot.data!.docs;
//
//           if (trainers.isEmpty) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(
//                     Icons.people_outline,
//                     size: 64,
//                     color: Colors.grey[400],
//                   ),
//                   const SizedBox(height: 16),
//                   Text(
//                     'No trainers available',
//                     style: Theme.of(context).textTheme.headlineSmall?.copyWith(
//                       color: Colors.grey[600],
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     'Check back later for new trainers',
//                     style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                       color: Colors.grey[500],
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           }
//
//           return RefreshIndicator(
//             onRefresh: () async {
//               // Force refresh by rebuilding the stream
//               await Future.delayed(const Duration(milliseconds: 500));
//             },
//             child: ListView.builder(
//               padding: const EdgeInsets.symmetric(vertical: 8),
//               itemCount: trainers.length,
//               itemBuilder: (context, index) {
//                 final trainer = trainers[index];
//                 final data = trainer.data() as Map<String, dynamic>;
//
//                 return Card(
//                   elevation: 2,
//                   margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: InkWell(
//                     borderRadius: BorderRadius.circular(12),
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) => TrainerDetailPage(trainerId: trainer.id),
//                         ),
//                       );
//                     },
//                     child: Padding(
//                       padding: const EdgeInsets.all(16),
//                       child: Row(
//                         children: [
//                           Container(
//                             width: 50,
//                             height: 50,
//                             decoration: BoxDecoration(
//                               color: Colors.deepPurple.withOpacity(0.1),
//                               borderRadius: BorderRadius.circular(25),
//                             ),
//                             child: const Icon(
//                               Icons.fitness_center,
//                               color: Colors.deepPurple,
//                               size: 24,
//                             ),
//                           ),
//                           const SizedBox(width: 16),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   data['name'] ?? 'Unknown Trainer',
//                                   style: const TextStyle(
//                                     fontWeight: FontWeight.w600,
//                                     fontSize: 16,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 4),
//                                 Row(
//                                   children: [
//                                     Icon(
//                                       Icons.location_on_outlined,
//                                       size: 16,
//                                       color: Colors.grey[600],
//                                     ),
//                                     const SizedBox(width: 4),
//                                     Expanded(
//                                       child: Text(
//                                         data['gymName'] ?? 'No gym specified',
//                                         style: TextStyle(
//                                           color: Colors.grey[600],
//                                           fontSize: 14,
//                                         ),
//                                         overflow: TextOverflow.ellipsis,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Icon(
//                             Icons.arrow_forward_ios,
//                             size: 16,
//                             color: Colors.grey[400],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newproject/SignOutPage.dart';
import 'TrainerDetailPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
class TrainerPage extends StatelessWidget {
  const TrainerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Our Trainers",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 24,
            letterSpacing: 0.5,
          ),
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF6A5ACD),
                Color(0xFF9370DB),
                Color(0xFFBA55D3),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFF8F9FF),
                  Color(0xFFF0F4FF),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('trainers')
                  .orderBy('name')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Container(
                      padding: const EdgeInsets.all(32),
                      margin: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.red.withOpacity(0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.error_outline_rounded,
                              size: 48,
                              color: Colors.red[400],
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            'Something went wrong',
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[800],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Please try again later',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Container(
                      padding: const EdgeInsets.all(32),
                      margin: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.deepPurple.withOpacity(0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF6A5ACD), Color(0xFF9370DB)],
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              strokeWidth: 3,
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            'Loading trainers...',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                final trainers = snapshot.data!.docs;

                if (trainers.isEmpty) {
                  return Center(
                    child: Container(
                      padding: const EdgeInsets.all(32),
                      margin: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.people_outline_rounded,
                              size: 48,
                              color: Colors.grey[400],
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            'No trainers available',
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[700],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Check back later for new trainers',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return RefreshIndicator(
                  color: Colors.deepPurple,
                  backgroundColor: Colors.white,
                  onRefresh: () async {
                    // Force refresh by rebuilding the stream
                    await Future.delayed(const Duration(milliseconds: 500));
                  },
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    itemCount: trainers.length,
                    itemBuilder: (context, index) {
                      final trainer = trainers[index];
                      final data = trainer.data() as Map<String, dynamic>;

                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        child: Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: const LinearGradient(
                                colors: [Colors.white, Color(0xFFFBFCFF)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.deepPurple.withOpacity(0.08),
                                  blurRadius: 20,
                                  offset: const Offset(0, 8),
                                ),
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.02),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                              border: Border.all(
                                color: Colors.deepPurple.withOpacity(0.05),
                                width: 1,
                              ),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(20),
                                onTap: () async {
                                  final uid = FirebaseAuth.instance.currentUser!.uid;
                                  final trainerTopic = data['name'].toLowerCase().replaceAll(' ', '_');
// you can also use data['name'].toLowerCase()

                                  // 🔥 Store topic in Firestore under user
                                  await FirebaseFirestore.instance.collection('users').doc(uid).set({
                                    'trainer': data['name'],
                                    'subscribedTopic': trainerTopic,
                                  }, SetOptions(merge: true));

                                  // 🔔 Subscribe to the topic
                                  await FirebaseMessaging.instance.subscribeToTopic(trainerTopic);
                                  print('✅ Subscribed to topic: $trainerTopic');

                                  // Go to trainer detail page
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => TrainerDetailPage(trainerId: trainer.id),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 64,
                                        height: 64,
                                        decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                            colors: [
                                              Color(0xFF6A5ACD),
                                              Color(0xFF9370DB),
                                              Color(0xFFBA55D3),
                                            ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ),
                                          borderRadius: BorderRadius.circular(18),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.deepPurple.withOpacity(0.3),
                                              blurRadius: 12,
                                              offset: const Offset(0, 4),
                                            ),
                                          ],
                                        ),
                                        child: const Icon(
                                          Icons.fitness_center_rounded,
                                          color: Colors.white,
                                          size: 28,
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              data['name'] ?? 'Unknown Trainer',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 18,
                                                color: Color(0xFF2D3748),
                                                letterSpacing: 0.3,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Row(
                                              children: [
                                                Container(
                                                  padding: const EdgeInsets.all(4),
                                                  decoration: BoxDecoration(
                                                    color: Colors.deepPurple.withOpacity(0.1),
                                                    borderRadius: BorderRadius.circular(6),
                                                  ),
                                                  child: Icon(
                                                    Icons.location_on_rounded,
                                                    size: 16,
                                                    color: Colors.deepPurple[400],
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                                Expanded(
                                                  child: Text(
                                                    data['gymName'] ?? 'No gym specified',
                                                    style: TextStyle(
                                                      color: Colors.grey[600],
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.deepPurple.withOpacity(0.05),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          size: 16,
                                          color: Colors.deepPurple[300],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          // Sign Out Button positioned at bottom left
          Positioned(
            bottom: 13,
            right: 20,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignOutPage()),
                );
              },
              backgroundColor: const Color(0xFFEF4444),
              foregroundColor: Colors.white,
              elevation: 8,
              child: const Icon(Icons.logout),
            ),
          )
        ],
      ),

    );

  }
}