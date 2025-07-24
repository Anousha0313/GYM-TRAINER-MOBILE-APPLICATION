import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool notificationsEnabled = true;
  bool emailNotifications = true;
  bool pushNotifications = true;
  bool locationServices = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (doc.exists) {
        final data = doc.data()!;
        setState(() {
          notificationsEnabled = data['notifications'] ?? true;
          emailNotifications = data['emailNotifications'] ?? true;
          pushNotifications = data['pushNotifications'] ?? true;
          locationServices = data['locationServices'] ?? false;
        });
      }
    }
  }

  Future<void> _updateSetting(String key, bool value) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        key: value,
      }, SetOptions(merge: true));
    }
  }

  void _toggleTheme() {
    themeNotifier.value = themeNotifier.value == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
  }

  Future<void> _showSignOutDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text('Sign Out'),
          content: const Text('Are you sure you want to sign out?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFEF4444),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Sign Out'),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pop();
                // Navigate to SignOut page
                Navigator.pushReplacementNamed(context, '/signout');
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF1F2937) : const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: const Color(0xFF6366F1),
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFF6366F1),
                    const Color(0xFF6366F1).withOpacity(0.8),
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.person,
                        size: 50,
                        color: const Color(0xFF6366F1),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      FirebaseAuth.instance.currentUser?.email ?? 'User',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Manage your account settings',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Settings Sections
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  // Notifications Section
                  _buildSettingsSection(
                    'Notifications',
                    Icons.notifications_outlined,
                    const Color(0xFF8B5CF6),
                    [
                      _buildSwitchTile(
                        'Push Notifications',
                        'Receive notifications on your device',
                        Icons.phone_android,
                        pushNotifications,
                            (value) {
                          setState(() {
                            pushNotifications = value;
                          });
                          _updateSetting('pushNotifications', value);
                        },
                      ),
                      _buildSwitchTile(
                        'Email Notifications',
                        'Receive notifications via email',
                        Icons.email_outlined,
                        emailNotifications,
                            (value) {
                          setState(() {
                            emailNotifications = value;
                          });
                          _updateSetting('emailNotifications', value);
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Privacy Section
                  _buildSettingsSection(
                    'Privacy & Security',
                    Icons.shield_outlined,
                    const Color(0xFF10B981),
                    [
                      _buildSwitchTile(
                        'Location Services',
                        'Allow location-based features',
                        Icons.location_on_outlined,
                        locationServices,
                            (value) {
                          setState(() {
                            locationServices = value;
                          });
                          _updateSetting('locationServices', value);
                        },
                      ),
                      _buildActionTile(
                        'Privacy Policy',
                        'Read our privacy policy',
                        Icons.policy_outlined,
                            () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const PrivacyPage()),
                          );
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // App Section
                  _buildSettingsSection(
                    'App',
                    Icons.settings_outlined,
                    const Color(0xFF06B6D4),
                    [
                      _buildActionTileNoArrow(
                        'Theme',
                        themeNotifier.value == ThemeMode.light ? 'Light Mode' : 'Dark Mode',
                        Icons.color_lens_outlined,
                        _toggleTheme,
                      ),
                      _buildActionTileNoArrow(
                        'Language',
                        'English',
                        Icons.language_outlined,
                            () {
                          // Handle language selection
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Sign Out Button
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 16),

                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsSection(String title, IconData icon, Color color, List<Widget> children) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white,
              color.withOpacity(0.02),
            ],
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      icon,
                      color: color,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ],
              ),
            ),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchTile(String title, String subtitle, IconData icon, bool value, Function(bool) onChanged) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey[600]),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey[600],
        ),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: const Color(0xFF6366F1),
      ),
    );
  }

  Widget _buildActionTile(String title, String subtitle, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey[600]),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey[600],
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  Widget _buildActionTileNoArrow(String title, String subtitle, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey[600]),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey[600],
        ),
      ),
      onTap: onTap,
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFF10B981),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
        backgroundColor: const Color(0xFF6366F1),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Privacy Policy',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6366F1),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Last updated: ${DateTime.now().year}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 24),
            _buildPrivacySection(
              'Information We Collect',
              'We collect information you provide directly to us, such as when you create an account, use our services, or contact us for support.',
            ),
            _buildPrivacySection(
              'How We Use Your Information',
              'We use the information we collect to provide, maintain, and improve our services, process transactions, and communicate with you.',
            ),
            _buildPrivacySection(
              'Information Sharing',
              'We do not sell, trade, or otherwise transfer your personal information to third parties without your consent, except as described in this policy.',
            ),
            _buildPrivacySection(
              'Data Security',
              'We implement appropriate security measures to protect your personal information against unauthorized access, alteration, disclosure, or destruction.',
            ),
            _buildPrivacySection(
              'Your Rights',
              'You have the right to access, update, or delete your personal information. You may also opt out of certain communications from us.',
            ),
            _buildPrivacySection(
              'Contact Us',
              'If you have any questions about this Privacy Policy, please contact us at support@trainermanager.com',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrivacySection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF374151),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(
              fontSize: 16,
              height: 1.6,
              color: Color(0xFF6B7280),
            ),
          ),
        ],
      ),
    );
  }
}