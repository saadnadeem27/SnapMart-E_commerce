import 'package:flutter/material.dart';

class AppColors {
  // Primary Gradient Colors
  static const Color primaryViolet = Color(0xFF8B5CF6);
  static const Color primaryMagenta = Color(0xFFE879F9);
  static const Color primaryBlue = Color(0xFF3B82F6);
  static const Color electricBlue = Color(0xFF06B6D4);

  // Gradient Definitions
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryViolet, primaryMagenta, electricBlue],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [primaryMagenta, primaryBlue],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient glowGradient = LinearGradient(
    colors: [
      Color(0xFF8B5CF6),
      Color(0xFFE879F9),
      Color(0xFF3B82F6),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // Light Theme Colors
  static const Color lightBackground = Color(0xFFFAFAFA);
  static const Color lightSurface = Colors.white;
  static const Color lightCardBg = Colors.white;
  static const Color lightPrimaryText = Color(0xFF1F2937);
  static const Color lightText = Color(0xFF1F2937);
  static const Color lightSecondaryText = Color(0xFF6B7280);
  static const Color lightDivider = Color(0xFFE5E7EB);

  // Dark Theme Colors
  static const Color darkBackground = Color(0xFF0F0F0F);
  static const Color darkSurface = Color(0xFF1A1A1A);
  static const Color darkCardBg = Color(0xFF262626);
  static const Color darkPrimaryText = Color(0xFFF9FAFB);
  static const Color darkText = Color(0xFFF9FAFB);
  static const Color darkSecondaryText = Color(0xFF9CA3AF);
  static const Color darkDivider = Color(0xFF374151);

  // Glassmorphism Colors
  static const Color glassLight = Color(0x0DFFFFFF);
  static const Color glassDark = Color(0x0DFFFFFF);

  // Semantic Colors
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // Neutral Colors
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color transparent = Colors.transparent;

  // Shimmer Colors
  static const Color shimmerBase = Color(0xFFE5E7EB);
  static const Color shimmerHighlight = Color(0xFFF3F4F6);
  static const Color shimmerBaseDark = Color(0xFF374151);
  static const Color shimmerHighlightDark = Color(0xFF4B5563);
}

class AppGradients {
  static const BoxDecoration glassmorphismLight = BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Color(0x1AFFFFFF),
        Color(0x0DFFFFFF),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.all(Radius.circular(16)),
    border: Border.fromBorderSide(
      BorderSide(color: Color(0x1AFFFFFF), width: 1),
    ),
  );

  static const BoxDecoration glassmorphismDark = BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Color(0x1AFFFFFF),
        Color(0x0DFFFFFF),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.all(Radius.circular(16)),
    border: Border.fromBorderSide(
      BorderSide(color: Color(0x1AFFFFFF), width: 1),
    ),
  );

  static BoxDecoration neonGlow({required Color color}) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: color.withOpacity(0.3),
          blurRadius: 20,
          spreadRadius: 2,
        ),
        BoxShadow(
          color: color.withOpacity(0.1),
          blurRadius: 40,
          spreadRadius: 4,
        ),
      ],
    );
  }
}
