import 'package:flutter/material.dart';
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
  late AnimationController _logoController;
  late AnimationController _waveController;
  late AnimationController _textController;
  late AnimationController _progressController;

  late Animation<double> _logoScale;
  late Animation<double> _logoRotation;
  late Animation<double> _waveAnimation;
  late Animation<double> _textFade;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAnimationSequence();
    _navigateToHome();
  }

  void _initializeAnimations() {
    // Logo animations
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _logoScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.elasticOut),
    );

    _logoRotation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeInOut),
    );

    // Wave animation
    _waveController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    _waveAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_waveController);

    // Text animation
    _textController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _textFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeIn),
    );

    // Progress animation
    _progressController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _progressController, curve: Curves.easeInOut),
    );
  }

  void _startAnimationSequence() async {
    // Check if still mounted before each animation
    if (!mounted) return;

    // Start logo animation
    await _logoController.forward();

    // Start text animation with delay
    if (!mounted) return;
    await Future.delayed(const Duration(milliseconds: 300));
    if (!mounted) return;
    await _textController.forward();

    // Start progress animation
    if (!mounted) return;
    await Future.delayed(const Duration(milliseconds: 200));
    if (!mounted) return;
    _progressController.forward();
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
    _logoController.dispose();
    _waveController.dispose();
    _textController.dispose();
    _progressController.dispose();
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
            // Animated wave background
            ...List.generate(3, (index) => _buildWaveLayer(index)),

            // Main content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Professional logo with modern design
                  AnimatedBuilder(
                    animation: _logoController,
                    builder: (context, child) {
                        // Use a Stack so we can render a soft pulsating glow behind the logo
                        return Transform.scale(
                          scale: _logoScale.value,
                          child: Transform.rotate(
                            angle: _logoRotation.value * 0.1,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                // Pulsating radial glow (powered by _waveAnimation)
                                AnimatedBuilder(
                                  animation: _waveController,
                                  builder: (context, _) {
                                    final glow = 0.18 + _waveAnimation.value * 0.12;
                                    return Container(
                                      width: 220,
                                      height: 220,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: RadialGradient(
                                          colors: [
                                            AppColors.primaryMagenta.withOpacity(glow),
                                            AppColors.primaryViolet.withOpacity(glow * 0.6),
                                            AppColors.electricBlue.withOpacity(glow * 0.2),
                                          ],
                                          stops: const [0.0, 0.6, 1.0],
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppColors.primaryMagenta.withOpacity(glow),
                                            blurRadius: 60,
                                            spreadRadius: 8,
                                          ),
                                          BoxShadow(
                                            color: AppColors.electricBlue.withOpacity(glow * 0.6),
                                            blurRadius: 100,
                                            spreadRadius: 20,
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),

                                // Actual logo container
                                Container(
                                  width: 140,
                                  height: 140,
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        AppColors.white,
                                        AppColors.electricBlue,
                                        AppColors.primaryMagenta,
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.white.withOpacity(0.45),
                                        blurRadius: 30,
                                        spreadRadius: 0,
                                      ),
                                      BoxShadow(
                                        color: AppColors.primaryMagenta.withOpacity(0.28),
                                        blurRadius: 40,
                                        spreadRadius: 8,
                                      ),
                                    ],
                                  ),
                                  child: Container(
                                    margin: const EdgeInsets.all(8),
                                    decoration: const BoxDecoration(
                                      gradient: AppColors.primaryGradient,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.shopping_bag_rounded,
                                      size: 80,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                    },
                  ),

                  const SizedBox(height: AppDimensions.paddingXXL),

                  // Modern app name with professional typography
                  AnimatedBuilder(
                    animation: _textController,
                    builder: (context, child) {
                      return Opacity(
                        opacity: _textFade.value,
                        child: Column(
                          children: [
                            ShaderMask(
                              shaderCallback: (bounds) => const LinearGradient(
                                colors: [
                                  Color(0xFFFDFCFB),
                                 AppColors.electricBlue,
                                  Color(0xFFFDFCFB),
                                  AppColors.electricBlue,
                                  Color(0xFFF7F7F7),
                                ],
                                stops: [0.0, 0.28, 0.55, 0.85, 1.0],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ).createShader(bounds),
                              child: const Text(
                                AppStrings.appName,
                                style: TextStyle(
                                  fontSize: 56,
                                  fontWeight: FontWeight.w900,
                                  color: AppColors.white,
                                  letterSpacing: 4,
                                  height: 1.0,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 18.0,
                                      color: Color.fromRGBO(0, 0, 0, 0.25),
                                      offset: Offset(0, 6),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: AppDimensions.paddingS),
                            Container(
                              height: 3,
                              width: 100,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    AppColors.electricBlue,
                                    AppColors.primaryMagenta,
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                            const SizedBox(height: AppDimensions.paddingM),
                            Text(
                              AppStrings.appTagline.toUpperCase(),
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.white.withOpacity(0.9),
                                fontWeight: FontWeight.w600,
                                letterSpacing: 4,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: AppDimensions.paddingXXL * 2),

                  // Modern progress indicator
                  AnimatedBuilder(
                    animation: _progressController,
                    builder: (context, child) {
                      return Column(
                        children: [
                          Container(
                            width: 200,
                            height: 4,
                            decoration: BoxDecoration(
                              color: AppColors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                width: 200 * _progressAnimation.value,
                                height: 4,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      AppColors.electricBlue,
                                      AppColors.primaryMagenta,
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: AppDimensions.paddingM),
                          Text(
                            'Loading amazing products...',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.white.withOpacity(0.7),
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWaveLayer(int index) {
    return AnimatedBuilder(
      animation: _waveController,
      builder: (context, child) {
        return Positioned.fill(
          child: CustomPaint(
            painter: WavePainter(
              animationValue: _waveAnimation.value,
              layer: index,
            ),
          ),
        );
      },
    );
  }
}

class WavePainter extends CustomPainter {
  final double animationValue;
  final int layer;

  WavePainter({required this.animationValue, required this.layer});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = AppColors.white.withOpacity(0.05 - layer * 0.01);

    final path = Path();
    final waveHeight = 30.0 + layer * 10;
    final waveLength = size.width / (2 + layer);

    path.moveTo(0, size.height);

    for (double x = 0; x <= size.width; x += 1) {
      final y = size.height -
          waveHeight *
              math.sin((x / waveLength + animationValue * 2 * math.pi + layer) %
                  (2 * math.pi));
      path.lineTo(x, y);
    }

    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(WavePainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}
