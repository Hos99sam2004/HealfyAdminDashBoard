// lib/theme/app_typography.dart

import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Typography that scales with screen width.
///
/// Use [AppTypography.scaled] to get a [TextTheme] adapted to the
/// current screen width rather than fixed pixel sizes.
class AppTypography {
  const AppTypography._();

  // ── Base font sizes (design canvas = 1440 px wide) ─────────────────────
  static const double _baseHeadlineLarge = 28;
  static const double _baseHeadlineMedium = 22;
  static const double _baseTitleLarge = 18;
  static const double _baseTitleMedium = 16;
  static const double _baseBodyLarge = 15;
  static const double _baseBodyMedium = 14;
  static const double _baseLabelLarge = 13;
  static const double _baseLabelSmall = 11;

  /// Returns a scale factor in [0.80, 1.0] based on screen width.
  static double _scale(double screenWidth) {
    if (screenWidth >= 1200) return 1.0;
    if (screenWidth >= 768) return 0.92;
    return 0.84;
  }

  /// Static [TextTheme] used for the Material theme (uses base sizes).
  static const TextTheme textTheme = TextTheme(
    headlineLarge: TextStyle(
      fontSize: _baseHeadlineLarge,
      fontWeight: FontWeight.bold,
      color: AppColors.textPrimary,
    ),
    headlineMedium: TextStyle(
      fontSize: _baseHeadlineMedium,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
    ),
    titleLarge: TextStyle(
      fontSize: _baseTitleLarge,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
    ),
    titleMedium: TextStyle(
      fontSize: _baseTitleMedium,
      fontWeight: FontWeight.w500,
      color: AppColors.textPrimary,
    ),
    bodyLarge: TextStyle(
      fontSize: _baseBodyLarge,
      color: AppColors.textPrimary,
    ),
    bodyMedium: TextStyle(
      fontSize: _baseBodyMedium,
      color: AppColors.textSecondary,
    ),
    labelLarge: TextStyle(
      fontSize: _baseLabelLarge,
      fontWeight: FontWeight.w500,
      color: AppColors.textSecondary,
    ),
    labelSmall: TextStyle(
      fontSize: _baseLabelSmall,
      color: AppColors.textSecondary,
    ),
  );

  /// Returns a [TextTheme] where every font size is scaled to [screenWidth].
  static TextTheme scaled(double screenWidth) {
    final s = _scale(screenWidth);
    return TextTheme(
      headlineLarge: TextStyle(
        fontSize: _baseHeadlineLarge * s,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
      headlineMedium: TextStyle(
        fontSize: _baseHeadlineMedium * s,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      titleLarge: TextStyle(
        fontSize: _baseTitleLarge * s,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      titleMedium: TextStyle(
        fontSize: _baseTitleMedium * s,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
      ),
      bodyLarge: TextStyle(
        fontSize: _baseBodyLarge * s,
        color: AppColors.textPrimary,
      ),
      bodyMedium: TextStyle(
        fontSize: _baseBodyMedium * s,
        color: AppColors.textSecondary,
      ),
      labelLarge: TextStyle(
        fontSize: _baseLabelLarge * s,
        fontWeight: FontWeight.w500,
        color: AppColors.textSecondary,
      ),
      labelSmall: TextStyle(
        fontSize: _baseLabelSmall * s,
        color: AppColors.textSecondary,
      ),
    );
  }
}
