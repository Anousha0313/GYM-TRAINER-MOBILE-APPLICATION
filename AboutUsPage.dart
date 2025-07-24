import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math' as math;

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'About EliteFit',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(color: Colors.white),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.deepPurple.shade900,
              Colors.indigo.shade700,
              Colors.blue.shade600,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                // Hero Section
                Center(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              Colors.yellowAccent.shade700,
                              Colors.orange.shade600,
                            ],
                          ),
                        ),
                        child: const Icon(
                          Icons.fitness_center,
                          size: 60,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'EliteFit',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const Text(
                        'Transform Your Fitness Journey',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                // Mission Section
                _buildSection(
                  icon: Icons.rocket_launch,
                  title: 'Our Mission',
                  content: 'At EliteFit, we believe fitness should be accessible to everyone, everywhere. Our mission is to revolutionize the way people approach fitness by providing cutting-edge virtual training experiences that adapt to your lifestyle, goals, and preferences.',
                ),

                const SizedBox(height: 30),

                // Vision Section
                _buildSection(
                  icon: Icons.visibility,
                  title: 'Our Vision',
                  content: 'To create a world where distance and time are no barriers to achieving your fitness dreams. We envision a future where personalized, AI-driven fitness coaching is available at your fingertips, making elite-level training accessible to all.',
                ),

                const SizedBox(height: 30),

                // Values Section
                _buildSection(
                  icon: Icons.favorite,
                  title: 'Our Values',
                  content: 'Innovation • Excellence • Inclusivity • Dedication • Community\n\nWe are committed to continuous innovation while maintaining the highest standards of quality and inclusivity in everything we do.',
                ),

                const SizedBox(height: 30),

                // Team Section
                _buildSection(
                  icon: Icons.group,
                  title: 'Meet Our Team',
                  content: 'Our passionate team combines expertise in fitness, technology, and user experience design.',
                ),

                const SizedBox(height: 20),

                // Developer Spotlight
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.purple.shade600,
                                  Colors.pink.shade500,
                                ],
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.code,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Anousha',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'Lead Developer',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.yellowAccent,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'The visionary behind EliteFit\'s innovative architecture. Anousha combines deep technical expertise with a passion for creating seamless user experiences that motivate and inspire fitness enthusiasts worldwide.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // Devotion Section
                _buildSection(
                  icon: Icons.psychology,
                  title: 'Our Devotion',
                  content: 'We are devoted to your success. Every feature, every workout, every interaction is carefully crafted with your fitness journey in mind. Our commitment goes beyond just building an app – we\'re building a community of achievers.',
                ),

                const SizedBox(height: 30),

                // Contact Section
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.indigo.shade800,
                        Colors.purple.shade700,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Icon(
                            Icons.contact_mail,
                            color: Colors.yellowAccent,
                            size: 28,
                          ),
                          SizedBox(width: 12),
                          Text(
                            'Get In Touch',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      _buildContactItem(Icons.email, 'support@elitefit.com'),
                      const SizedBox(height: 12),
                      _buildContactItem(Icons.phone, '+1 (555) 123-4567'),
                      const SizedBox(height: 12),
                      _buildContactItem(Icons.language, 'www.elitefit.com'),
                      const SizedBox(height: 16),
                      const Text(
                        'We love hearing from our community! Reach out with questions, feedback, or just to share your fitness wins.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                // Footer
                Center(
                  child: Column(
                    children: const [
                      Text(
                        '© 2025 EliteFit. All rights reserved.',
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Made with ❤️ for fitness enthusiasts everywhere',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection({
    required IconData icon,
    required String title,
    required String content,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity(0.15),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.yellowAccent.shade700,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            content,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.white,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.yellowAccent.shade700,
          size: 20,
        ),
        const SizedBox(width: 12),
        Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}