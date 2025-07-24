import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TrainerInquiryPage extends StatefulWidget {
  @override
  _TrainerInquiryPageState createState() => _TrainerInquiryPageState();
}

class _TrainerInquiryPageState extends State<TrainerInquiryPage>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late AnimationController _pulseController;

  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _pulseAnimation;

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
  static const Color trainerGreen = Color(0xFF00B894);

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );

    _scaleController = AnimationController(
      duration: Duration(milliseconds: 1200),
      vsync: this,
    );

    _pulseController = AnimationController(
      duration: Duration(milliseconds: 2000),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    );

    _scaleAnimation = CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    );

    _pulseAnimation = Tween<double>(
      begin: 0.95,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOutSine,
    ));

    _startAnimations();
  }

  void _startAnimations() async {
    _fadeController.forward();
    await Future.delayed(Duration(milliseconds: 300));
    _scaleController.forward();
    _pulseController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scaleController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  void _copyEmailToClipboard() {
    Clipboard.setData(ClipboardData(text: 'anoushaa@gmail.com'));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 8),
            Text('Email copied to clipboard!'),
          ],
        ),
        backgroundColor: trainerGreen,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Widget _buildCriteriaCard(String title, String description, IconData icon) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            cardDark.withOpacity(0.8),
            Color(0xFF2D1B69).withOpacity(0.6),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: primaryPurple.withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: primaryPurple.withOpacity(0.2),
            blurRadius: 15,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [trainerGreen, Color(0xFF00A085)],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 24,
            ),
          ),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    color: textLight,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: textLight.withOpacity(0.8),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBackground,
      body: Container(
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
        child: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(30),
                child: Column(
                  children: [
                    // Back button
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [primaryPurple, deepPurple],
                              ),
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: primaryPurple.withOpacity(0.4),
                                  blurRadius: 10,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.arrow_back_ios_rounded,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 30),

                    // Icon with glow effect
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            trainerGreen.withOpacity(0.9),
                            Color(0xFF00A085),
                            electricBlue,
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: trainerGreen.withOpacity(0.6),
                            blurRadius: 30,
                            spreadRadius: 5,
                          ),
                          BoxShadow(
                            color: Colors.black.withOpacity(0.4),
                            blurRadius: 20,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.fitness_center_rounded,
                        size: 60,
                        color: Colors.white,
                      ),
                    ),

                    SizedBox(height: 30),

                    // Title
                    ShaderMask(
                      shaderCallback: (bounds) => LinearGradient(
                        colors: [
                          trainerGreen,
                          electricBlue,
                          accentGold,
                        ],
                      ).createShader(bounds),
                      child: Text(
                        "Want to be a Trainer?",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          letterSpacing: 1.2,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    SizedBox(height: 20),

                    // Description
                    Text(
                      "Join our elite team of fitness professionals!\nMeet the criteria below and contact us to get started.",
                      style: TextStyle(
                        fontSize: 16,
                        color: textLight,
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                        letterSpacing: 0.5,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: 30),

                    // Criteria Section
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(25),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            cardDark.withOpacity(0.9),
                            Color(0xFF2D1B69).withOpacity(0.7),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          color: primaryPurple.withOpacity(0.5),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: primaryPurple.withOpacity(0.3),
                            blurRadius: 20,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            "Trainer Requirements",
                            style: TextStyle(
                              fontSize: 22,
                              color: accentGold,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1.0,
                            ),
                          ),
                          SizedBox(height: 20),

                          _buildCriteriaCard(
                            "Certified Professional",
                            "Must have valid fitness/personal training certification",
                            Icons.verified_rounded,
                          ),

                          _buildCriteriaCard(
                            "Experience Required",
                            "Minimum 2 years of training experience",
                            Icons.timeline_rounded,
                          ),

                          _buildCriteriaCard(
                            "Communication Skills",
                            "Excellent verbal and written communication",
                            Icons.chat_bubble_rounded,
                          ),

                          _buildCriteriaCard(
                            "Availability",
                            "Flexible schedule with weekend availability",
                            Icons.schedule_rounded,
                          ),

                          _buildCriteriaCard(
                            "Passion for Fitness",
                            "Genuine enthusiasm for helping others achieve goals",
                            Icons.favorite_rounded,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 30),

                    // Contact info card
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(25),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            cardDark.withOpacity(0.8),
                            Color(0xFF2D1B69).withOpacity(0.6),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          color: primaryPurple.withOpacity(0.5),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: primaryPurple.withOpacity(0.3),
                            blurRadius: 20,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.email_rounded,
                            size: 40,
                            color: accentGold,
                          ),
                          SizedBox(height: 15),
                          Text(
                            "Contact Admin",
                            style: TextStyle(
                              fontSize: 20,
                              color: textLight,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.0,
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [accentGold, Color(0xFFFFA500)],
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text(
                              "anoushaa@gmail.com",
                              style: TextStyle(
                                fontSize: 16,
                                color: darkBackground,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 30),

                    // Copy Email Button
                    AnimatedBuilder(
                      animation: _pulseAnimation,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _pulseAnimation.value,
                          child: GestureDetector(
                            onTap: _copyEmailToClipboard,
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(vertical: 18, horizontal: 30),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [trainerGreen, Color(0xFF00A085)],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                    color: trainerGreen.withOpacity(0.5),
                                    blurRadius: 20,
                                    spreadRadius: 2,
                                    offset: Offset(0, 8),
                                  ),
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    blurRadius: 15,
                                    offset: Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.copy_rounded,
                                    size: 24,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 12),
                                  Text(
                                    "Copy Email Address",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 1.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),

                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}