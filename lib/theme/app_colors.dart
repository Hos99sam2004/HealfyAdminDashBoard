// lib/theme/app_colors.dart

import 'package:flutter/material.dart';

/// Centralized color palette matching the Figma design for the admin dashboard.
class AppColors {
  // Primary brand color
  static const Color primary = Color(0xFF1A56DB);
  // Secondary accent color
  static const Color secondary = Color(0xFF0EA5E9);
  // Background for the whole app (light mode)
  static const Color background = Color(0xFFF8FAFC);
  // Surface color for cards, sheets, etc.
  static const Color surface = Colors.white;
  // Text colors
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF64748B);
  // Success / error cues
  static const Color success = Color(0xFF10B981);
  static const Color error = Color(0xFFEF4444);

  // Additional shades for dark mode (optional)
  static const Color darkBackground = Color(0xFF1E293B);
  static const Color darkSurface = Color(0xFF334155);
}
