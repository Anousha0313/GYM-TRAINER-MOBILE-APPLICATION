// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:newproject/EditTrainersListPage.dart';
// import 'package:newproject/TrainerPage.dart';
// import 'package:newproject/ViewUsersPage.dart';
// import 'package:newproject/ViewTrainersPage.dart';
//
// class AdminDashboardPage extends StatelessWidget {
//   const AdminDashboardPage({super.key});
//
//   // 🔹 This function uploads hardcoded trainers to Firestore
//   void uploadTrainersToFirestore(BuildContext context) async {
//     final trainers = [
//     {
//       'trainerName': 'Fatima',
//     'gymName': 'FitLife Gym',
//     'exercise': 'Yoga, Cardio, HIIT',
//     'videos': [
//   {'title': 'Morning Yoga', 'videoUrl': 'Yoga.mp4'},
//   {'title': 'HIIT Basics', 'videoUrl': 'HIIT.mp4'},
//     ],
//   },
//     {
//     'trainerName': 'Anousha',
//     'gymName': 'PowerHouse Gym',
//     'exercise': 'Weightlifting, CrossFit',
//     'videos': [
//     {'title': 'CrossFit Intro', 'videoUrl': 'Crossfit.mp4'},
//     ],
//     },
//     {
//     'trainerName': 'Aima',
//     'gymName': 'FlexZone Gym',
//     'exercise': 'Strength Training, Pilates',
//     'videos': [
//     {'title': 'Pilates Beginner', 'videoUrl': 'Pilates.mp4'},
//     ],
//     },
//     {
//     'trainerName': 'Maria',
//     'gymName': 'GymX',
//     'exercise': 'Cycling, Aerobics',
//     'videos': [
//     {'title': 'Indoor Cycling', 'videoUrl': 'Aerobics.mp4'},
//     ],}
//     ];
//
//     final trainerCollection = FirebaseFirestore.instance.collection('trainers');
//
//     for (var trainer in trainers) {
//       final trainerDoc = await trainerCollection.add({
//         'name': trainer['trainerName'],
//         'gymName': trainer['gymName'],
//         'exercise': trainer['exercise'],
//       });
//
//       final exercises = trainer['videos'] as List<Map<String, String>>;
//       for (var exercise in exercises) {
//         await trainerDoc.collection('exercises').add({
//           'title': exercise['title'],
//           'videoUrl': exercise['videoUrl'],
//         });
//
//
//       }
//     }
//
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Trainers and exercises uploaded successfully!')),
//     );
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Admin Dashboard'),
//         backgroundColor: Colors.deepPurple,
//         foregroundColor: Colors.white,
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               ElevatedButton.icon(
//                 onPressed: () {
//                   Navigator.push(context, MaterialPageRoute(builder: (_) => ViewUsersPage()));
//                 },
//                 icon: const Icon(Icons.people),
//                 label: const Text("View Users"),
//               ),
//               const SizedBox(height: 25),
//               ElevatedButton.icon(
//                 onPressed: () {
//                   Navigator.push(context, MaterialPageRoute(builder: (_) => ViewTrainersPage()));
//                 },
//                 icon: const Icon(Icons.fitness_center),
//                 label: const Text("View Trainers"),
//               ),
//               const SizedBox(height: 25),
//               ElevatedButton.icon(
//                 onPressed: () {
//                   Navigator.push(context, MaterialPageRoute(builder: (_) => EditTrainersListPage()));
//                 },
//                 icon: const Icon(Icons.edit),
//                 label: const Text("Edit Trainers"),
//               ),
//               const SizedBox(height: 25),
//               ElevatedButton.icon(
//                 onPressed: () {
//                   uploadTrainersToFirestore(context); // 🔹 Upload trainers to Firestore
//                 },
//                 icon: const Icon(Icons.cloud_upload),
//                 label: const Text("Upload Trainers to Firebase"),
//               ),
//               const SizedBox(height: 25),
//               ElevatedButton.icon(
//                 onPressed: () {
//                   Navigator.push(context, MaterialPageRoute(builder: (_) => TrainerPage()));
//                 },
//                 icon: const Icon(Icons.home),
//                 label: const Text("Go to Homepage"),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newproject/EditTrainersListPage.dart';
import 'package:newproject/TrainerPage.dart';
import 'package:newproject/ViewUsersPage.dart';
import 'package:newproject/ViewTrainersPage.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  // 🔹 This function uploads hardcoded trainers to Firestore
  void uploadTrainersToFirestore(BuildContext context) async {
    final trainers = [
      {
        'trainerName': 'Fatima',
        'gymName': 'FitLife Gym',
        'exercise': 'Yoga, Cardio, HIIT',
        'videos': [
          {'title': 'Morning Yoga', 'videoUrl': 'Yoga.mp4'},
          {'title': 'HIIT Basics', 'videoUrl': 'HIIT.mp4'},
        ],
      },
      {
        'trainerName': 'Anousha',
        'gymName': 'PowerHouse Gym',
        'exercise': 'Weightlifting, CrossFit',
        'videos': [
          {'title': 'CrossFit Intro', 'videoUrl': 'Crossfit.mp4'},
        ],
      },
      {
        'trainerName': 'Aima',
        'gymName': 'FlexZone Gym',
        'exercise': 'Strength Training, Pilates',
        'videos': [
          {'title': 'Pilates Beginner', 'videoUrl': 'Pilates.mp4'},
        ],
      },
      {
        'trainerName': 'Maria',
        'gymName': 'GymX',
        'exercise': 'Cycling, Aerobics',
        'videos': [
          {'title': 'Indoor Cycling', 'videoUrl': 'Aerobics.mp4'},
        ],}
    ];

    final trainerCollection = FirebaseFirestore.instance.collection('trainers');

    for (var trainer in trainers) {
      final trainerDoc = await trainerCollection.add({
        'name': trainer['trainerName'],
        'gymName': trainer['gymName'],
        'exercise': trainer['exercise'],
      });

      final exercises = trainer['videos'] as List<Map<String, String>>;
      for (var exercise in exercises) {
        await trainerDoc.collection('exercises').add({
          'title': exercise['title'],
          'videoUrl': exercise['videoUrl'],
        });
      }
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Trainers and exercises uploaded successfully!'),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  // 🔹 New function to show Add Trainer dialog
  void showAddTrainerDialog(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController gymController = TextEditingController();
    final TextEditingController exerciseController = TextEditingController();
    final TextEditingController videoTitleController = TextEditingController();
    final TextEditingController videoUrlController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF2A2A3E),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF667eea), Color(0xFF764ba2)],
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              'Add New Trainer',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTextField(nameController, 'Trainer Name', Icons.person),
                const SizedBox(height: 15),
                _buildTextField(gymController, 'Gym Name', Icons.fitness_center),
                const SizedBox(height: 15),
                _buildTextField(exerciseController, 'Exercise Types', Icons.sports_gymnastics),
                const SizedBox(height: 15),
                _buildTextField(videoTitleController, 'Video Title', Icons.video_library),
                const SizedBox(height: 15),
                _buildTextField(videoUrlController, 'Video URL', Icons.link),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isNotEmpty &&
                    gymController.text.isNotEmpty &&
                    exerciseController.text.isNotEmpty) {
                  addTrainerToFirestore(
                    context,
                    nameController.text,
                    gymController.text,
                    exerciseController.text,
                    videoTitleController.text,
                    videoUrlController.text,
                  );
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please fill in all required fields'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF667eea),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 5,
              ),
              child: const Text(
                'Add Trainer',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  // 🔹 Helper function to build text fields
  Widget _buildTextField(TextEditingController controller, String label, IconData icon) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.grey),
        prefixIcon: Icon(icon, color: Colors.grey),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFF4facfe)),
        ),
        filled: true,
        fillColor: const Color(0xFF3A3A4E),
      ),
    );
  }

  // 🔹 Function to add trainer to Firestore
  void addTrainerToFirestore(
      BuildContext context,
      String name,
      String gymName,
      String exercise,
      String videoTitle,
      String videoUrl,
      ) async {
    try {
      final trainerCollection = FirebaseFirestore.instance.collection('trainers');

      final trainerDoc = await trainerCollection.add({
        'name': name,
        'gymName': gymName,
        'exercise': exercise,
        'createdAt': Timestamp.now(),
      });

      // Add video if provided
      if (videoTitle.isNotEmpty && videoUrl.isNotEmpty) {
        await trainerDoc.collection('exercises').add({
          'title': videoTitle,
          'videoUrl': videoUrl,
          'createdAt': Timestamp.now(),
        });
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Trainer "$name" added successfully!'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error adding trainer: $e'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    }
  }

  Widget _buildDashboardButton({
    required VoidCallback onPressed,
    required IconData icon,
    required String label,
    required List<Color> gradientColors,
  }) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: gradientColors[0].withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 24),
        label: Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }

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
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF667eea),  // Light blue
                            Color(0xFF764ba2),  // Purple
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF667eea).withOpacity(0.4),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.admin_panel_settings,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 15),
                    const Text(
                      'Admin Dashboard',
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
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Management Panel',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Manage your fitness platform efficiently',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[400],
                          ),
                        ),
                        const SizedBox(height: 40),

                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildDashboardButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (_) => ViewUsersPage()));
                                },
                                icon: Icons.people_rounded,
                                label: "View Users",
                                gradientColors: [Color(0xFF4facfe), Color(0xFF00f2fe)],
                              ),
                              const SizedBox(height: 20),

                              _buildDashboardButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (_) => ViewTrainersPage()));
                                },
                                icon: Icons.fitness_center_rounded,
                                label: "View Trainers",
                                gradientColors: [Color(0xFF43e97b), Color(0xFF38f9d7)],
                              ),
                              const SizedBox(height: 20),

                              // 🔹 New Add Trainers Button
                              _buildDashboardButton(
                                onPressed: () {
                                  showAddTrainerDialog(context);
                                },
                                icon: Icons.person_add_rounded,
                                label: "Add Trainers",
                                gradientColors: [Color(0xFFf093fb), Color(0xFFf5576c)],
                              ),
                              const SizedBox(height: 20),

                              _buildDashboardButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (_) => EditTrainersListPage()));
                                },
                                icon: Icons.edit_rounded,
                                label: "Edit Trainers",
                                gradientColors: [Color(0xFFfa709a), Color(0xFFfee140)],
                              ),
                              const SizedBox(height: 20),

                              _buildDashboardButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (_) => TrainerPage()));
                                },
                                icon: Icons.home_rounded,
                                label: "Go to Homepage",
                                gradientColors: [Color(0xFFd299c2), Color(0xFFfef9d7)],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}