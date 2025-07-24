// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'dart:math' as math;
//
// class ViewTrainersPage extends StatelessWidget {
//   const ViewTrainersPage({super.key});
//
//   final List<Map<String, dynamic>> trainerDetails = const [
//     {
//       'trainerName': 'Fatima',
//       'gymName': 'FitLife Gym',
//       'exercise': 'Yoga, Cardio, HIIT',
//       'experience': '5 years',
//       'rating': 4.8,
//       'availability': 'Mon-Fri: 6AM-8PM',
//       'specialization': 'Weight Loss',
//       'image': 'assets/trainer1.jpg', // placeholder
//     },
//     {
//       'trainerName': 'Anousha',
//       'gymName': 'PowerHouse Gym',
//       'exercise': 'Weightlifting, CrossFit',
//       'experience': '7 years',
//       'rating': 4.9,
//       'availability': 'Mon-Sat: 5AM-9PM',
//       'specialization': 'Strength Building',
//       'image': 'assets/trainer2.jpg', // placeholder
//     },
//     {
//       'trainerName': 'Aima',
//       'gymName': 'FlexZone Gym',
//       'exercise': 'Strength Training, Pilates',
//       'experience': '4 years',
//       'rating': 4.7,
//       'availability': 'Tue-Sun: 7AM-6PM',
//       'specialization': 'Flexibility & Core',
//       'image': 'assets/trainer3.jpg', // placeholder
//     },
//     {
//       'trainerName': 'Maria',
//       'gymName': 'GymX',
//       'exercise': 'Cycling, Aerobics',
//       'experience': '6 years',
//       'rating': 4.6,
//       'availability': 'Mon-Fri: 8AM-7PM',
//       'specialization': 'Cardio Fitness',
//       'image': 'assets/trainer4.jpg', // placeholder
//     },
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('View Trainers'),
//         backgroundColor: Colors.deepPurple,
//         foregroundColor: Colors.white,
//         elevation: 0,
//       ),
//       backgroundColor: Colors.grey[50],
//       body: Column(
//         children: [
//           // Header with trainer count
//           Container(
//             width: double.infinity,
//             padding: const EdgeInsets.all(16),
//             margin: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: Colors.deepPurple.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(12),
//               border: Border.all(color: Colors.deepPurple.withOpacity(0.2)),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Icon(
//                   Icons.fitness_center,
//                   color: Colors.deepPurple,
//                   size: 24,
//                 ),
//                 const SizedBox(width: 8),
//                 Text(
//                   'Available Trainers: ${trainerDetails.length}',
//                   style: const TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.deepPurple,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           // Trainers list
//           Expanded(
//             child: ListView.builder(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               itemCount: trainerDetails.length,
//               itemBuilder: (context, index) {
//                 final trainer = trainerDetails[index];
//                 return _buildTrainerCard(context, trainer, index);
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildTrainerCard(BuildContext context, Map<String, dynamic> trainer, int index) {
//     final colors = [
//       Colors.deepPurple,
//       Colors.indigo,
//       Colors.teal,
//       Colors.deepOrange,
//     ];
//     final cardColor = colors[index % colors.length];
//
//     return Card(
//       margin: const EdgeInsets.only(bottom: 16),
//       elevation: 4,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(16),
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               cardColor.withOpacity(0.05),
//               cardColor.withOpacity(0.02),
//             ],
//           ),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Header with avatar and basic info
//               Row(
//                 children: [
//                   CircleAvatar(
//                     radius: 30,
//                     backgroundColor: cardColor,
//                     child: Text(
//                       trainer['trainerName']?.toString().substring(0, 1).toUpperCase() ?? 'T',
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           trainer['trainerName'] ?? 'Unknown Trainer',
//                           style: const TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black87,
//                           ),
//                         ),
//                         const SizedBox(height: 4),
//                         Row(
//                           children: [
//                             Icon(
//                               Icons.location_on,
//                               size: 16,
//                               color: Colors.grey[600],
//                             ),
//                             const SizedBox(width: 4),
//                             Expanded(
//                               child: Text(
//                                 trainer['gymName'] ?? 'Unknown Gym',
//                                 style: TextStyle(
//                                   fontSize: 14,
//                                   color: Colors.grey[600],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 4),
//                         _buildRatingRow(trainer['rating']?.toDouble() ?? 0.0),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//
//               // Details section
//               _buildDetailRow(
//                 Icons.fitness_center,
//                 'Specialization',
//                 trainer['specialization'] ?? 'General Fitness',
//                 cardColor,
//               ),
//               const SizedBox(height: 12),
//               _buildDetailRow(
//                 Icons.sports_gymnastics,
//                 'Exercises',
//                 trainer['exercise'] ?? 'Various',
//                 cardColor,
//               ),
//               const SizedBox(height: 12),
//               _buildDetailRow(
//                 Icons.work_history,
//                 'Experience',
//                 trainer['experience'] ?? 'N/A',
//                 cardColor,
//               ),
//               const SizedBox(height: 12),
//               _buildDetailRow(
//                 Icons.schedule,
//                 'Availability',
//                 trainer['availability'] ?? 'Contact for schedule',
//                 cardColor,
//               ),
//               const SizedBox(height: 20),
//
//               // Action buttons
//               Row(
//                 children: [
//                   Expanded(
//                     child: ElevatedButton.icon(
//                       onPressed: () {
//                         _showTrainerDetails(context, trainer);
//                       },
//                       icon: const Icon(Icons.info_outline, size: 18),
//                       label: const Text('View Details'),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: cardColor,
//                         foregroundColor: Colors.white,
//                         padding: const EdgeInsets.symmetric(vertical: 12),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: OutlinedButton.icon(
//                       onPressed: () {
//                         _contactTrainer(context, trainer);
//                       },
//                       icon: const Icon(Icons.message, size: 18),
//                       label: const Text('Contact'),
//                       style: OutlinedButton.styleFrom(
//                         foregroundColor: cardColor,
//                         side: BorderSide(color: cardColor),
//                         padding: const EdgeInsets.symmetric(vertical: 12),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildRatingRow(double rating) {
//     return Row(
//       children: [
//         ...List.generate(5, (index) {
//           return Icon(
//             index < rating.floor() ? Icons.star :
//             (index < rating ? Icons.star_half : Icons.star_border),
//             color: Colors.amber,
//             size: 16,
//           );
//         }),
//         const SizedBox(width: 4),
//         Text(
//           rating.toStringAsFixed(1),
//           style: const TextStyle(
//             fontSize: 12,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildDetailRow(IconData icon, String label, String value, Color color) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Icon(
//           icon,
//           size: 20,
//           color: color,
//         ),
//         const SizedBox(width: 12),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 label,
//                 style: TextStyle(
//                   fontSize: 12,
//                   fontWeight: FontWeight.w500,
//                   color: Colors.grey[600],
//                 ),
//               ),
//               const SizedBox(height: 2),
//               Text(
//                 value,
//                 style: const TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w500,
//                   color: Colors.black87,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   void _showTrainerDetails(BuildContext context, Map<String, dynamic> trainer) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//           title: Row(
//             children: [
//               CircleAvatar(
//                 backgroundColor: Colors.deepPurple,
//                 child: Text(
//                   trainer['trainerName']?.toString().substring(0, 1).toUpperCase() ?? 'T',
//                   style: const TextStyle(color: Colors.white),
//                 ),
//               ),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: Text(
//                   trainer['trainerName'] ?? 'Trainer Details',
//                   style: const TextStyle(fontSize: 18),
//                 ),
//               ),
//             ],
//           ),
//           content: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 _buildDialogDetailRow('Gym', trainer['gymName'] ?? 'N/A'),
//                 _buildDialogDetailRow('Specialization', trainer['specialization'] ?? 'N/A'),
//                 _buildDialogDetailRow('Exercises', trainer['exercise'] ?? 'N/A'),
//                 _buildDialogDetailRow('Experience', trainer['experience'] ?? 'N/A'),
//                 _buildDialogDetailRow('Availability', trainer['availability'] ?? 'N/A'),
//                 const SizedBox(height: 8),
//                 Row(
//                   children: [
//                     const Text('Rating: ', style: TextStyle(fontWeight: FontWeight.w500)),
//                     _buildRatingRow(trainer['rating']?.toDouble() ?? 0.0),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: const Text('Close'),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   Widget _buildDialogDetailRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(
//             width: 80,
//             child: Text(
//               '$label:',
//               style: const TextStyle(
//                 fontWeight: FontWeight.w500,
//                 color: Colors.deepPurple,
//               ),
//             ),
//           ),
//           Expanded(
//             child: Text(value),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _contactTrainer(BuildContext context, Map<String, dynamic> trainer) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('Contacting ${trainer['trainerName']}...'),
//         backgroundColor: Colors.deepPurple,
//         behavior: SnackBarBehavior.floating,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewTrainersPage extends StatelessWidget {
  const ViewTrainersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1a1a2e),  // Dark navy
              Color(0xFF16213e),  // Darker blue
              Color(0xFF0f3460),  // Deep blue
              Color(0xFF533483),  // Purple accent
            ],
            stops: [0.0, 0.3, 0.7, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Custom App Bar
              Container(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back_ios_rounded,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF43e97b),  // Green
                            Color(0xFF38f9d7),  // Cyan
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF43e97b).withOpacity(0.4),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.fitness_center_rounded,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 15),
                    const Text(
                      'All Trainers',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              // Main Content
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF2A2A3E),  // Darker purple-gray
                        Color(0xFF1E1E2E),  // Dark blue-gray
                      ],
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, -5),
                      ),
                    ],
                  ),
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('trainers')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF43e97b)),
                          ),
                        );
                      }

                      if (snapshot.hasError) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.error_outline,
                                size: 64,
                                color: Colors.red[400],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Error loading trainers',
                                style: TextStyle(
                                  color: Colors.red[400],
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.fitness_center_outlined,
                                size: 64,
                                color: Colors.grey[400],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'No trainers found',
                                style: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Add some trainers from the admin dashboard',
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      }

                      return Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${snapshot.data!.docs.length} Trainer${snapshot.data!.docs.length == 1 ? '' : 's'} Available',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[300],
                              ),
                            ),
                            const SizedBox(height: 20),
                            Expanded(
                              child: ListView.builder(
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  final trainer = snapshot.data!.docs[index];
                                  final trainerData = trainer.data() as Map<String, dynamic>;

                                  return _buildTrainerCard(
                                    context,
                                    trainer.id,
                                    trainerData['name'] ?? 'Unknown Trainer',
                                    trainerData['gymName'] ?? 'Unknown Gym',
                                    trainerData['exercise'] ?? 'No exercises listed',
                                    index,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTrainerCard(
      BuildContext context,
      String trainerId,
      String name,
      String gymName,
      String exercises,
      int index,
      ) {
    // Different gradient colors for variety
    final List<List<Color>> gradients = [
      [Color(0xFF4facfe), Color(0xFF00f2fe)], // Blue to Cyan
      [Color(0xFF43e97b), Color(0xFF38f9d7)], // Green to Cyan
      [Color(0xFFfa709a), Color(0xFFfee140)], // Pink to Yellow
      [Color(0xFFf093fb), Color(0xFFf5576c)], // Purple to Pink
      [Color(0xFFd299c2), Color(0xFFfef9d7)], // Light Purple to Cream
      [Color(0xFF667eea), Color(0xFF764ba2)], // Blue to Purple
    ];

    final gradient = gradients[index % gradients.length];

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            gradient[0].withOpacity(0.8),
            gradient[1].withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: gradient[0].withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [
              Colors.white.withOpacity(0.1),
              Colors.white.withOpacity(0.05),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Trainer Avatar
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                      width: 2,
                    ),
                  ),
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.white.withOpacity(0.8),
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              gymName,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // View Details Button
                IconButton(
                  onPressed: () => _showTrainerDetails(context, trainerId, name, gymName, exercises),
                  icon: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Exercise Specializations
            Row(
              children: [
                Icon(
                  Icons.fitness_center,
                  color: Colors.white.withOpacity(0.8),
                  size: 18,
                ),
                const SizedBox(width: 8),
                const Text(
                  'Specializations:',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              exercises,
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: 14,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showTrainerDetails(BuildContext context, String trainerId, String name, String gymName, String exercises) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF2A2A3E),
              Color(0xFF1E1E2E),
            ],
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle bar
              Center(
                child: Container(
                  width: 50,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Trainer Info
              Row(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF43e97b), Color(0xFF38f9d7)],
                      ),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          gymName,
                          style: TextStyle(
                            color: Colors.grey[300],
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Specializations
              Text(
                'Specializations',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                exercises,
                style: TextStyle(
                  color: Colors.grey[300],
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 32),

              // Exercise Videos Section
              Text(
                'Exercise Videos',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('trainers')
                      .doc(trainerId)
                      .collection('exercises')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF43e97b)),
                        ),
                      );
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Center(
                        child: Text(
                          'No exercise videos available',
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 16,
                          ),
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final exercise = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.2),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [Color(0xFF4facfe), Color(0xFF00f2fe)],
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(
                                  Icons.play_arrow,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      exercise['title'] ?? 'Untitled Video',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      exercise['videoUrl'] ?? 'No URL',
                                      style: TextStyle(
                                        color: Colors.grey[400],
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
