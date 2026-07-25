import 'package:flutter/material.dart';

abstract class ModernClinicalColors {
  static const Color primary = Color(0xFF1A56DB); // أزرق ملكي
  static const Color secondary = Color(0xFF0EA5E9); // تركواز هادئ
  static const Color background = Color(0xFFF8FAFC); // رمادي فاتح جداً
  static const Color surface = Colors.white; // أبيض للبطاقات Cards
  static const Color textPrimary = Color(0xFF0F172A); // رمادي غامق للنصوص
  static const Color textSecondary = Color(0xFF64748B); // رمادي متوسط
  static const Color success = Color(0xFF10B981); // أخضر للحجوزات المؤكدة
  static const Color error = Color(0xFFEF4444); // أحمر للأخطاء/الإلغاء
}

class ModernClinicalTheme {
  static ThemeData get themeData => getThemeData(
    brightness: Brightness.light,
    primaryColor: ModernClinicalColors.primary,
  );

  static ThemeData getThemeData({
    required Brightness brightness,
    required Color primaryColor,
  }) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: brightness,
    );

    final isDark = brightness == Brightness.dark;

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      scaffoldBackgroundColor: isDark
          ? colorScheme.surface
          : ModernClinicalColors.background,
      colorScheme: colorScheme,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(color: colorScheme.onSurface),
        titleTextStyle: TextStyle(
          color: colorScheme.onSurface,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

abstract class HealingWellnessColors {
  static const Color primary = Color(0xFF047857); // أخضر زمردي
  static const Color secondary = Color(0xFF34D399); // نعناعي هادئ
  static const Color background = Color(0xFFF9FAFB); // خلفية عاجية فاتحة
  static const Color surface = Colors.white;
  static const Color textPrimary = Color(0xFF064E3B); // أخضر داكن مائل للسواد
  static const Color textSecondary = Color(0xFF4B5563);
  static const Color success = Color(0xFF059669);
  static const Color error = Color(0xFFDC2626);
}

class HealingWellnessTheme {
  static ThemeData get themeData {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: HealingWellnessColors.background,
      colorScheme: const ColorScheme.light(
        primary: HealingWellnessColors.primary,
        secondary: HealingWellnessColors.secondary,
        surface: HealingWellnessColors.surface,
        error: HealingWellnessColors.error,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: HealingWellnessColors.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(color: HealingWellnessColors.textPrimary),
        titleTextStyle: TextStyle(
          color: HealingWellnessColors.textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: HealingWellnessColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
