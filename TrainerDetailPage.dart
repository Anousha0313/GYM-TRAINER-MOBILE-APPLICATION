import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newproject/WelcomePage.dart';
import 'ChatWithTrainerPage.dart';
import 'TrainerPage.dart';
import 'WorkoutSessionPage.dart'; // Add this import
import 'package:newproject/helpers/database_helper.dart';
import 'TrackProgressPage.dart';
import 'YoutubePlayerPage.dart';
class TrainerDetailPage extends StatelessWidget {
  final String trainerId;
  const TrainerDetailPage({super.key, required this.trainerId});
  @override
  Widget build(BuildContext context) {
    final trainerDoc = FirebaseFirestore.instance.collection('trainers').doc(trainerId);
    return Scaffold(
      backgroundColor: const Color(0xFFFDF4FF), // Very light purple background
      body: FutureBuilder<DocumentSnapshot>(
        future: trainerDoc.get(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Trainer Details"),
                backgroundColor: const Color(0xFFF3E8FF), // Light purple
                foregroundColor: const Color(0xFF7C3AED), // Purple 600
                elevation: 0,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.home),
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        WelcomePage() as String, // Replace with your welcome page route
                            (route) => false,
                      );
                    },
                    tooltip: 'Go to Welcome',
                  ),
                ],
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 64, color: const Color(0xFFF87171)), // Light red
                    const SizedBox(height: 16),
                    Text(
                      'Failed to load trainer',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Please try again later',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: const Color(0xFF9CA3AF), // Light gray
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          if (!snapshot.hasData || snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Trainer Details"),
                backgroundColor: const Color(0xFFF3E8FF), // Light purple
                foregroundColor: const Color(0xFF7C3AED), // Purple 600
                elevation: 0,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.home),
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        WelcomePage() as String, // Replace with your welcome page route
                            (route) => false,
                      );
                    },
                    tooltip: 'Go to Welcome',
                  ),
                ],
              ),
              body: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF7C3AED)), // Purple 600
                    ),
                    SizedBox(height: 16),
                    Text('Loading trainer details...'),
                  ],
                ),
              ),
            );
          }

          if (!snapshot.data!.exists) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Trainer Details"),
                backgroundColor: const Color(0xFFF3E8FF), // Light purple
                foregroundColor: const Color(0xFF7C3AED), // Purple 600
                elevation: 0,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.home),
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        WelcomePage() as String, // Replace with your welcome page route
                            (route) => false,
                      );
                    },
                    tooltip: 'Go to Welcome',
                  ),
                ],
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.person_off, size: 64, color: const Color(0xFFD1D5DB)), // Light gray
                    const SizedBox(height: 16),
                    Text(
                      'Trainer not found',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: const Color(0xFF9CA3AF), // Light gray
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          final trainer = snapshot.data!;
          final data = trainer.data() as Map<String, dynamic>;

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 200,
                pinned: true,
                backgroundColor: const Color(0xFFF3E8FF), // Light purple
                foregroundColor: const Color(0xFF7C3AED), // Purple 600
                actions: [
                  IconButton(
                    icon: const Icon(Icons.home),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TrainerPage(),
                        ),
                      );
                    },
                    tooltip: 'Go to Welcome',
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    data['name'] ?? 'Unknown Trainer',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF7C3AED), // Purple 600
                      shadows: [
                        Shadow(
                          offset: Offset(0, 1),
                          blurRadius: 3,
                          color: Color(0x40000000),
                        ),
                      ],
                    ),
                  ),
                  background: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFFF3E8FF), // Light purple
                          Color(0xFFE9D5FF), // Slightly deeper light purple
                        ],
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.fitness_center,
                        size: 80,
                        color: Color(0xFFA855F7), // Purple 500
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoCard(
                        icon: Icons.person,
                        title: 'Trainer Information',
                        children: [
                          _buildInfoRow(
                            icon: Icons.badge,
                            label: 'Name',
                            value: data['name'] ?? 'Not specified',
                          ),
                          _buildInfoRow(
                            icon: Icons.location_on,
                            label: 'Gym',
                            value: data['gymName'] ?? 'Not specified',
                          ),
                          _buildInfoRow(
                            icon: Icons.fitness_center,
                            label: 'Specialization',
                            value: data['exercise'] ?? 'Not specified',
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // What We Will Do Section
                      _buildInfoCard(
                        icon: Icons.assignment,
                        title: 'What We Will Do',
                        children: [
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color(0xFFECFDF5), // Light mint green
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: const Color(0xFF6EE7B7), // Light green
                                width: 1,
                              ),
                            ),
                            child: Text(
                              data['whatWeWillDo'] ?? 'Join our comprehensive fitness program designed to help you achieve your goals through personalized training, proper form guidance, and progressive workout routines.',
                              style: const TextStyle(
                                fontSize: 16,
                                height: 1.5,
                                color: Color(0xFF374151), // Dark gray
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Action Buttons
                      Column(
                        children: [
                          // Start Workout Session Button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => WorkoutSessionPage(
                                      trainer: {
                                        'trainerId': trainerId,
                                        'trainerName': data['name'] ?? 'Trainer',
                                        'exercise': data['exercise'] ?? 'General Fitness',
                                        'gymName': data['gymName'] ?? 'Gym',
                                        'whatWeWillDo': data['whatWeWillDo'] ?? 'Personalized training session',
                                      },
                                    ),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.play_arrow, size: 24),
                              label: const Text('Start Workout Session'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF10B981), // Light emerald
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 2,
                                shadowColor: const Color(0xFF10B981).withOpacity(0.3),
                                textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Chat and Progress Buttons Row
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ChatWithTrainerPage(
                                          trainer: {
                                            'trainerId': trainerId,
                                            'trainerName': data['name'] ?? 'Trainer',
                                          },
                                        ),
                                      ),
                                    );

                                  },
                                  icon: const Icon(Icons.chat, size: 20),
                                  label: const Text('Chat'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF60A5FA), // Light blue
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(vertical: 14),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    elevation: 2,
                                    shadowColor: const Color(0xFF60A5FA).withOpacity(0.3),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),

                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            final dbHelper = DatabaseHelper();
                            final allProgress = await dbHelper.getProgress();

                            // Filter only for this trainer
                            final trainerProgress = allProgress.where((entry) =>
                            entry['trainer'] == data['name']).toList();

                            final Map<String, String> beforeProgress = {};
                            final Map<String, String> afterProgress = {};
                            String beforeDate = '';
                            String afterDate = '';

                            // Extract values
                            for (var entry in trainerProgress) {
                              final exercise = entry['exercise'];
                              final value = entry['duration'].toString();
                              final date = entry['date'];
                              if (beforeProgress[exercise] == null) {
                                beforeProgress[exercise] = value;
                                beforeDate = date;
                              } else {
                                afterProgress[exercise] = value;
                                afterDate = date;
                              }
                            }

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => TrackProgressPage(
                                  trainer: {
                                    'trainerName': data['name'],
                                    'gymName': data['gymName'],
                                    'exercise': data['exercise'],
                                    'beforeProgress': beforeProgress,
                                    'afterProgress': afterProgress,
                                    'beforeDate': beforeDate,
                                    'afterDate': afterDate,
                                  },
                                ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.bar_chart_rounded),
                          label: const Text('Track My Progress'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF6366F1), // Indigo
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Exercise Videos Section
                      Row(
                        children: [
                          const Icon(Icons.play_circle_fill, color: Color(0xFFEC4899), size: 28), // Light pink
                          const SizedBox(width: 8),
                          Text(
                            'Exercise Videos',
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF374151), // Dark gray
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: StreamBuilder<QuerySnapshot>(
                  stream: trainerDoc.collection('exercises').orderBy('title').snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Padding(
                        padding: const EdgeInsets.all(16),
                        child: Card(
                          color: Colors.white,
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                const Icon(Icons.error_outline, color: Color(0xFFF87171)), // Light red
                                const SizedBox(width: 12),
                                const Text('Failed to load videos'),
                              ],
                            ),
                          ),
                        ),
                      );
                    }

                    if (!snapshot.hasData || snapshot.connectionState == ConnectionState.waiting) {
                      return const Padding(
                        padding: EdgeInsets.all(16),
                        child: Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF7C3AED)), // Purple 600
                          ),
                        ),
                      );
                    }

                    final videos = snapshot.data!.docs;

                    if (videos.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.all(16),
                        child: Card(
                          color: Colors.white,
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(32),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.video_library_outlined,
                                  size: 48,
                                  color: const Color(0xFFD1D5DB), // Light gray
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'No videos available',
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: const Color(0xFF9CA3AF), // Light gray
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Check back later for new exercise videos',
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: const Color(0xFFD1D5DB), // Light gray
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: videos.map((video) {
                          final videoData = video.data() as Map<String, dynamic>;
                          return Card(
                            color: Colors.white,
                            elevation: 1,
                            margin: const EdgeInsets.only(bottom: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: () {
                                final youtubeUrl = videoData['videoUrl'];// Fixed field name

                                if (youtubeUrl == null || youtubeUrl.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Video URL is not available'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                  return;
                                }

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => YouTubePlayerPage(youtubeUrl: youtubeUrl),
                                  ),
                                );
                              },

                                child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFCE7F3), // Light pink
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: const Icon(
                                        Icons.play_circle_fill,
                                        color: Color(0xFFEC4899), // Pink 500
                                        size: 32,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            videoData['title'] ?? 'Untitled Video',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                              color: Color(0xFF374151), // Dark gray
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            'Tap to play',
                                            style: const TextStyle(
                                              color: Color(0xFF9CA3AF), // Light gray
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFEC4899), // Pink 500
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: const Text(
                                        'Play',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  },
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 16),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required List<Widget> children,
  }) {
    return Card(
      color: Colors.white,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: const Color(0xFF7C3AED), size: 24), // Purple 600
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF374151), // Dark gray
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: const Color(0xFF9CA3AF)), // Light gray
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF9CA3AF), // Light gray
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF374151), // Dark gray
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}