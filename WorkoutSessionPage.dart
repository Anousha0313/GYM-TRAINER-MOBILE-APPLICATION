// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:intl/intl.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'dart:math' as math;
// import 'dart:async';
//
// class WorkoutSessionPage extends StatefulWidget {
//   final Map<String, String> trainer;
//
//   WorkoutSessionPage({Key? key, required this.trainer}) : super(key: key);
//
//   @override
//   _WorkoutSessionPageState createState() => _WorkoutSessionPageState();
// }
//
// class _WorkoutSessionPageState extends State<WorkoutSessionPage>
//     with TickerProviderStateMixin {
//   late AnimationController _animationController;
//   late AnimationController _pulseController;
//   late AnimationController _progressController;
//   late Animation<double> _fadeAnimation;
//   late Animation<double> _pulseAnimation;
//   late Animation<double> _progressAnimation;
//
//   Set<int> completedExercises = {};
//   int totalCaloriesBurned = 0;
//   DateTime? sessionStartTime;
//   Timer? _sessionTimer;
//   int sessionDurationSeconds = 0;
//   bool isSessionActive = true;
//   bool showMotivationalMessage = false;
//   String currentMotivationalMessage = '';
//
//   // Motivational messages
//   final List<String> motivationalMessages = [
//     "You're doing great! Keep pushing!",
//     "Every rep counts! Stay strong!",
//     "Feel the burn, embrace the gain!",
//     "You're stronger than you think!",
//     "Progress, not perfection!",
//     "Your only competition is yourself!",
//     "Champions are made in the gym!",
//     "Sweat is just fat crying!",
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeAnimations();
//     _startSession();
//   }
//
//   void _initializeAnimations() {
//     _animationController = AnimationController(
//       duration: Duration(milliseconds: 1200),
//       vsync: this,
//     );
//
//     _pulseController = AnimationController(
//       duration: Duration(milliseconds: 1500),
//       vsync: this,
//     )..repeat(reverse: true);
//
//     _progressController = AnimationController(
//       duration: Duration(milliseconds: 800),
//       vsync: this,
//     );
//
//     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
//     );
//
//     _pulseAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
//       CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
//     );
//
//     _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _progressController, curve: Curves.elasticOut),
//     );
//
//     _animationController.forward();
//   }
//
//   void _startSession() {
//     sessionStartTime = DateTime.now();
//     _sessionTimer = Timer.periodic(Duration(seconds: 1), (timer) {
//       if (mounted) {
//         setState(() {
//           sessionDurationSeconds++;
//         });
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     _animationController.dispose();
//     _pulseController.dispose();
//     _progressController.dispose();
//     _sessionTimer?.cancel();
//     super.dispose();
//   }
//
//   // Enhanced exercise details with more comprehensive information
//   final Map<String, Map<String, dynamic>> exerciseDetails = {
//     'Yoga': {
//       'duration': '15 mins',
//       'times': '1 turn',
//       'calories': 60,
//       'difficulty': 'Easy',
//       'icon': Icons.self_improvement,
//       'color': Colors.green,
//       'description': 'Flexibility and mindfulness practice',
//       'targetMuscles': ['Core', 'Flexibility', 'Balance'],
//       'tips': 'Focus on breathing and proper form'
//     },
//     'Cardio': {
//       'duration': '10 mins',
//       'times': '1 turn',
//       'calories': 120,
//       'difficulty': 'Medium',
//       'icon': Icons.directions_run,
//       'color': Colors.orange,
//       'description': 'Heart rate boosting exercise',
//       'targetMuscles': ['Cardiovascular', 'Legs', 'Core'],
//       'tips': 'Maintain steady pace and breathing'
//     },
//     'HIIT': {
//       'duration': '15 mins',
//       'times': '3 turns',
//       'calories': 200,
//       'difficulty': 'Hard',
//       'icon': Icons.flash_on,
//       'color': Colors.red,
//       'description': 'High intensity interval training',
//       'targetMuscles': ['Full Body', 'Cardiovascular'],
//       'tips': 'Give maximum effort during work intervals'
//     },
//     'Weightlifting': {
//       'duration': '10 mins',
//       'times': '2 turns',
//       'calories': 150,
//       'difficulty': 'Hard',
//       'icon': Icons.fitness_center,
//       'color': Colors.blue,
//       'description': 'Strength building with weights',
//       'targetMuscles': ['Arms', 'Chest', 'Back'],
//       'tips': 'Control the weight, don\'t let it control you'
//     },
//     'CrossFit': {
//       'duration': '25 mins',
//       'times': '3 turns',
//       'calories': 300,
//       'difficulty': 'Hard',
//       'icon': Icons.sports_gymnastics,
//       'color': Colors.purple,
//       'description': 'Functional movement training',
//       'targetMuscles': ['Full Body', 'Functional'],
//       'tips': 'Scale movements to your ability level'
//     },
//     'Strength Training': {
//       'duration': '35 mins',
//       'times': '2 turns',
//       'calories': 250,
//       'difficulty': 'Hard',
//       'icon': Icons.sports_kabaddi,
//       'color': Colors.indigo,
//       'description': 'Build muscle and power',
//       'targetMuscles': ['Major Muscle Groups'],
//       'tips': 'Progressive overload is key to growth'
//     },
//     'Pilates': {
//       'duration': '30 mins',
//       'times': '1 turn',
//       'calories': 180,
//       'difficulty': 'Medium',
//       'icon': Icons.spa,
//       'color': Colors.teal,
//       'description': 'Core strength and flexibility',
//       'targetMuscles': ['Core', 'Stability', 'Flexibility'],
//       'tips': 'Quality over quantity, focus on alignment'
//     },
//     'Cycling': {
//       'duration': '50 mins',
//       'times': '1 turn',
//       'calories': 400,
//       'difficulty': 'Medium',
//       'icon': Icons.directions_bike,
//       'color': Colors.cyan,
//       'description': 'Endurance and leg strength',
//       'targetMuscles': ['Legs', 'Cardiovascular', 'Glutes'],
//       'tips': 'Maintain proper bike posture'
//     },
//     'Aerobics': {
//       'duration': '40 mins',
//       'times': '2 turns',
//       'calories': 320,
//       'difficulty': 'Medium',
//       'icon': Icons.music_note,
//       'color': Colors.pink,
//       'description': 'Rhythmic cardio workout',
//       'targetMuscles': ['Cardiovascular', 'Coordination'],
//       'tips': 'Move to the rhythm and have fun'
//     },
//   };
//
//   void toggleExerciseCompletion(int index, int calories) {
//     HapticFeedback.lightImpact();
//     setState(() {
//       if (completedExercises.contains(index)) {
//         completedExercises.remove(index);
//         totalCaloriesBurned -= calories;
//       } else {
//         completedExercises.add(index);
//         totalCaloriesBurned += calories;
//         _showMotivationalMessage();
//         _progressController.forward().then((_) {
//           _progressController.reset();
//         });
//       }
//     });
//   }
//
//   void _showMotivationalMessage() {
//     final random = math.Random();
//     currentMotivationalMessage = motivationalMessages[
//     random.nextInt(motivationalMessages.length)];
//
//     setState(() {
//       showMotivationalMessage = true;
//     });
//
//     Timer(Duration(seconds: 3), () {
//       if (mounted) {
//         setState(() {
//           showMotivationalMessage = false;
//         });
//       }
//     });
//   }
//
//   String getSessionDuration() {
//     final hours = sessionDurationSeconds ~/ 3600;
//     final minutes = (sessionDurationSeconds % 3600) ~/ 60;
//     final seconds = sessionDurationSeconds % 60;
//
//     if (hours > 0) {
//       return "${hours}h ${minutes}m";
//     } else {
//       return "${minutes}m ${seconds}s";
//     }
//   }
//
//   Color getDifficultyColor(String difficulty) {
//     switch (difficulty.toLowerCase()) {
//       case 'easy':
//         return Colors.green;
//       case 'medium':
//         return Colors.orange;
//       case 'hard':
//         return Colors.red;
//       default:
//         return Colors.grey;
//     }
//   }
//
//   void _pauseSession() {
//     setState(() {
//       isSessionActive = false;
//     });
//     _sessionTimer?.cancel();
//   }
//
//   void _resumeSession() {
//     setState(() {
//       isSessionActive = true;
//     });
//     _sessionTimer = Timer.periodic(Duration(seconds: 1), (timer) {
//       if (mounted) {
//         setState(() {
//           sessionDurationSeconds++;
//         });
//       }
//     });
//   }
//
//   void _endSession() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//           backgroundColor: Colors.deepPurple.shade800,
//           title: Text(
//             'End Workout Session?',
//             style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//           ),
//           content: Text(
//             'Are you sure you want to end this workout session?',
//             style: TextStyle(color: Colors.white70),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: Text('Continue', style: TextStyle(color: Colors.white70)),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pop(context);
//                 _saveWorkoutSession();
//                 Navigator.pop(context);
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.red,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//               child: Text('End Session', style: TextStyle(color: Colors.white)),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   Future<void> _saveWorkoutSession() async {
//     try {
//       final user = FirebaseAuth.instance.currentUser;
//       if (user != null) {
//         await FirebaseFirestore.instance.collection('workout_sessions').add({
//           'userId': user.uid,
//           'trainerName': widget.trainer['trainerName'],
//           'gymName': widget.trainer['gymName'],
//           'completedExercises': completedExercises.length,
//           'totalExercises': widget.trainer['exercise']?.split(',').length ?? 0,
//           'caloriesBurned': totalCaloriesBurned,
//           'sessionDuration': sessionDurationSeconds,
//           'sessionDate': DateTime.now(),
//           'exercises': widget.trainer['exercise']?.split(',') ?? [],
//         });
//       }
//     } catch (e) {
//       print('Error saving workout session: $e');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final exercises = widget.trainer['exercise'] != null
//         ? widget.trainer['exercise']!.split(',').map((e) => e.trim()).toList()
//         : <String>[];
//
//     final completionPercentage = exercises.isEmpty
//         ? 0.0
//         : (completedExercises.length / exercises.length);
//
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Colors.deepPurple.shade300,
//               Colors.deepPurple.shade600,
//               Colors.deepPurple.shade900
//             ],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: SafeArea(
//           child: FadeTransition(
//             opacity: _fadeAnimation,
//             child: Stack(
//               children: [
//                 Column(
//                   children: [
//                     // Enhanced Header with session controls
//                     Container(
//                       padding: EdgeInsets.all(20),
//                       child: Column(
//                         children: [
//                           Row(
//                             children: [
//                               IconButton(
//                                 onPressed: _endSession,
//                                 icon: Icon(Icons.close,
//                                     color: Colors.white, size: 24),
//                               ),
//                               Expanded(
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     AnimatedBuilder(
//                                       animation: _pulseAnimation,
//                                       builder: (context, child) {
//                                         return Transform.scale(
//                                           scale: isSessionActive ? _pulseAnimation.value : 1.0,
//                                           child: Container(
//                                             padding: EdgeInsets.symmetric(
//                                                 horizontal: 12, vertical: 6),
//                                             decoration: BoxDecoration(
//                                               color: isSessionActive
//                                                   ? Colors.green
//                                                   : Colors.orange,
//                                               borderRadius: BorderRadius.circular(20),
//                                             ),
//                                             child: Row(
//                                               mainAxisSize: MainAxisSize.min,
//                                               children: [
//                                                 Icon(
//                                                   isSessionActive
//                                                       ? Icons.play_arrow
//                                                       : Icons.pause,
//                                                   color: Colors.white,
//                                                   size: 16,
//                                                 ),
//                                                 SizedBox(width: 4),
//                                                 Text(
//                                                   isSessionActive ? 'ACTIVE' : 'PAUSED',
//                                                   style: TextStyle(
//                                                     color: Colors.white,
//                                                     fontWeight: FontWeight.bold,
//                                                     fontSize: 12,
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         );
//                                       },
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               IconButton(
//                                 onPressed: isSessionActive ? _pauseSession : _resumeSession,
//                                 icon: Icon(
//                                   isSessionActive ? Icons.pause : Icons.play_arrow,
//                                   color: Colors.white,
//                                   size: 24,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 20),
//
//                           // Enhanced Trainer Info Card
//                           Container(
//                             padding: EdgeInsets.all(16),
//                             decoration: BoxDecoration(
//                               color: Colors.white.withOpacity(0.15),
//                               borderRadius: BorderRadius.circular(20),
//                               border: Border.all(color: Colors.white.withOpacity(0.3)),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.black.withOpacity(0.1),
//                                   blurRadius: 10,
//                                   offset: Offset(0, 5),
//                                 ),
//                               ],
//                             ),
//                             child: Row(
//                               children: [
//                                 Hero(
//                                   tag: 'trainer_${widget.trainer['trainerName']}',
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                       shape: BoxShape.circle,
//                                       boxShadow: [
//                                         BoxShadow(
//                                           color: Colors.black.withOpacity(0.2),
//                                           blurRadius: 8,
//                                           offset: Offset(0, 4),
//                                         ),
//                                       ],
//                                     ),
//                                     child: CircleAvatar(
//                                       radius: 35,
//                                       backgroundColor: Colors.white,
//                                       child: CircleAvatar(
//                                         radius: 32,
//                                         backgroundColor: Colors.deepPurple.shade400,
//                                         child: Text(
//                                           widget.trainer['trainerName'] != null &&
//                                               widget.trainer['trainerName']!.isNotEmpty
//                                               ? widget.trainer['trainerName']!
//                                               .substring(0, 1).toUpperCase()
//                                               : '?',
//                                           style: TextStyle(
//                                             fontSize: 24,
//                                             fontWeight: FontWeight.bold,
//                                             color: Colors.white,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(width: 16),
//                                 Expanded(
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         widget.trainer['trainerName'] ?? 'Trainer',
//                                         style: TextStyle(
//                                           fontSize: 20,
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                       SizedBox(height: 4),
//                                       Row(
//                                         children: [
//                                           Icon(Icons.location_on,
//                                               color: Colors.white70, size: 16),
//                                           SizedBox(width: 4),
//                                           Expanded(
//                                             child: Text(
//                                               widget.trainer['gymName'] ?? 'N/A',
//                                               style: TextStyle(
//                                                 fontSize: 14,
//                                                 color: Colors.white70,
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       SizedBox(height: 8),
//                                       Container(
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal: 8, vertical: 4),
//                                         decoration: BoxDecoration(
//                                           color: Colors.white.withOpacity(0.2),
//                                           borderRadius: BorderRadius.circular(12),
//                                         ),
//                                         child: Text(
//                                           '${exercises.length} exercises planned',
//                                           style: TextStyle(
//                                             fontSize: 12,
//                                             color: Colors.white,
//                                             fontWeight: FontWeight.w500,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//
//                     // Enhanced Progress Stats
//                     Container(
//                       margin: EdgeInsets.symmetric(horizontal: 20),
//                       padding: EdgeInsets.all(16),
//                       decoration: BoxDecoration(
//                         color: Colors.white.withOpacity(0.15),
//                         borderRadius: BorderRadius.circular(16),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.1),
//                             blurRadius: 8,
//                             offset: Offset(0, 4),
//                           ),
//                         ],
//                       ),
//                       child: Column(
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceAround,
//                             children: [
//                               _buildEnhancedStatItem(
//                                 'Exercises',
//                                 '${completedExercises.length}/${exercises.length}',
//                                 Icons.fitness_center,
//                                 Colors.blue,
//                               ),
//                               _buildEnhancedStatItem(
//                                 'Calories',
//                                 '${totalCaloriesBurned}',
//                                 Icons.local_fire_department,
//                                 Colors.orange,
//                               ),
//                               _buildEnhancedStatItem(
//                                 'Duration',
//                                 getSessionDuration(),
//                                 Icons.timer,
//                                 Colors.green,
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 20),
//
//                           // Enhanced Progress Bar
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                     'Overall Progress',
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.w600,
//                                       fontSize: 16,
//                                     ),
//                                   ),
//                                   Container(
//                                     padding: EdgeInsets.symmetric(
//                                         horizontal: 12, vertical: 6),
//                                     decoration: BoxDecoration(
//                                       color: completionPercentage >= 1.0
//                                           ? Colors.green
//                                           : Colors.white.withOpacity(0.2),
//                                       borderRadius: BorderRadius.circular(12),
//                                     ),
//                                     child: Text(
//                                       '${(completionPercentage * 100).toInt()}%',
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 14,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(height: 12),
//                               AnimatedBuilder(
//                                 animation: _progressAnimation,
//                                 builder: (context, child) {
//                                   return Container(
//                                     height: 12,
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(6),
//                                       gradient: LinearGradient(
//                                         colors: [
//                                           Colors.white.withOpacity(0.2),
//                                           Colors.white.withOpacity(0.1),
//                                         ],
//                                       ),
//                                     ),
//                                     child: ClipRRect(
//                                       borderRadius: BorderRadius.circular(6),
//                                       child: LinearProgressIndicator(
//                                         value: completionPercentage * _progressAnimation.value,
//                                         backgroundColor: Colors.transparent,
//                                         valueColor: AlwaysStoppedAnimation<Color>(
//                                           completionPercentage < 0.3
//                                               ? Colors.red
//                                               : completionPercentage < 0.7
//                                               ? Colors.orange
//                                               : Colors.green,
//                                         ),
//                                       ),
//                                     ),
//                                   );
//                                 },
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//
//                     SizedBox(height: 20),
//
//                     // Enhanced Exercise List
//                     Expanded(
//                       child: Container(
//                         margin: EdgeInsets.symmetric(horizontal: 20),
//                         child: exercises.isEmpty
//                             ? _buildEmptyState()
//                             : ListView.builder(
//                           physics: BouncingScrollPhysics(),
//                           itemCount: exercises.length,
//                           itemBuilder: (context, index) {
//                             return _buildEnhancedExerciseCard(
//                                 exercises[index], index);
//                           },
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//
//                 // Motivational Message Overlay
//                 if (showMotivationalMessage)
//                   AnimatedPositioned(
//                     duration: Duration(milliseconds: 500),
//                     top: showMotivationalMessage ? 100 : -100,
//                     left: 20,
//                     right: 20,
//                     child: Container(
//                       padding: EdgeInsets.all(16),
//                       decoration: BoxDecoration(
//                         color: Colors.green.withOpacity(0.9),
//                         borderRadius: BorderRadius.circular(16),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.2),
//                             blurRadius: 10,
//                             offset: Offset(0, 5),
//                           ),
//                         ],
//                       ),
//                       child: Row(
//                         children: [
//                           Icon(Icons.emoji_events, color: Colors.white, size: 24),
//                           SizedBox(width: 12),
//                           Expanded(
//                             child: Text(
//                               currentMotivationalMessage,
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 16,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildEnhancedStatItem(String label, String value, IconData icon, Color color) {
//     return Column(
//       children: [
//         Container(
//           padding: EdgeInsets.all(12),
//           decoration: BoxDecoration(
//             color: color.withOpacity(0.2),
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Icon(icon, color: color, size: 24),
//         ),
//         SizedBox(height: 8),
//         Text(
//           value,
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//         Text(
//           label,
//           style: TextStyle(
//             fontSize: 12,
//             color: Colors.white70,
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildEmptyState() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             padding: EdgeInsets.all(24),
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.1),
//               shape: BoxShape.circle,
//             ),
//             child: Icon(Icons.fitness_center, size: 64, color: Colors.white54),
//           ),
//           SizedBox(height: 24),
//           Text(
//             'No exercises available',
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//               color: Colors.white54,
//             ),
//           ),
//           SizedBox(height: 8),
//           Text(
//             'Contact your trainer to add exercises',
//             style: TextStyle(
//               fontSize: 16,
//               color: Colors.white38,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildEnhancedExerciseCard(String exerciseName, int index) {
//     final details = exerciseDetails[exerciseName] ?? {
//       'duration': '-',
//       'times': '-',
//       'calories': 0,
//       'difficulty': 'Unknown',
//       'icon': Icons.fitness_center,
//       'color': Colors.grey,
//       'description': 'Exercise details not available',
//       'targetMuscles': ['Unknown'],
//       'tips': 'No tips available'
//     };
//
//     final isCompleted = completedExercises.contains(index);
//
//     return Container(
//       margin: EdgeInsets.only(bottom: 16),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           borderRadius: BorderRadius.circular(20),
//           onTap: () => toggleExerciseCompletion(index, details['calories']),
//           child: AnimatedContainer(
//             duration: Duration(milliseconds: 400),
//             padding: EdgeInsets.all(20),
//             decoration: BoxDecoration(
//               color: isCompleted
//                   ? Colors.green.withOpacity(0.2)
//                   : Colors.white.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(20),
//               border: Border.all(
//                 color: isCompleted
//                     ? Colors.green
//                     : Colors.white.withOpacity(0.2),
//                 width: isCompleted ? 2 : 1,
//               ),
//               boxShadow: isCompleted
//                   ? [
//                 BoxShadow(
//                   color: Colors.green.withOpacity(0.3),
//                   blurRadius: 10,
//                   offset: Offset(0, 5),
//                 ),
//               ]
//                   : [],
//             ),
//             child: Column(
//               children: [
//                 Row(
//                   children: [
//                     Hero(
//                       tag: 'exercise_${index}',
//                       child: Container(
//                         padding: EdgeInsets.all(16),
//                         decoration: BoxDecoration(
//                           color: (details['color'] as Color).withOpacity(0.2),
//                           borderRadius: BorderRadius.circular(16),
//                         ),
//                         child: Icon(
//                           details['icon'],
//                           color: details['color'],
//                           size: 28,
//                         ),
//                       ),
//                     ),
//                     SizedBox(width: 16),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             children: [
//                               Expanded(
//                                 child: Text(
//                                   exerciseName,
//                                   style: TextStyle(
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.white,
//                                     decoration: isCompleted
//                                         ? TextDecoration.lineThrough
//                                         : TextDecoration.none,
//                                   ),
//                                 ),
//                               ),
//                               Container(
//                                 padding: EdgeInsets.symmetric(
//                                     horizontal: 10, vertical: 6),
//                                 decoration: BoxDecoration(
//                                   color: getDifficultyColor(details['difficulty']),
//                                   borderRadius: BorderRadius.circular(12),
//                                 ),
//                                 child: Text(
//                                   details['difficulty'],
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 6),
//                           Text(
//                             details['description'],
//                             style: TextStyle(
//                               color: Colors.white70,
//                               fontSize: 15,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(width: 12),
//                     AnimatedContainer(
//                       duration: Duration(milliseconds: 300),
//                       child: Icon(
//                         isCompleted
//                             ? Icons.check_circle
//                             : Icons.radio_button_unchecked,
//                         color: isCompleted ? Colors.green : Colors.white54,
//                         size: 32,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 16),
//
//                 // Exercise details row
//                 Row(
//                   children: [
//                     _buildDetailChip(
//                       Icons.access_time,
//                       details['duration'],
//                       Colors.blue,
//                     ),
//                     SizedBox(width: 8),
//                     _buildDetailChip(
//                       Icons.repeat,
//                       details['times'],
//                       Colors.purple,
//                     ),
//                     SizedBox(width: 8),
//                     _buildDetailChip(
//                       Icons.local_fire_department,
//                       '${details['calories']} cal',
//                       Colors.orange,
//                     ),
//                   ],
//                 ),
//
//                 SizedBox(height: 12),
//
//                 // Target muscles
//                 Wrap(
//                   spacing: 6,
//                   runSpacing: 6,
//                   children: (details['targetMuscles'] as List<String>)
//                       .map((muscle) => Container(
//                     padding: EdgeInsets.symmetric(
//                         horizontal: 8, vertical: 4),
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.15),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Text(
//                       muscle,
//                       style: TextStyle(
//                         fontSize: 11,
//                         color: Colors.white70,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ))
//                       .toList(),
//                 ),
//
//                 if (!isCompleted) ...[
//                   SizedBox(height: 12),
//                   Container(
//                     padding: EdgeInsets.all(12),
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.05),
//                       borderRadius: BorderRadius.circular(12),
//                       border: Border.all(
//                         color: Colors.white.withOpacity(0.1),
//                       ),
//                     ),
//                     child: Row(
//                       children: [
//                         Icon(
//                           Icons.lightbulb_outline,
//                           color: Colors.amber,
//                           size: 16,
//                         ),
//                         SizedBox(width: 8),
//                         Expanded(
//                           child: Text(
//                             details['tips'],
//                             style: TextStyle(
//                               fontSize: 13,
//                               color: Colors.white60,
//                               fontStyle: FontStyle.italic,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildDetailChip(IconData icon, String text, Color accentColor) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//       decoration: BoxDecoration(
//         color: accentColor.withOpacity(0.15),
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(
//           color: accentColor.withOpacity(0.3),
//         ),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(icon, size: 16, color: accentColor),
//           SizedBox(width: 6),
//           Text(
//             text,
//             style: TextStyle(
//               fontSize: 13,
//               color: Colors.white,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math' as math;
import 'dart:async';

import 'YoutubePlayerPage.dart';

class WorkoutSessionPage extends StatefulWidget {
  final Map<String, dynamic> trainer;

  const WorkoutSessionPage({Key? key, required this.trainer}) : super(key: key);

  @override
  _WorkoutSessionPageState createState() => _WorkoutSessionPageState();
}

class _WorkoutSessionPageState extends State<WorkoutSessionPage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _pulseController;
  late AnimationController _progressAnimationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _progressAnimation;

  Set<int> completedExercises = {};
  Map<String, dynamic> trainerExercises = {};
  int totalCaloriesBurned = 0;
  DateTime? sessionStartTime;
  Timer? _sessionTimer;
  int sessionDurationSeconds = 0;
  bool isSessionActive = true;
  bool showMotivationalMessage = false;
  String currentMotivationalMessage = '';
  bool isLoading = true;
  double _previousCompletionPercentage = 0.0;

  // Enhanced motivational messages with categories
  final Map<String, List<String>> motivationalMessages = {
    'start': [
      "Let's crush this workout! 💪",
      "Time to unlock your potential!",
      "Every champion starts here!",
    ],
    'progress': [
      "You're on fire! Keep going! 🔥",
      "Halfway there, don't stop now!",
      "Your dedication is showing!",
      "Progress over perfection!",
    ],
    'completion': [
      "Exercise complete! You're amazing! ⭐",
      "Another step closer to your goals!",
      "That's the spirit! Keep pushing!",
      "You're stronger than you think!",
    ],
    'finish': [
      "Workout completed! You're a champion! 🏆",
      "Outstanding performance today!",
      "You've earned every bit of progress!",
    ],
  };

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _fetchTrainerExercises();
    _startSession();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _pulseController.dispose();
    _progressAnimationController.dispose();
    _sessionTimer?.cancel();
    super.dispose();
  }

  Future<void> _fetchTrainerExercises() async {
    try {
      DocumentSnapshot trainerDoc = await FirebaseFirestore.instance
          .collection('trainers')
          .doc(widget.trainer['trainerId'])
          .get();

      if (trainerDoc.exists) {
        Map<String, dynamic> trainerData = trainerDoc.data() as Map<
            String,
            dynamic>;

        setState(() {
          trainerExercises = trainerData['exercises'] ?? {};
          isLoading = false;
        });

        // Show welcome message
        _showMotivationalMessage(category: 'start');
      }
    } catch (e) {
      debugPrint('Error fetching trainer exercises: $e');
      setState(() {
        isLoading = false;
      });
      _showErrorDialog('Failed to load exercises. Please try again.');
    }
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )
      ..repeat(reverse: true);

    _progressAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _progressAnimationController, curve: Curves.easeOutCubic),
    );

    _animationController.forward();
  }

  void _startSession() {
    sessionStartTime = DateTime.now();
    _sessionTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted && isSessionActive) {
        setState(() {
          sessionDurationSeconds++;
        });
      }
    });
  }

  void _pauseSession() {
    HapticFeedback.mediumImpact();
    setState(() {
      isSessionActive = false;
    });
    _showSnackBar('Session paused', Icons.pause, Colors.orange);
  }

  void _resumeSession() {
    HapticFeedback.mediumImpact();
    setState(() {
      isSessionActive = true;
    });
    _showSnackBar('Session resumed', Icons.play_arrow, Colors.green);
  }

  void _showEndSessionDialog() {
    if (!mounted) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16)),
          title: const Row(
            children: [
              Icon(Icons.warning, color: Colors.orange),
              SizedBox(width: 8),
              Text('End Session'),
            ],
          ),
          content: const Text(
              'Are you sure you want to end this workout session? Your progress will be saved.'),
          actions: [
            TextButton(
              onPressed: () {
                if (Navigator.canPop(context)) {
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {
                if (Navigator.canPop(context)) {
                  Navigator.of(context).pop();
                }
                _finishSession();
              },
              child: const Text('End Session'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _finishSession() async {
    _sessionTimer?.cancel();

    try {
      await _saveProgressToFirebase();

      // Show completion message based on progress
      final exercises = trainerExercises.keys.toList();
      final completionPercentage = exercises.isEmpty ? 0 : (completedExercises
          .length / exercises.length);

      if (completionPercentage >= 1.0) {
        _showMotivationalMessage(category: 'finish');
      }

      // Delay navigation to show completion message
      await Future.delayed(const Duration(seconds: 2));

      if (mounted && Navigator.canPop(context)) {
        Navigator.of(context).pop();
      }
    } catch (error) {
      debugPrint('Error finishing session: $error');
      _showErrorDialog('Failed to save session. Please try again.');
    }
  }

  void _showMotivationalMessage({String category = 'completion'}) {
    final messages = motivationalMessages[category] ??
        motivationalMessages['completion']!;
    final randomMessage = messages[math.Random().nextInt(messages.length)];

    if (mounted) {
      setState(() {
        currentMotivationalMessage = randomMessage;
        showMotivationalMessage = true;
      });

      HapticFeedback.lightImpact();

      Timer(const Duration(seconds: 3), () {
        if (mounted) {
          setState(() {
            showMotivationalMessage = false;
          });
        }
      });
    }
  }

  void _showSnackBar(String message, IconData icon, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 8),
            Text(message),
          ],
        ),
        backgroundColor: color,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: const Row(
              children: [
                Icon(Icons.error, color: Colors.red),
                SizedBox(width: 8),
                Text('Error'),
              ],
            ),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  Color getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'easy':
        return Colors.green;
      case 'medium':
        return Colors.orange;
      case 'hard':
        return Colors.red;
      default:
        return Colors.orange;
    }
  }

  IconData getDifficultyIcon(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'easy':
        return Icons.sentiment_satisfied;
      case 'medium':
        return Icons.sentiment_neutral;
      case 'hard':
        return Icons.sentiment_very_dissatisfied;
      default:
        return Icons.sentiment_neutral;
    }
  }

  void toggleExerciseCompletion(int index, int calories) {
    HapticFeedback.selectionClick();

    setState(() {
      if (completedExercises.contains(index)) {
        completedExercises.remove(index);
        totalCaloriesBurned = math.max(0, totalCaloriesBurned - calories);
      } else {
        completedExercises.add(index);
        totalCaloriesBurned += calories;

        // Animate progress change
        final exercises = trainerExercises.keys.toList();
        final newPercentage = exercises.isEmpty ? 0.0 : (completedExercises
            .length / exercises.length);

        _progressAnimationController.reset();
        _progressAnimationController.forward();

        // Show appropriate motivational message
        if (newPercentage >= 1.0) {
          _showMotivationalMessage(category: 'finish');
        } else if (newPercentage >= 0.5) {
          _showMotivationalMessage(category: 'progress');
        } else {
          _showMotivationalMessage(category: 'completion');
        }

        _previousCompletionPercentage = newPercentage;
      }
    });
  }

  Future<void> _saveProgressToFirebase() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception('User not authenticated');
      }

      final sessionId = DateTime
          .now()
          .millisecondsSinceEpoch
          .toString();
      final exercises = trainerExercises.keys.toList();

      Map<String, dynamic> detailedExerciseProgress = {};

      for (int i = 0; i < exercises.length; i++) {
        final exerciseName = exercises[i];
        final exerciseData = trainerExercises[exerciseName];

        detailedExerciseProgress[exerciseName] = {
          'isCompleted': completedExercises.contains(i),
          'calories': exerciseData['calories'] ?? 0,
          'difficulty': exerciseData['difficulty'] ?? 'medium',
          'completedAt': completedExercises.contains(i) ? DateTime.now() : null,
        };
      }

      final completionPercentage = exercises.isEmpty ? 0 : (completedExercises
          .length / exercises.length * 100).round();

      // Save session data
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('workout_sessions')
          .doc(sessionId)
          .set({
        'sessionId': sessionId,
        'trainerId': widget.trainer['trainerId'],
        'trainerName': widget.trainer['trainerName'],
        'gymName': widget.trainer['gymName'],
        'sessionDate': DateTime.now(),
        'sessionStartTime': sessionStartTime,
        'sessionEndTime': DateTime.now(),
        'sessionDuration': sessionDurationSeconds,
        'totalExercises': trainerExercises.length,
        'completedExercises': completedExercises.length,
        'completionPercentage': completionPercentage,
        'detailedExerciseProgress': detailedExerciseProgress,
        'totalCaloriesBurned': totalCaloriesBurned,
        'isCompleted': completedExercises.length == trainerExercises.length,
        'sessionType': 'workout',
        'platform': 'mobile',
        'version': '2.0', // Version tracking
      });

      // Update user statistics with better error handling
      await _updateUserStatistics(user.uid);
      await _updateMonthlyStatistics(user.uid);
    } catch (e) {
      debugPrint('Error saving progress to Firebase: $e');
      rethrow;
    }
  }

  Future<void> _updateUserStatistics(String userId) async {
    DocumentReference userStatsRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('statistics')
        .doc('overall');

    await userStatsRef.set({
      'totalSessions': FieldValue.increment(1),
      'totalCaloriesBurned': FieldValue.increment(totalCaloriesBurned),
      'totalWorkoutTime': FieldValue.increment(sessionDurationSeconds),
      'totalExercisesCompleted': FieldValue.increment(
          completedExercises.length),
      'lastWorkoutDate': DateTime.now(),
      'favoriteTrainers': {
        widget.trainer['trainerId']: FieldValue.increment(1),
      },
      'lastUpdated': DateTime.now(),
    }, SetOptions(merge: true));
  }

  Future<void> _updateMonthlyStatistics(String userId) async {
    final monthKey = DateFormat('yyyy-MM').format(DateTime.now());
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('monthly_stats')
        .doc(monthKey)
        .set({
      'month': monthKey,
      'sessionsThisMonth': FieldValue.increment(1),
      'caloriesThisMonth': FieldValue.increment(totalCaloriesBurned),
      'workoutTimeThisMonth': FieldValue.increment(sessionDurationSeconds),
      'exercisesCompletedThisMonth': FieldValue.increment(
          completedExercises.length),
      'lastUpdated': DateTime.now(),
    }, SetOptions(merge: true));
  }

  Widget _buildStatItem(String label, String value, IconData icon,
      {Color? color}) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color ?? Colors.white, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  void _showSessionOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Wrap(
            children: [
              Container(
                width: 40,
                height: 4,
                margin: EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: MediaQuery
                        .of(context)
                        .size
                        .width / 2 - 20),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Session Options',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              _buildBottomSheetOption(
                icon: isSessionActive ? Icons.pause : Icons.play_arrow,
                title: isSessionActive ? 'Pause Session' : 'Resume Session',
                color: isSessionActive ? Colors.orange : Colors.green,
                onTap: () {
                  Navigator.pop(context);
                  if (isSessionActive) {
                    _pauseSession();
                  } else {
                    _resumeSession();
                  }
                },
              ),
              _buildBottomSheetOption(
                icon: Icons.refresh,
                title: 'Restart Session',
                color: Colors.blue,
                onTap: () {
                  Navigator.pop(context);
                  _showRestartConfirmation();
                },
              ),
              _buildBottomSheetOption(
                icon: Icons.bar_chart,
                title: 'View Progress',
                color: Colors.purple,
                onTap: () {
                  Navigator.pop(context);
                  _showProgressSummary();
                },
              ),
              _buildBottomSheetOption(
                icon: Icons.stop,
                title: 'End Session',
                color: Colors.red,
                onTap: () {
                  Navigator.pop(context);
                  _showEndSessionDialog();
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBottomSheetOption({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: color),
      ),
      title: Text(title),
      onTap: onTap,
    );
  }

  Widget _buildExerciseCard(int index, String exerciseName,
      Map<String, dynamic> exerciseData, bool isCompleted) {
    final difficulty = exerciseData['difficulty'] ?? 'medium';
    final calories = exerciseData['calories'] ?? 0;
    final duration = exerciseData['duration'] ?? 'N/A';
    final description = exerciseData['description'] ?? '';
    final videoUrl = exerciseData['videoUrl'] ?? '';

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: isCompleted ? Colors.green.shade50 : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isCompleted ? Colors.green.shade200 : Colors.grey.shade200,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: videoUrl.isNotEmpty ? () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => YouTubePlayerPage(youtubeUrl: videoUrl),
                ),
              );
            } : null,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => toggleExerciseCompletion(index, calories),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            color: isCompleted ? Colors.green : Colors
                                .transparent,
                            border: Border.all(
                              color: isCompleted ? Colors.green : Colors.grey,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: isCompleted
                              ? const Icon(
                              Icons.check, color: Colors.white, size: 18)
                              : null,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    exerciseName,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.deepPurple.shade700,
                                      decoration: isCompleted ? TextDecoration
                                          .lineThrough : null,
                                    ),
                                  ),
                                ),
                                if (videoUrl.isNotEmpty)
                                  Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: Colors.red.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: const Icon(
                                      Icons.play_circle_filled,
                                      color: Colors.red,
                                      size: 20,
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 8,
                              runSpacing: 4,
                              children: [
                                _buildExerciseChip(
                                  difficulty.toUpperCase(),
                                  getDifficultyIcon(difficulty),
                                  getDifficultyColor(difficulty),
                                ),
                                _buildExerciseChip(
                                  '$calories cal',
                                  Icons.local_fire_department,
                                  Colors.orange,
                                ),
                                if (duration != 'N/A')
                                  _buildExerciseChip(
                                    duration,
                                    Icons.timer,
                                    Colors.blue,
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (description.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        description,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildExerciseChip(String text, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  void _showRestartConfirmation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16)),
          title: const Row(
            children: [
              Icon(Icons.refresh, color: Colors.orange),
              SizedBox(width: 8),
              Text('Restart Session'),
            ],
          ),
          content: const Text(
              'Are you sure you want to restart this workout session? All progress will be reset.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _restartSession();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
              ),
              child: const Text('Restart'),
            ),
          ],
        );
      },
    );
  }

  void _restartSession() {
    HapticFeedback.mediumImpact();
    setState(() {
      completedExercises.clear();
      totalCaloriesBurned = 0;
      sessionDurationSeconds = 0;
      sessionStartTime = DateTime.now();
      _previousCompletionPercentage = 0.0;
    });
    _showSnackBar('Session restarted', Icons.refresh, Colors.orange);
  }

  void _showProgressSummary() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final exercises = trainerExercises.keys.toList();
        final completionPercentage = exercises.isEmpty
            ? 0.0
            : (completedExercises.length / exercises.length);

        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16)),
          title: const Row(
            children: [
              Icon(Icons.bar_chart, color: Colors.purple),
              SizedBox(width: 8),
              Text('Progress Summary'),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProgressStat('Session Duration', getSessionDuration()),
                _buildProgressStat(
                    'Completion', '${(completionPercentage * 100).toInt()}%'),
                _buildProgressStat('Exercises Completed',
                    '${completedExercises.length}/${exercises.length}'),
                _buildProgressStat(
                    'Calories Burned', '$totalCaloriesBurned cal'),
                const SizedBox(height: 16),
                const Text('Exercise Details:',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                ...exercises
                    .asMap()
                    .entries
                    .map((entry) {
                  final index = entry.key;
                  final exerciseName = entry.value;
                  final isCompleted = completedExercises.contains(index);

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        Icon(
                          isCompleted ? Icons.check_circle : Icons
                              .radio_button_unchecked,
                          color: isCompleted ? Colors.green : Colors.grey,
                          size: 16,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            exerciseName,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildProgressStat(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(
            value,
            style: const TextStyle(
              color: Colors.deepPurple,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  String getSessionDuration() {
    final minutes = sessionDurationSeconds ~/ 60;
    final seconds = sessionDurationSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(
        2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.deepPurple.shade300,
                Colors.deepPurple.shade600,
                Colors.deepPurple.shade900
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(color: Colors.white),
                SizedBox(height: 16),
                Text(
                  'Loading workout...',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final exercises = trainerExercises.keys.toList();
    final completionPercentage = exercises.isEmpty ? 0.0 : (completedExercises.length / exercises.length);

    return Scaffold(
      body: Stack(
        children: [
      Container(
      decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
        Colors.deepPurple.shade300,
        Colors.deepPurple.shade600,
        Colors.deepPurple.shade900
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    child: SafeArea(
    child: Column(
    children: [
    // Header Section
    Padding(
    padding: const EdgeInsets.all(16),
    child: FadeTransition(
    opacity: _fadeAnimation,
    child: Column(
    children: [
    // Top Action Bar
    Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    IconButton(
    onPressed: _showEndSessionDialog,
    icon: const Icon(Icons.close, color: Colors.white, size: 28),
    splashRadius: 24,
    ),
    Text(
    'Workout Session',
    style: TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontWeight: FontWeight.bold,
    ),
    ),
    IconButton(
    onPressed: _showSessionOptions,
    icon: const Icon(Icons.more_vert, color: Colors.white, size: 28),
    splashRadius: 24,
    ),
    ],
    ),
    const SizedBox(height: 20),

    // Trainer Info Card
    Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
    color: Colors.white.withOpacity(0.1),
    borderRadius: BorderRadius.circular(16),
    border: Border.all(color: Colors.white.withOpacity(0.2)),
    ),
    child: Column(
    children: [
    Text(
    widget.trainer['trainerName'] ?? 'Unknown Trainer',
    style: const TextStyle(
    color: Colors.white,
    fontSize: 18,
    fontWeight: FontWeight.bold,
    ),
    ),
    const SizedBox(height: 4),
    Text(
    widget.trainer['gymName'] ?? 'Gym',
    style: const TextStyle(
    color: Colors.white70,
    fontSize: 14,
    ),
    ),
    ],
    ),
    ),
    const SizedBox(height: 20),

    // Progress Bar
    Column(
    children: [
    Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    const Text(
    'Progress',
    style: TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    ),
    ),
    Text(
    '${completedExercises.length}/${exercises.length}',
    style: const TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.bold,
    ),
    ),
    ],
    ),
    const SizedBox(height: 8),
    AnimatedBuilder(
    animation: _progressAnimation,
    builder: (context, child) {
    return LinearProgressIndicator(
    value: completionPercentage * _progressAnimation.value,
    backgroundColor: Colors.white.withOpacity(0.3),
    valueColor: AlwaysStoppedAnimation<Color>(
    completionPercentage >= 1.0
    ? Colors.green
        : Colors.white,
    ),
    minHeight: 8,
    );
    },
    ),
    const SizedBox(height: 4),
    Text(
    '${(completionPercentage * 100).toInt()}% Complete',
    style: const TextStyle(
    color: Colors.white70,
    fontSize: 12,
    ),
    ),
    ],
    ),
    const SizedBox(height: 20),

    // Stats Row
    Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
    _buildStatItem(
    'Duration',
    getSessionDuration(),
    Icons.timer,
    color: isSessionActive ? Colors.green : Colors.orange,
    ),
    _buildStatItem(
    'Calories',
    '$totalCaloriesBurned',
    Icons.local_fire_department,
    color: Colors.orange,
    ),
    _buildStatItem(
    'Exercises',
    '${completedExercises.length}',
    Icons.fitness_center,
    color: Colors.blue,
    ),
    ],
    ),
    ],
    ),
    ),
    ),

    // Exercise List
    Expanded(
    child: Container(
    decoration: const BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only(
    topLeft: Radius.circular(24),
    topRight: Radius.circular(24),
    ),
    ),
    child: Column(
    children: [
    // Handle bar
    Container(
    width: 40,
    height: 4,
    margin: const EdgeInsets.symmetric(vertical: 12),
    decoration: BoxDecoration(
    color: Colors.grey[300],
    borderRadius: BorderRadius.circular(2),
    ),
    ),

    // Exercise List Header
    Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Text(
    'Exercises (${exercises.length})',
    style: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.deepPurple.shade700,
    ),
    ),
    if (exercises.isNotEmpty)
    Text(
    '${(completionPercentage * 100).toInt()}%',
    style: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: completionPercentage >= 1.0
    ? Colors.green
        : Colors.deepPurple.shade400,
    ),
    ),
    ],
    ),
    ),
    const SizedBox(height: 16),

    // Exercise Cards
    if (exercises.isEmpty)
    Expanded(
    child: Center(
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    Icon(
    Icons.fitness_center,
    size: 64,
    color: Colors.grey[400],
    ),
    const SizedBox(height: 16),
    Text(
    'No exercises found',
    style: TextStyle(
    fontSize: 16,
    color: Colors.grey[600],
    fontWeight: FontWeight.w500,
    ),
    ),
    const SizedBox(height: 8),
    Text(
    'Please check with your trainer',
    style: TextStyle(
    fontSize: 14,
    color: Colors.grey[500],
    ),
    ),
    ],
    ),
    ),
    )
    else
    Expanded(
    child: ListView.builder(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    itemCount: exercises.length,
    itemBuilder: (context, index) {
    final exerciseName = exercises[index];
    final exerciseData = trainerExercises[exerciseName];
    final isCompleted = completedExercises.contains(index);

    return FadeTransition(
    opacity: _fadeAnimation,
    child: SlideTransition(
    position: Tween<Offset>(
    begin: Offset(0, 0.3),
    end: Offset.zero,
    ).animate(CurvedAnimation(
    parent: _animationController,
    curve: Interval(
    (index * 0.1).clamp(0.0, 1.0),
    ((index * 0.1) + 0.3).clamp(0.0, 1.0),
    curve: Curves.easeOut,
    ),
    )),
    child: _buildExerciseCard(
    index,
    exerciseName,
    exerciseData,
    isCompleted,
    ),
    ),
    );
    },
    ),
    ),
    ],
    ),
    ),
    ),
    ],
    ),
    ),
    ),

    // Motivational Message Overlay
    floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    body: Stack(
    children: [
    // Main content here (move the existing body content into this Stack)

    // Motivational Message Overlay
    if (showMotivationalMessage)
    Positioned.fill(
    child: Container(
    color: Colors.black.withOpacity(0.5),
    child: Center(
    child: ScaleTransition(
    scale: _pulseAnimation,
    child: Container(
    margin: const EdgeInsets.symmetric(horizontal: 32),
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
    BoxShadow(
    color: Colors.black.withOpacity(0.2),
    blurRadius: 20,
    offset: const Offset(0, 8),
    ),
    ],
    ),
    child: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
    Icon(
    Icons.star,
    color: Colors.amber,
    size: 48,
    ),
    const SizedBox(height: 16),
    Text(
    currentMotivationalMessage,
    textAlign: TextAlign.center,
    style: const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.deepPurple,
    ),
    ),
    ],
    ),
    ),
    ),
    ),
    ),
    ),
    ],
    ),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    floatingActionButton: completedExercises.length == exercises.length && exercises.isNotEmpty
    ? FloatingActionButton.extended(
    onPressed: _finishSession,
    backgroundColor: Colors.green,
    foregroundColor: Colors.white,
    icon: const Icon(Icons.check),
    label: const Text('Finish Workout'),
    )
    : null,
    )
    );

  };

    ),

    );
  }
}

