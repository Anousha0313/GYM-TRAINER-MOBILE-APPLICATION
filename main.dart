import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math' as math;
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(EliteFitApp());
}

class EliteFitApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EliteFit',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Color(0xFFFFD700),
        scaffoldBackgroundColor: Colors.black,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF2196F3),
            foregroundColor: Colors.white,
            elevation: 10,
            textStyle: TextStyle(fontWeight: FontWeight.bold),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            minimumSize: Size(double.infinity, 50),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey[900],
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          labelStyle: TextStyle(color: Colors.white),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: AuthGate(),
    );
  }
}
class AuthGate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasData) {
          // User logged in, go to TrainerPage
          return TrainerPage();
        } else {
          // User not logged in, show WelcomePage
          return WelcomePage();
        }
      },
    );
  }
}
class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _rotationController;
  late AnimationController _pulseController;
  late AnimationController _breatheController;
  late AnimationController _glowController;
  late AnimationController _waveController;

  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _breatheAnimation;
  late Animation<double> _glowAnimation;
  late Animation<double> _waveAnimation;

  bool _isMenuOpen = false;

  // Enhanced Color Palette
  static const Color primaryPurple = Color(0xFF6C5CE7);
  static const Color secondaryBlue = Color(0xFF00D4FF);
  static const Color accentGold = Color(0xFFFFD700);
  static const Color deepPurple = Color(0xFF4834D4);
  static const Color neonPink = Color(0xFFE84393);
  static const Color electricBlue = Color(0xFF0984E3);
  static const Color darkBackground = Color(0xFF0A0A0A);
  static const Color cardDark = Color(0xFF1A1A2E);
  static const Color textLight = Color(0xFFE8E8E8);
  static const Color textMuted = Color(0xFFB0B0B0);

  @override
  void initState() {
    super.initState();

    // Initialize all animation controllers with staggered durations
    _scaleController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 1800)
    );

    _fadeController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 2000)
    );

    _slideController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 1200)
    );

    _rotationController = AnimationController(
        vsync: this,
        duration: Duration(seconds: 30)
    );

    _pulseController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 3000)
    );

    _breatheController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 4000)
    );

    _glowController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 2500)
    );

    _waveController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 8000)
    );

    // Initialize enhanced animations
    _scaleAnimation = CurvedAnimation(
        parent: _scaleController,
        curve: Curves.elasticOut
    );

    _fadeAnimation = CurvedAnimation(
        parent: _fadeController,
        curve: Curves.easeInOut
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.8),
      end: Offset.zero,
    ).animate(CurvedAnimation(
        parent: _slideController,
        curve: Curves.easeOutBack
    ));

    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 2 * math.pi,
    ).animate(CurvedAnimation(
        parent: _rotationController,
        curve: Curves.linear
    ));

    _pulseAnimation = Tween<double>(
      begin: 0.95,
      end: 1.15,
    ).animate(CurvedAnimation(
        parent: _pulseController,
        curve: Curves.easeInOutSine
    ));

    _breatheAnimation = Tween<double>(
      begin: 1.0,
      end: 1.3,
    ).animate(CurvedAnimation(
        parent: _breatheController,
        curve: Curves.easeInOutCirc
    ));

    _glowAnimation = Tween<double>(
      begin: 0.3,
      end: 1.0,
    ).animate(CurvedAnimation(
        parent: _glowController,
        curve: Curves.easeInOutQuart
    ));

    _waveAnimation = Tween<double>(
      begin: 0,
      end: 4 * math.pi,
    ).animate(CurvedAnimation(
        parent: _waveController,
        curve: Curves.linear
    ));

    // Start animations with sophisticated timing
    _startAnimations();
  }

  void _startAnimations() async {
    // Staggered entrance animations
    await Future.delayed(Duration(milliseconds: 200));
    _scaleController.forward();

    await Future.delayed(Duration(milliseconds: 300));
    _fadeController.forward();

    await Future.delayed(Duration(milliseconds: 400));
    _slideController.forward();

    // Start continuous ambient animations
    _rotationController.repeat();
    _pulseController.repeat(reverse: true);
    _breatheController.repeat(reverse: true);
    _glowController.repeat(reverse: true);
    _waveController.repeat();
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _fadeController.dispose();
    _slideController.dispose();
    _rotationController.dispose();
    _pulseController.dispose();
    _breatheController.dispose();
    _glowController.dispose();
    _waveController.dispose();
    super.dispose();
  }

  Widget buildEnhancedLogo() {
    return AnimatedBuilder(
      animation: Listenable.merge([_rotationAnimation, _pulseAnimation, _breatheAnimation, _glowAnimation]),
      builder: (context, child) {
        return Transform.scale(
          scale: _breatheAnimation.value,
          child: Container(
            width: 140,
            height: 140,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  primaryPurple.withOpacity(0.9),
                  deepPurple,
                  electricBlue,
                  secondaryBlue,
                ],
                stops: [0.2, 0.5, 0.8, 1.0],
              ),
              boxShadow: [
                BoxShadow(
                  color: primaryPurple.withOpacity(_glowAnimation.value * 0.8),
                  blurRadius: 40 * _glowAnimation.value,
                  spreadRadius: 8 * _glowAnimation.value,
                ),
                BoxShadow(
                  color: secondaryBlue.withOpacity(_glowAnimation.value * 0.6),
                  blurRadius: 60 * _glowAnimation.value,
                  spreadRadius: 4 * _glowAnimation.value,
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  blurRadius: 20,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Outer rotating ring
                Transform.rotate(
                  angle: _rotationAnimation.value,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: accentGold.withOpacity(0.6),
                        width: 3,
                      ),
                    ),
                    child: Stack(
                      children: List.generate(8, (index) {
                        return Transform.rotate(
                          angle: (index * math.pi / 4),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              width: 4,
                              height: 4,
                              margin: EdgeInsets.only(top: 4),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: accentGold,
                                boxShadow: [
                                  BoxShadow(
                                    color: accentGold.withOpacity(0.8),
                                    blurRadius: 6,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
                // Inner counter-rotating ring
                Transform.rotate(
                  angle: -_rotationAnimation.value * 0.7,
                  child: Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withOpacity(0.4),
                        width: 2,
                      ),
                    ),
                  ),
                ),
                // Center icon with pulse
                Transform.scale(
                  scale: _pulseAnimation.value,
                  child: ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: [
                        Colors.white,
                        accentGold,
                        neonPink,
                        Colors.white,
                      ],
                      stops: [0.0, 0.3, 0.7, 1.0],
                    ).createShader(bounds),
                    child: Icon(
                      Icons.self_improvement_rounded,
                      size: 60,
                      color: Colors.white,
                    ),
                  ),
                ),
                // Elite badge
                Positioned(
                  bottom: 15,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [accentGold, Color(0xFFFFA500)],
                      ),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: accentGold.withOpacity(0.5),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Text(
                      "ELITE",
                      style: TextStyle(
                        color: darkBackground,
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildEnhancedMenuWidget() {
    return Positioned(
      top: 50,
      left: 20,
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isMenuOpen = !_isMenuOpen;
          });
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 600),
          curve: Curves.easeInOutBack,
          width: _isMenuOpen ? 220 : 70,
          height: _isMenuOpen ? 400 : 70,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                cardDark.withOpacity(0.95),
                Color(0xFF2D1B69).withOpacity(0.95),
                primaryPurple.withOpacity(0.85),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: primaryPurple.withOpacity(0.6),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: primaryPurple.withOpacity(0.4),
                blurRadius: 30,
                spreadRadius: 3,
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 20,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: _isMenuOpen ? _buildExpandedMenu() : _buildCollapsedMenu(),
        ),
      ),
    );
  }

  Widget _buildCollapsedMenu() {
    return Center(
      child: AnimatedBuilder(
        animation: _pulseAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: 0.8 + (_pulseAnimation.value * 0.2),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [primaryPurple, neonPink, accentGold],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: primaryPurple.withOpacity(0.6),
                    blurRadius: 15,
                  ),
                ],
              ),
              child: Icon(
                Icons.apps_rounded,
                size: 24,
                color: Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildExpandedMenu() {
    return Padding(
      padding: EdgeInsets.all(25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildMenuHeader(),
          SizedBox(height: 10),
          _buildMenuItem(
            icon: Icons.settings_rounded,
            title: "Settings",
            gradient: [primaryPurple, deepPurple],
            onTap: () {
              print("Settings tapped");
              setState(() {
                _isMenuOpen = false;
              });
            },
          ),
          _buildMenuItem(
            icon: Icons.info_rounded,
            title: "Info",
            gradient: [neonPink, Color(0xFFE84393)],
            onTap: () {
              print("Info tapped");
              setState(() {
                _isMenuOpen = false;
              });
            },
          ),
          _buildMenuItem(
            icon: Icons.people_rounded,
            title: "About Us",
            gradient: [electricBlue, secondaryBlue],
            onTap: () {
              print("About Us tapped");
              setState(() {
                _isMenuOpen = false;
              });
            },
          ),
          _buildMenuItem(
            icon: Icons.support_agent_rounded,
            title: "Support",
            gradient: [accentGold, Color(0xFFFFA500)],
            onTap: () {
              print("Support tapped");
              setState(() {
                _isMenuOpen = false;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMenuHeader() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryPurple, neonPink, accentGold],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: primaryPurple.withOpacity(0.4),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.menu_rounded,
            size: 18,
            color: Colors.white,
          ),
          SizedBox(width: 10),
          Text(
            "Menu",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.8,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required List<Color> gradient,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        width: double.infinity,
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 18),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: gradient[0].withOpacity(0.4),
              blurRadius: 12,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                size: 18,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 15),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAnimatedButton({
    required String text,
    required List<Color> gradientColors,
    required VoidCallback onTap,
    required Color textColor,
    bool isPrimary = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedBuilder(
        animation: _glowAnimation,
        builder: (context, child) {
          return AnimatedContainer(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOutCubic,
            padding: EdgeInsets.symmetric(
                vertical: isPrimary ? 20 : 18,
                horizontal: isPrimary ? 80 : 70
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: gradientColors,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(40),
              boxShadow: [
                BoxShadow(
                  color: gradientColors[0].withOpacity(0.6 * _glowAnimation.value),
                  blurRadius: 30 * _glowAnimation.value,
                  spreadRadius: 3 * _glowAnimation.value,
                  offset: Offset(0, 8),
                ),
                BoxShadow(
                  color: gradientColors[1].withOpacity(0.4),
                  blurRadius: 20,
                  offset: Offset(0, 10),
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 15,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Text(
              text,
              style: TextStyle(
                fontSize: isPrimary ? 22 : 20,
                color: textColor,
                fontWeight: FontWeight.w900,
                letterSpacing: 2.0,
                shadows: isPrimary ? [
                  Shadow(
                    color: textColor.withOpacity(0.3),
                    offset: Offset(0, 2),
                    blurRadius: 4,
                  ),
                ] : null,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildFloatingParticle(int index) {
    return AnimatedBuilder(
      animation: Listenable.merge([_waveAnimation, _rotationAnimation]),
      builder: (context, child) {
        final double wave1 = math.sin(_waveAnimation.value + index * 0.5) * 50;
        final double wave2 = math.cos(_waveAnimation.value * 0.7 + index * 0.8) * 30;
        final double rotation = _rotationAnimation.value + index;

        return Positioned(
          top: 80 + (index * 100).toDouble() + wave1,
          left: 30 + (index * 80).toDouble() + wave2,
          child: Transform.rotate(
            angle: rotation,
            child: Container(
              width: 6 + (index % 3) * 2,
              height: 6 + (index % 3) * 2,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    [primaryPurple, neonPink, accentGold, secondaryBlue][index % 4],
                    Colors.transparent,
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: [primaryPurple, neonPink, accentGold, secondaryBlue][index % 4].withOpacity(0.8),
                    blurRadius: 8,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBackground,
      body: Stack(
        children: [
          // Enhanced animated background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  darkBackground,
                  Color(0xFF1A0B2E),
                  Color(0xFF2D1B69),
                  cardDark,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.0, 0.3, 0.7, 1.0],
              ),
            ),
          ),
          // Enhanced floating particles
          ...List.generate(8, (index) => buildFloatingParticle(index)),
          // Main content
          Center(
            child: SlideTransition(
              position: _slideAnimation,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Enhanced Logo
                        buildEnhancedLogo(),
                        SizedBox(height: 50),
                        // Enhanced App Title
                        ShaderMask(
                          shaderCallback: (bounds) => LinearGradient(
                            colors: [
                              primaryPurple,
                              neonPink,
                              accentGold,
                              secondaryBlue,
                              primaryPurple,
                            ],
                          ).createShader(bounds),
                          child: Text(
                            "Welcome to EliteFit",
                            style: TextStyle(
                              fontSize: 38,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              letterSpacing: 1.5,
                              height: 1.2,
                              shadows: [
                                Shadow(
                                  color: primaryPurple.withOpacity(0.6),
                                  offset: Offset(0, 4),
                                  blurRadius: 20,
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 20),
                        // Enhanced Subtitle
                        Text(
                          "Transform Your Body, Elevate Your Mind",
                          style: TextStyle(
                            fontSize: 20,
                            color: textLight,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.0,
                            height: 1.3,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Train Smarter • Get Stronger • Live Better",
                          style: TextStyle(
                            fontSize: 16,
                            color: accentGold,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1.2,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 80),
                        // Enhanced buttons
                        buildAnimatedButton(
                          text: "LOGIN",
                          gradientColors: [
                            primaryPurple,
                            deepPurple,
                            electricBlue,
                          ],
                          textColor: Colors.white,
                          isPrimary: true,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => LoginPage()),
                            );
                            print("Login tapped");
                          },
                        ),
                        SizedBox(height: 25),
                        buildAnimatedButton(
                          text: "SIGN UP",
                          gradientColors: [
                            accentGold,
                            Color(0xFFFFA500),
                            neonPink,
                          ],
                          textColor: darkBackground,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => SignupPage()),
                            );
                            print("Sign up tapped");
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Enhanced Menu Widget
          buildEnhancedMenuWidget(),
          // Menu overlay
          if (_isMenuOpen)
            GestureDetector(
              onTap: () {
                setState(() {
                  _isMenuOpen = false;
                });
              },
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.black.withOpacity(0.4),
              ),
            ),
        ],
      ),
    );
  }
}
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void loginUser() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in both fields')),
      );
      return;
    }

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => TrainerPage()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: Colors.white),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topLeft,
            radius: 1.5,
            colors: [Colors.blue.shade900, Colors.indigo.shade600, Colors.purple.shade400],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 80),
            child: Column(
              children: [
                Icon(Icons.lock_open_rounded, size: 90, color: Colors.yellowAccent.shade700),
                SizedBox(height: 30),
                Text("Login to EliteFit", style: TextStyle(fontSize: 34, color: Colors.white, fontWeight: FontWeight.bold)),
                SizedBox(height: 40),
                buildInputField("Email", emailController, false),
                SizedBox(height: 20),
                buildInputField("Password", passwordController, true),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: loginUser,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 60),
                    backgroundColor: Colors.yellowAccent.shade700,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    elevation: 15,
                  ),
                  child: Text("Login", style: TextStyle(color: Colors.black, fontSize: 18)),
                ),
                TextButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SignupPage())),
                  child: Text("Don't have an account? Sign Up", style: TextStyle(color: Colors.white70)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInputField(String label, TextEditingController controller, bool obscure) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.white.withOpacity(0.15),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide(color: Colors.yellowAccent, width: 2)),
      ),
    );
  }
}
class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final nameController = TextEditingController();
  final contactController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    contactController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void registerUser() async {
    final name = nameController.text.trim();
    final contact = contactController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (name.isEmpty || contact.isEmpty || email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    try {
      final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = userCredential.user?.uid;

      // Store in Firestore
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'name': name,
        'contact': contact,
        'email': email,
        'createdAt': Timestamp.now(),
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => TrainerPage()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Signup failed: ${e.toString()}')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: Colors.white),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.bottomRight,
            radius: 1.4,
            colors: [
              Colors.purple.shade900,
              Colors.pink.shade600,
              Colors.deepPurple.shade400,
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 80),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.person_add, size: 90, color: Colors.cyanAccent.shade400),
                SizedBox(height: 30),
                Text(
                  "Create Your Account",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.3,
                    shadows: [Shadow(color: Colors.purpleAccent, blurRadius: 15)],
                  ),
                ),
                SizedBox(height: 40),

                buildInputField("Full Name", nameController, false),
                SizedBox(height: 20),
                buildInputField("Contact Number", contactController, false, isPhone: true),
                SizedBox(height: 20),
                buildInputField("Email", emailController, false),
                SizedBox(height: 20),
                buildInputField("Password", passwordController, true),
                SizedBox(height: 25),

                ElevatedButton(
                  onPressed: registerUser,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 60),
                    backgroundColor: Colors.cyanAccent.shade400,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    elevation: 15,
                    shadowColor: Colors.cyanAccent,
                  ),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),

                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account? ", style: TextStyle(color: Colors.white)),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.cyanAccent.shade400,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInputField(String label, TextEditingController controller, bool obscure, {bool isPhone = false}) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      keyboardType: isPhone ? TextInputType.phone : TextInputType.text,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.white.withOpacity(0.15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.cyanAccent, width: 2),
        ),
      ),
    );
  }
}
class TrainerPage extends StatefulWidget {
  @override
  _TrainerPageState createState() => _TrainerPageState();
}

class _TrainerPageState extends State<TrainerPage> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final List<Map<String, String>> trainerDetails = [
    {
      'trainerName': 'Fatima',
      'gymName': 'FitLife Gym',
      'exercise': 'Yoga, Cardio, HIIT',
    },
    {
      'trainerName': 'Anousha',
      'gymName': 'PowerHouse Gym',
      'exercise': 'Weightlifting, CrossFit',
    },
    {
      'trainerName': 'Aima',
      'gymName': 'FlexZone Gym',
      'exercise': 'Strength Training, Pilates',
    },
    {
      'trainerName': 'Maria',
      'gymName': 'GymX',
      'exercise': 'Cycling, Aerobics',
    },
  ];

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.elasticOut,
    ));

    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FadeTransition(
          opacity: _fadeAnimation,
          child: Text(
            'Choose Your Trainer',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.black, Colors.blue.shade900],
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white),
            tooltip: 'Logout',
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => WelcomePage()),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black, Colors.blue.shade900, Colors.purple.shade900],
          ),
        ),
        child: SlideTransition(
          position: _slideAnimation,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.75,
              ),
              padding: EdgeInsets.all(16),
              itemCount: trainerDetails.length,
              itemBuilder: (context, index) {
                return AnimatedTrainerCard(
                  trainer: trainerDetails[index],
                  index: index,
                  onTap: () => _showTrainerDialog(trainerDetails[index]),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void _showTrainerDialog(Map<String, String> trainer) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      barrierColor: Colors.black54,
      transitionDuration: Duration(milliseconds: 300),
      pageBuilder: (context, animation1, animation2) {
        return Container();
      },
      transitionBuilder: (context, animation1, animation2, widget) {
        return Transform.scale(
          scale: animation1.value,
          child: Opacity(
            opacity: animation1.value,
            child: AlertDialog(
              backgroundColor: Colors.grey.shade900,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: Text(
                'Trainer Info',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade800, Colors.purple.shade600],
                  ),
                ),
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow('Name', trainer['trainerName']!),
                    SizedBox(height: 12),
                    _buildInfoRow('Gym', trainer['gymName']!),
                    SizedBox(height: 12),
                    _buildInfoRow('Specializes in', trainer['exercise']!),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Close',
                    style: TextStyle(color: Colors.grey.shade300),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _navigateToTrainerDetail(trainer);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow.shade700,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Select Trainer',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label: ',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  void _navigateToTrainerDetail(Map<String, String> trainer) {
    Widget detailPage = TrainerDetailPage(trainer: trainer);

    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => detailPage,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: animation.drive(
              Tween(begin: Offset(1.0, 0.0), end: Offset.zero)
                  .chain(CurveTween(curve: Curves.elasticOut)),
            ),
            child: child,
          );
        },
        transitionDuration: Duration(milliseconds: 800),
      ),
    );
  }
}
class AnimatedTrainerCard extends StatefulWidget {
  final Map<String, String> trainer;
  final int index;
  final VoidCallback onTap;

