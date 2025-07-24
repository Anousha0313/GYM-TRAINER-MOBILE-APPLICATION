// //
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:firebase_core/firebase_core.dart';
// // import 'package:flutter/material.dart';
// // import 'package:intl/intl.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'dart:math' as math;
// // class Trainer {
// //   String trainerName;
// //   String gymName;
// //   String exercise;
// //
// //   Trainer({
// //     required this.trainerName,
// //     required this.gymName,
// //     required this.exercise,
// //   });
// // }
// // class EditTrainerPage extends StatefulWidget {
// //   final Trainer trainer;
// //
// //   EditTrainerPage({required this.trainer});
// //
// //   @override
// //   _EditTrainerPageState createState() => _EditTrainerPageState();
// // }
// //
// // class _EditTrainerPageState extends State<EditTrainerPage> {
// //   late TextEditingController nameController;
// //   late TextEditingController gymController;
// //   late TextEditingController exerciseController;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     nameController = TextEditingController(text: widget.trainer.trainerName);
// //     gymController = TextEditingController(text: widget.trainer.gymName);
// //     exerciseController = TextEditingController(text: widget.trainer.exercise);
// //   }
// //
// //   void _saveChanges() {
// //     widget.trainer.trainerName = nameController.text;
// //     widget.trainer.gymName = gymController.text;
// //     widget.trainer.exercise = exerciseController.text;
// //
// //     Navigator.pop(context, widget.trainer);
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: Text('Edit Trainer')),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           children: [
// //             TextField(controller: nameController, decoration: InputDecoration(labelText: 'Trainer Name')),
// //             TextField(controller: gymController, decoration: InputDecoration(labelText: 'Gym Name')),
// //             TextField(controller: exerciseController, decoration: InputDecoration(labelText: 'Exercises')),
// //             SizedBox(height: 20),
// //             ElevatedButton(
// //               onPressed: _saveChanges,
// //               child: Text('Save'),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// // List<Trainer> trainerList = [
// //   Trainer(trainerName: 'Fatima', gymName: 'FitLife Gym', exercise: 'Yoga, Cardio, HIIT'),
// //   Trainer(trainerName: 'Anousha', gymName: 'PowerHouse Gym', exercise: 'Weightlifting, CrossFit'),
// //   Trainer(trainerName: 'Aima', gymName: 'FlexZone Gym', exercise: 'Strength Training, Pilates'),
// //   Trainer(trainerName: 'Maria', gymName: 'GymX', exercise: 'Cycling, Aerobics'),
// // ];
// // class EditTrainersListPage extends StatefulWidget {
// //   @override
// //   _EditTrainersListPageState createState() => _EditTrainersListPageState();
// // }
// // class _EditTrainersListPageState extends State<EditTrainersListPage> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: Text('Edit/Delete Trainers')),
// //       body: ListView.builder(
// //         itemCount: trainerList.length,
// //         itemBuilder: (context, index) {
// //           final trainer = trainerList[index];
// //           return ListTile(
// //             title: Text(trainer.trainerName),
// //             subtitle: Text('${trainer.gymName}\n${trainer.exercise}'),
// //             isThreeLine: true,
// //             trailing: Icon(Icons.edit),
// //             onTap: () async {
// //               final updatedTrainer = await Navigator.push(
// //                 context,
// //                 MaterialPageRoute(
// //                   builder: (_) => EditTrainerPage(trainer: trainer),
// //                 ),
// //               );
// //               if (updatedTrainer != null) {
// //                 setState(() {}); // refresh after editing
// //               }
// //             },
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }
// //
// //
// // Updated version with Firestore integration
//
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class Trainer {
//   String docId;
//   String trainerName;
//   String gymName;
//   String exercise;
//
//   Trainer({
//     required this.docId,
//     required this.trainerName,
//     required this.gymName,
//     required this.exercise,
//   });
//
//   Map<String, dynamic> toMap() {
//     return {
//       'trainerName': trainerName,
//       'gymName': gymName,
//       'exercise': exercise,
//     };
//   }
//
//   factory Trainer.fromDocument(DocumentSnapshot doc) {
//     final data = doc.data() as Map<String, dynamic>;
//     return Trainer(
//       docId: doc.id,
//       trainerName: data['trainerName'] ?? '',
//       gymName: data['gymName'] ?? '',
//       exercise: data['exercise'] ?? '',
//     );
//   }
// }
//
// class EditTrainerPage extends StatefulWidget {
//   final Trainer trainer;
//
//   EditTrainerPage({required this.trainer});
//
//   @override
//   _EditTrainerPageState createState() => _EditTrainerPageState();
// }
//
// class _EditTrainerPageState extends State<EditTrainerPage> {
//   late TextEditingController nameController;
//   late TextEditingController gymController;
//   late TextEditingController exerciseController;
//
//   @override
//   void initState() {
//     super.initState();
//     nameController = TextEditingController(text: widget.trainer.trainerName);
//     gymController = TextEditingController(text: widget.trainer.gymName);
//     exerciseController = TextEditingController(text: widget.trainer.exercise);
//   }
//
//   void _saveChanges() async {
//     final updatedTrainer = Trainer(
//       docId: widget.trainer.docId,
//       trainerName: nameController.text,
//       gymName: gymController.text,
//       exercise: exerciseController.text,
//     );
//
//     await FirebaseFirestore.instance
//         .collection('trainers')
//         .doc(updatedTrainer.docId)
//         .update(updatedTrainer.toMap());
//
//     Navigator.pop(context, updatedTrainer);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Edit Trainer')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(controller: nameController, decoration: InputDecoration(labelText: 'Trainer Name')),
//             TextField(controller: gymController, decoration: InputDecoration(labelText: 'Gym Name')),
//             TextField(controller: exerciseController, decoration: InputDecoration(labelText: 'Exercises')),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _saveChanges,
//               child: Text('Save'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class EditTrainersListPage extends StatefulWidget {
//   @override
//   _EditTrainersListPageState createState() => _EditTrainersListPageState();
// }
//
// class _EditTrainersListPageState extends State<EditTrainersListPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Edit/Delete Trainers')),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance.collection('trainers').snapshots(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
//
//           final trainers = snapshot.data!.docs.map((doc) => Trainer.fromDocument(doc)).toList();
//
//           return ListView.builder(
//             itemCount: trainers.length,
//             itemBuilder: (context, index) {
//               final trainer = trainers[index];
//               return ListTile(
//                 title: Text(trainer.trainerName),
//                 subtitle: Text('${trainer.gymName}\n${trainer.exercise}'),
//                 isThreeLine: true,
//                 trailing: Icon(Icons.edit),
//                 onTap: () async {
//                   final updatedTrainer = await Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) => EditTrainerPage(trainer: trainer),
//                     ),
//                   );
//                   if (updatedTrainer != null) {
//                     setState(() {}); // Refresh UI
//                   }
//                 },
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'EditTrainersListPage.dart';

class EditTrainerPage extends StatefulWidget {
  final Trainer trainer;

  EditTrainerPage({required this.trainer});

  @override
  _EditTrainerPageState createState() => _EditTrainerPageState();
}

class _EditTrainerPageState extends State<EditTrainerPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController gymController;
  late TextEditingController exerciseController;
  bool _isLoading = false;
  bool _hasChanges = false;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.trainer.trainerName);
    gymController = TextEditingController(text: widget.trainer.gymName);
    exerciseController = TextEditingController(text: widget.trainer.exercise);

    // Add listeners to detect changes
    nameController.addListener(_checkForChanges);
    gymController.addListener(_checkForChanges);
    exerciseController.addListener(_checkForChanges);
  }

  void _checkForChanges() {
    final hasChanges = nameController.text != widget.trainer.trainerName ||
        gymController.text != widget.trainer.gymName ||
        exerciseController.text != widget.trainer.exercise;

    if (hasChanges != _hasChanges) {
      setState(() {
        _hasChanges = hasChanges;
      });
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    gymController.dispose();
    exerciseController.dispose();
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    if (!_hasChanges) return true;

    final shouldDiscard = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Color(0xFF2A2A3E),
        title: Text('Discard changes?', style: TextStyle(color: Colors.white)),
        content: Text('You have unsaved changes. Are you sure you want to go back?', style: TextStyle(color: Colors.white)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('Cancel', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Discard', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    return shouldDiscard ?? false;
  }

  void _saveChanges() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final updatedData = {
        'trainerName': nameController.text.trim(),
        'gymName': gymController.text.trim(),
        'exercise': exerciseController.text.trim(),
        'updatedAt': FieldValue.serverTimestamp(),
      };

      await FirebaseFirestore.instance
          .collection('trainers')
          .doc(widget.trainer.docId)
          .update(updatedData);

      Navigator.pop(context, true); // Return true to indicate success
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error updating trainer: $e'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _resetForm() {
    nameController.text = widget.trainer.trainerName;
    gymController.text = widget.trainer.gymName;
    exerciseController.text = widget.trainer.exercise;
    setState(() {
      _hasChanges = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text('Edit Trainer', style: TextStyle(color: Colors.white)),
          backgroundColor: Color(0xFF16213e),
          foregroundColor: Colors.white,
          elevation: 0,
          actions: [
            if (_hasChanges)
              TextButton(
                onPressed: _resetForm,
                child: Text(
                  'Reset',
                  style: TextStyle(color: Colors.white),
                ),
              ),
          ],
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header card with trainer info
                Card(
                  color: Color(0xFF2A2A3E),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Color(0xFF667eea).withOpacity(0.2),
                          child: Icon(
                            Icons.person,
                            size: 30,
                            color: Color(0xFF667eea),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Editing Trainer',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFFB0B0C0),
                                ),
                              ),
                              Text(
                                widget.trainer.trainerName,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 24),

                // Form fields card
                Card(
                  color: Color(0xFF2A2A3E),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: nameController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'Trainer Name',
                            labelStyle: TextStyle(color: Color(0xFFB0B0C0)),
                            prefixIcon: Icon(Icons.person, color: Color(0xFF667eea)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Color(0xFF3A3A4E)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Color(0xFF3A3A4E)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Color(0xFF667eea)),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            filled: true,
                            fillColor: Color(0xFF3A3A4E),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter trainer name';
                            }
                            if (value.trim().length < 2) {
                              return 'Name must be at least 2 characters';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          controller: gymController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'Gym Name',
                            labelStyle: TextStyle(color: Color(0xFFB0B0C0)),
                            prefixIcon: Icon(Icons.business, color: Color(0xFF667eea)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Color(0xFF3A3A4E)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Color(0xFF3A3A4E)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Color(0xFF667eea)),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            filled: true,
                            fillColor: Color(0xFF3A3A4E),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter gym name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          controller: exerciseController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'Exercises',
                            labelStyle: TextStyle(color: Color(0xFFB0B0C0)),
                            prefixIcon: Icon(Icons.fitness_center, color: Color(0xFF667eea)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Color(0xFF3A3A4E)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Color(0xFF3A3A4E)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Color(0xFF667eea)),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            filled: true,
                            fillColor: Color(0xFF3A3A4E),
                            hintText: 'e.g., Yoga, Cardio, HIIT',
                            hintStyle: TextStyle(color: Color(0xFFB0B0C0)),
                            helperText: 'Separate multiple exercises with commas',
                            helperStyle: TextStyle(color: Color(0xFFB0B0C0)),
                          ),
                          maxLines: 3,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter exercises';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 24),

                // Action buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _isLoading ? null : () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          side: BorderSide(color: Color(0xFF3A3A4E)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Cancel',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        onPressed: (_isLoading || !_hasChanges) ? null : _saveChanges,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF667eea),
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 2,
                        ),
                        child: _isLoading
                            ? SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                            : Text(
                          'Save Changes',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16),

                // Info card
                if (_hasChanges)
                  Card(
                    color: Color(0xFF667eea).withOpacity(0.2),
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Icon(Icons.info_outline, color: Color(0xFF667eea), size: 20),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'You have unsaved changes',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
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
      ),
    );
  }
}