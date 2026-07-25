import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hossam_templete_for_apps/Core/Services/Prefs.dart';
import 'package:hossam_templete_for_apps/Core/Services/service_locator.dart';
import 'package:hossam_templete_for_apps/Core/utils/Style/AppColors.dart';
part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitial()) {
    locale = Locale(sl<Prefs>().getString('language_code') ?? 'en');
    themeMode = sl<Prefs>().getBool('is_dark_mode')
        ? ThemeMode.dark
        : ThemeMode.light;
    appColorName = sl<Prefs>().getString('app_color') ?? 'blue';
    appColor = _getColorFromName(appColorName);
  }

  Locale locale = const Locale('en');
  ThemeMode themeMode = ThemeMode.light;
  String appColorName = 'blue';
  Color appColor = ModernClinicalColors.primary;

  ThemeData get currentThemeData => ModernClinicalTheme.getThemeData(
    brightness: themeMode == ThemeMode.dark
        ? Brightness.dark
        : Brightness.light,
    primaryColor: appColor,
  );

  Future<void> changeLanguage(String languageCode) async {
    await sl<Prefs>().setString('language_code', languageCode);

    locale = Locale(languageCode);
    emit(ChangeLanguageState());
  }

  Future<void> toggleThemeMode(bool isDarkMode) async {
    await sl<Prefs>().setBool('is_dark_mode', isDarkMode);

    themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    emit(ChangeThemeState());
  }

  Future<void> changeAppColor(String newColorName) async {
    await sl<Prefs>().setString('app_color', newColorName);

    appColorName = newColorName;
    appColor = _getColorFromName(newColorName);
    emit(ChangeThemeState());
  }

  Color _getColorFromName(String colorName) {
    switch (colorName.toLowerCase()) {
      case 'green':
        return HealingWellnessColors.primary;
      case 'purple':
        return const Color(0xFF6C5CE7);
      case 'orange':
        return const Color(0xFFF59E0B);
      case 'red':
        return Colors.red;
      case 'blue':
      default:
        return ModernClinicalColors.primary;
    }
  }
}

// Hossam@gmail.com
// @Hossam99