  const AnimatedTrainerCard({
    Key? key,
    required this.trainer,
    required this.index,
    required this.onTap,
  }) : super(key: key);

  @override
  _AnimatedTrainerCardState createState() => _AnimatedTrainerCardState();
}

class _AnimatedTrainerCardState extends State<AnimatedTrainerCard>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _bounceController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<double> _bounceAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );

    _bounceController = AnimationController(
      duration: Duration(milliseconds: 600),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 0.02,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _bounceAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _bounceController,
      curve: Curves.elasticOut,
    ));

    // Staggered entrance animation
    Future.delayed(Duration(milliseconds: widget.index * 150), () {
      if (mounted) {
        _bounceController.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _bounceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _bounceAnimation,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Transform.rotate(
              angle: _rotationAnimation.value,
              child: GestureDetector(
                onTapDown: (_) {
                  _controller.forward();
                },
                onTapUp: (_) {
                  _controller.reverse();
                  widget.onTap();
                },
                onTapCancel: () {
                  _controller.reverse();
                },
                child: MouseRegion(
                  onEnter: (_) {
                    setState(() => _isHovered = true);
                    _controller.forward();
                  },
                  onExit: (_) {
                    setState(() => _isHovered = false);
                    _controller.reverse();
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: _isHovered ? 12 : 8,
                    clipBehavior: Clip.antiAlias,
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.blue.shade800,
                            Colors.purple.shade600,
                            Colors.pink.shade400,
                          ],
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Hero(
                            tag: 'trainer_${widget.trainer['trainerName']}',
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  colors: [Colors.yellow.shade600, Colors.orange.shade400],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 8,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.person,
                                size: 30,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Text(
                            widget.trainer['trainerName']!,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  offset: Offset(0, 2),
                                  blurRadius: 4,
                                  color: Colors.black38,
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            widget.trainer['gymName']!,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white70,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Container(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: widget.onTap,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.yellow.shade700,
                                foregroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                elevation: 4,
                                padding: EdgeInsets.symmetric(vertical: 12),
                              ),
                              child: Text(
                                'View Details',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
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
  }
}
class GradientAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Color> gradientColors;

  const GradientAppBar({
    Key? key,
    required this.title,
    required this.gradientColors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
      title: Text(title),
      centerTitle: true,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
class TrainerDetailPage extends StatelessWidget {
  final Map<String, String> trainer;

  const TrainerDetailPage({Key? key, required this.trainer}) : super(key: key);

  // Button with gradient background
  Widget gradientButton(BuildContext context, String text, List<Color> colors, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: colors),
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Text(text, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(trainer['trainerName'] ?? 'Trainer Detail'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black, Colors.blue.shade900],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.blue.shade900],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Detail page for ${trainer['trainerName']}',
              style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),
            gradientButton(
              context,
              'Start Workout',
              [Colors.blueAccent.shade700, Colors.blueAccent.shade200],
                  () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WorkoutSessionPage(trainer: trainer),
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            gradientButton(
              context,
              'Track Progress',
              [Colors.green.shade700, Colors.greenAccent.shade400],
                  () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TrackProgressPage(trainer: trainer),
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            gradientButton(
              context,
              'Chat with Trainer',
              [Colors.purple.shade700, Colors.purpleAccent.shade400],
                  () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatWithTrainerPage(trainer: trainer),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
class WorkoutSessionPage extends StatelessWidget {
  final Map<String, String> trainer;

  WorkoutSessionPage({Key? key, required this.trainer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Trainer ke exercises ko split kar rahe hain
    final exercises = trainer['exercise'] != null
        ? trainer['exercise']!.split(',').map((e) => e.trim()).toList()
        : <String>[];

    // Ab manual ek map bana rahe hain jahan har exercise ka duration aur reps define hain
    final Map<String, Map<String, String>> exerciseDetails = {
      'Yoga': {'duration': '30 mins', 'times': '1 turn'},
      'Cardio': {'duration': '20 mins', 'times': '1 turn'},
      'HIIT': {'duration': '15 mins', 'times': '3 turns'},
      'Weightlifting': {'duration': '40 mins', 'times': '2 turns'},
      'CrossFit': {'duration': '25 mins', 'times': '3 turns'},
      'Strength Training': {'duration': '35 mins', 'times': '2 turns'},
      'Pilates': {'duration': '30 mins', 'times': '1 turn'},
      'Cycling': {'duration': '50 mins', 'times': '1 turn'},
      'Aerobics': {'duration': '40 mins', 'times': '2 turns'},
    };
    return Scaffold(
      appBar: AppBar(
        title: Text('Workout Session'),
        backgroundColor: Colors.deepPurple.shade700,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple.shade200, Colors.deepPurple.shade800],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.deepPurple.shade400,
              child: Text(
                trainer['trainerName'] != null && trainer['trainerName']!.isNotEmpty
                    ? trainer['trainerName']!.substring(0, 1).toUpperCase()
                    : '',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Training with ${trainer['trainerName'] ?? 'Trainer'}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 5),
            Text(
              'Gym: ${trainer['gymName'] ?? 'N/A'}',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
            SizedBox(height: 20),

            Text(
              'Total Exercises: ${exercises.length}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),

            SizedBox(height: 15),
            Expanded(
              child: ListView.separated(
                itemCount: exercises.length,
                separatorBuilder: (_, __) => Divider(color: Colors.white70),
                itemBuilder: (context, index) {
                  final exerciseName = exercises[index];
                  final details = exerciseDetails[exerciseName] ?? {'duration': '-', 'times': '-'};
                  return ListTile(
                    leading: Icon(Icons.fitness_center, color: Colors.white),
                    title: Text(
                      exerciseName,
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                      ),
                    ),
                    subtitle: Text(
                      'Duration: ${details['duration']} | Times: ${details['times']}',
                      style: TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class TrackProgressPage extends StatelessWidget {
  final Map<String, dynamic> trainer;
  const TrackProgressPage({Key? key, required this.trainer}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final beforeProgress = trainer['beforeProgress'] as Map<String, String>? ?? {};
    final afterProgress = trainer['afterProgress'] as Map<String, String>? ?? {};
    final exercises = (trainer['exercise'] as String?)?.split(',').map((e) => e.trim()).toList() ?? [];
    final beforeDate = trainer['beforeDate'] ?? 'Before';
    final afterDate = trainer['afterDate'] ?? 'After';
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple, Colors.indigo],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
                ),
                const SizedBox(height: 10),
                Text(
                  'Trainer: ${trainer['trainerName']}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Gym: ${trainer['gymName']}',
                  style: const TextStyle(fontSize: 18, color: Colors.white70),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Before: $beforeDate', style: const TextStyle(color: Colors.white)),
                    Text('After: $afterDate', style: const TextStyle(color: Colors.white)),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: exercises.length,
                    itemBuilder: (context, index) {
                      final exercise = exercises[index];
                      final beforeStr = beforeProgress[exercise] ?? '-';
                      final afterStr = afterProgress[exercise] ?? '-';

                      String progressPercent = '-';
                      if (_isNumeric(beforeStr) && _isNumeric(afterStr)) {
                        final beforeVal = double.parse(beforeStr);
                        final afterVal = double.parse(afterStr);
                        if (beforeVal != 0) {
                          final change = ((afterVal - beforeVal) / beforeVal) * 100;
                          progressPercent = "${change >= 0 ? '+' : ''}${change.toStringAsFixed(1)}%";
                        }
                      }

                      return Card(
                        color: Colors.white.withOpacity(0.95),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                exercise,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Before: $beforeStr',
                                      style: const TextStyle(color: Colors.black)),
                                  Text('After: $afterStr',
                                      style: const TextStyle(color: Colors.black)),
                                  Text('Progress: $progressPercent',
                                      style: TextStyle(
                                          color: progressPercent.startsWith('-')
                                              ? Colors.red
                                              : Colors.green,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ],
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
      ),
    );
  }

  bool _isNumeric(String str) {
    return double.tryParse(str) != null;
  }
}


class ChatWithTrainerPage extends StatefulWidget {
  final Map<String, String> trainer;

  const ChatWithTrainerPage({Key? key, required this.trainer}) : super(key: key);

  @override
  State<ChatWithTrainerPage> createState() => _ChatWithTrainerPageState();
}

class _ChatWithTrainerPageState extends State<ChatWithTrainerPage> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<Map<String, dynamic>> _messages = [];
  bool _isTyping = false;

  static const List<String> _emojis = ['💪', '🔥', '😊', '👍', '🏋‍♂', '🥳', '🙌'];

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add({
        'sender': 'you',
        'text': text,
        'time': DateTime.now(),
      });
      _controller.clear();
      _isTyping = true;
    });
    _scrollToBottom();

    Future.delayed(const Duration(milliseconds: 800), () {
      setState(() {
        _messages.add({
          'sender': 'trainer',
          'text': _generateAIReply(text),
          'time': DateTime.now(),
        });
        _isTyping = false;
      });
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent + 60,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  String _generateAIReply(String userMessage) {
    // Simulated AI replies based on simple keywords
    final lower = userMessage.toLowerCase();
    if (lower.contains('tired')) return "Keep pushing! Rest is important too 💤";
    if (lower.contains('hi') || lower.contains('hello')) return "Hey! Ready to crush today's workout? 💪";
    if (lower.contains('how are you')) return "I'm great, thanks! Let's get stronger together! 🚀";
    return "Great job! Let's keep up the momentum 💪";
  }

  void _insertEmoji(String emoji) {
    _controller.text += emoji;
    _controller.selection = TextSelection.fromPosition(TextPosition(offset: _controller.text.length));
  }

  String _formatTime(DateTime time) {
    return DateFormat('hh:mm a').format(time);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFD700), Color(0xFF8E2DE2)], // Yellow to Purple
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // AppBar style row
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Chat with ${widget.trainer['trainerName']}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(color: Colors.white30, height: 1),

              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16),
                  itemCount: _messages.length + (_isTyping ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (_isTyping && index == _messages.length) {
                      // Typing indicator
                      return Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 10),
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.deepPurpleAccent.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Text(
                            "Trainer is typing...",
                            style: TextStyle(color: Colors.white70,
                                fontStyle: FontStyle.italic),
                          ),
                        ),
                      );
                    }

                    final message = _messages[index];
                    final isMe = message['sender'] == 'you';

                    return Align(
                      alignment: isMe ? Alignment.centerRight : Alignment
                          .centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 10),
                        constraints: BoxConstraints(maxWidth: MediaQuery
                            .of(context)
                            .size
                            .width * 0.7),
                        decoration: BoxDecoration(
                          color: isMe ? Colors.white : Colors.deepPurpleAccent
                              .withOpacity(0.2),
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(16),
                            topRight: const Radius.circular(16),
                            bottomLeft: Radius.circular(isMe ? 16 : 0),
                            bottomRight: Radius.circular(isMe ? 0 : 16),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              message['text'],
                              style: TextStyle(
                                color: isMe ? Colors.black87 : Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _formatTime(message['time']),
                              style: TextStyle(
                                color: (isMe ? Colors.black45 : Colors.white54),
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Emoji picker
              Container(
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                color: Colors.white.withOpacity(0.1),
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _emojis.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final emoji = _emojis[index];
                    return GestureDetector(
                      onTap: () => _insertEmoji(emoji),
                      child: Text(
                        emoji,
                        style: const TextStyle(fontSize: 28),
                      ),
                    );
                  },
                ),
              ),

              // Input bar
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 10),
                color: Colors.white.withOpacity(0.1),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          hintText: 'Type your message...',
                          hintStyle: TextStyle(color: Colors.white54),
                          border: InputBorder.none,
                        ),
                        textInputAction: TextInputAction.send,
                        onSubmitted: (_) => _sendMessage(),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send, color: Colors.white),
                      onPressed: _sendMessage,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}