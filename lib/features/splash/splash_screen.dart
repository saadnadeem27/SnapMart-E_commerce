import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:math' as math;
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _particleController;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _navigateToHome();
  }

  void _initializeAnimations() {
    _particleController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();

    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));
  }

  void _navigateToHome() {
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        Navigator.of(context).pushReplacementNamed('/auth');
      }
    });
  }

  @override
  void dispose() {
    _particleController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.primaryGradient,
        ),
        child: Stack(
          children: [
            // Animated Particles
            ...List.generate(15, (index) => _buildFloatingParticle(index)),

            // Main Content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Animated Logo with Glow Effect
                  AnimatedBuilder(
                    animation: _pulseAnimation,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _pulseAnimation.value,
                        child: Container(
                          padding:
                              const EdgeInsets.all(AppDimensions.paddingXL),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.white.withOpacity(0.3),
                                blurRadius: 30,
                                spreadRadius: 10,
                              ),
                              BoxShadow(
                                color:
                                    AppColors.primaryMagenta.withOpacity(0.4),
                                blurRadius: 50,
                                spreadRadius: 20,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.shopping_bag_rounded,
                            size: 80,
                            color: AppColors.white,
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: AppDimensions.paddingXL),

                  // App Name with Gradient Text Effect
                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [AppColors.white, AppColors.electricBlue],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ).createShader(bounds),
                    child: const Text(
                      AppStrings.appName,
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                        letterSpacing: 2,
                      ),
                    ),
                  )
                      .animate()
                      .fadeIn(duration: const Duration(milliseconds: 1000))
                      .slideY(begin: 0.3, end: 0)
                      .then()
                      .shimmer(
                        duration: const Duration(seconds: 2),
                        color: AppColors.white.withOpacity(0.6),
                      ),

                  const SizedBox(height: AppDimensions.paddingM),

                  // Tagline
                  Text(
                    AppStrings.appTagline,
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.white.withOpacity(0.9),
                      fontWeight: FontWeight.w300,
                      letterSpacing: 1,
                    ),
                  )
                      .animate(delay: const Duration(milliseconds: 500))
                      .fadeIn(duration: const Duration(milliseconds: 800))
                      .slideY(begin: 0.2, end: 0),

                  const SizedBox(height: AppDimensions.paddingXXL),

                  // Loading Indicator
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.white.withOpacity(0.8),
                      ),
                    ),
                  )
                      .animate(delay: const Duration(milliseconds: 1000))
                      .fadeIn(duration: const Duration(milliseconds: 600))
                      .scale(begin: const Offset(0.5, 0.5)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingParticle(int index) {
    final random = math.Random(index);
    final startX = random.nextDouble();
    final startY = random.nextDouble();
    final size = 2.0 + random.nextDouble() * 4;
    final duration = 2000 + random.nextInt(2000);
    final delay = random.nextInt(2000);

    return Positioned(
      left: MediaQuery.of(context).size.width * startX,
      top: MediaQuery.of(context).size.height * startY,
      child: AnimatedBuilder(
        animation: _particleController,
        builder: (context, child) {
          final progress = (_particleController.value + (delay / 1000)) % 1.0;
          final opacity = (math.sin(progress * math.pi * 2) + 1) / 2;

          return Transform.translate(
            offset: Offset(
              math.sin(progress * math.pi * 2) * 20,
              -progress * 30,
            ),
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.white.withOpacity(opacity * 0.6),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.white.withOpacity(opacity * 0.3),
                    blurRadius: size * 2,
                    spreadRadius: 1,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    )
        .animate(delay: Duration(milliseconds: delay))
        .fadeIn(duration: Duration(milliseconds: duration ~/ 4))
        .then()
        .fadeOut(duration: Duration(milliseconds: duration ~/ 4));
  }
}
