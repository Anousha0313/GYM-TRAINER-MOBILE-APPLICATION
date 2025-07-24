import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math' as math;

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Information'),
        backgroundColor: const Color(0xFF6366F1), // Indigo
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header section with gradient
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF6366F1), // Indigo
                    const Color(0xFF8B5CF6), // Purple
                    const Color(0xFFEC4899), // Pink
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.white,
                            const Color(0xFFF8FAFC), // Light slate
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.fitness_center,
                        size: 40,
                        color: Color(0xFF6366F1), // Indigo
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Trainer Manager',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Version 1.0.0',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Content section
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Description Card
                  _buildInfoCard(
                    icon: Icons.info_outline,
                    iconColor: const Color(0xFF06B6D4), // Cyan
                    title: 'About This App',
                    content: 'This app is designed to help users manage their profiles and trainers with ease. We focus on simplicity and user experience to provide the best fitness management solution.',
                  ),

                  const SizedBox(height: 16),

                  // Features Card
                  _buildInfoCard(
                    icon: Icons.star_outline,
                    iconColor: const Color(0xFFF59E0B), // Amber
                    title: 'Key Features',
                    content: '• Profile Management\n• Trainer Scheduling\n• Progress Tracking\n• User-Friendly Interface\n• Secure Authentication',
                  ),

                  const SizedBox(height: 16),

                  // Technical Info Card
                  _buildInfoCard(
                    icon: Icons.code_outlined,
                    iconColor: const Color(0xFF10B981), // Emerald
                    title: 'Technical Information',
                    content: 'Built with Flutter and Firebase\nSupports Android and iOS\nReal-time data synchronization\nSecure cloud storage',
                  ),

                  const SizedBox(height: 16),

                  // User Manual Card
                  _buildExpandableCard(
                    icon: Icons.menu_book_outlined,
                    iconColor: const Color(0xFF8B5CF6), // Purple
                    title: 'User Manual',
                    sections: [
                      {
                        'title': '1. Getting Started',
                        'content': '• Create your account or sign in\n• Set up your profile with personal information\n• Choose your fitness goals and preferences'
                      },
                      {
                        'title': '2. Managing Your Profile',
                        'content': '• Tap on Profile to edit your information\n• Update your fitness goals anytime\n• Add profile picture and personal details\n• Set your workout preferences'
                      },
                      {
                        'title': '3. Finding Trainers',
                        'content': '• Browse available trainers in your area\n• Filter by specialization, rating, and experience\n• View trainer profiles and qualifications\n• Read reviews and testimonials'
                      },
                      {
                        'title': '4. Trainer Profiles',
                        'content': '• View detailed trainer information\n• Check specializations and certifications\n• See training experience and background\n• View photo gallery and videos'
                      },
                      {
                        'title': '5. Communication',
                        'content': '• Message trainers directly through the app\n• Receive notifications and updates\n• Share workout progress and achievements\n• Ask questions about training programs'
                      },
                      {
                        'title': '6. Troubleshooting',
                        'content': '• Check your internet connection\n• Update the app to latest version\n• Clear app cache if experiencing issues\n• Contact support for technical problems'
                      },
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Contact Card
                  _buildInfoCard(
                    icon: Icons.contact_support_outlined,
                    iconColor: const Color(0xFFEF4444), // Red
                    title: 'Support & Contact',
                    content: 'Need help? Contact our support team\nEmail: support@trainermanager.com\nPhone: +1 (555) 123-4567',
                  ),

                  const SizedBox(height: 24),

                  // Footer
                  Center(
                    child: Column(
                      children: [
                        Text(
                          'Made with ❤️ by Anoushaa',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF6366F1),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                const Color(0xFF6366F1).withOpacity(0.1),
                                const Color(0xFFEC4899).withOpacity(0.1),
                              ],
                            ),
                           // borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            '© 2025 EliteFit Team 🤍',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpandableCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required List<Map<String, String>> sections,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: Colors.white,
      shadowColor: iconColor.withOpacity(0.2),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white,
              iconColor.withOpacity(0.02),
            ],
          ),
        ),
        child: ExpansionTile(
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 24,
            ),
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: iconColor,
            ),
          ),
          children: sections.map((section) =>
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ExpansionTile(
                  title: Text(
                    section['title']!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF374151), // Gray-700
                    ),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          section['content']!,
                          style: const TextStyle(
                            fontSize: 14,
                            height: 1.6,
                            color: Color(0xFF6B7280), // Gray-500
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ).toList(),
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String content,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: Colors.white,
      shadowColor: iconColor.withOpacity(0.2),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white,
              iconColor.withOpacity(0.02),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: iconColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      icon,
                      color: iconColor,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: iconColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                content,
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.6,
                  color: Color(0xFF6B7280), // Gray-500
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}