// lib/Feature/SplashScreens/Splash.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hossam_templete_for_apps/Core/responsive/responsive_layout.dart';
import 'package:hossam_templete_for_apps/Core/Routes/Routes.dart';
import 'package:hossam_templete_for_apps/Core/Services/Prefs.dart';
import 'package:hossam_templete_for_apps/Core/Services/service_locator.dart';
import 'package:hossam_templete_for_apps/theme/app_colors.dart';
import 'package:hossam_templete_for_apps/Core/widgets/logo_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _fadeAnim = CurvedAnimation(parent: _ctrl, curve: Curves.easeIn);
    _ctrl.forward();

    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      _handleNavigation();
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _handleNavigation() {
    final token = sl<Prefs>().getString("auth_token");
    final isShowOnboarding = sl<Prefs>().getBool("showOnboarding");

    if (!mounted) return;

    if (isShowOnboarding != true) {
      context.go(Routes.onboarding);
    } else if (token == null) {
      context.go(Routes.login);
    } else {
      context.go(Routes.dashboard);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFEFF6FF), Color(0xFFDBEAFE), Color(0xFFBFDBFE)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: FadeTransition(
          opacity: _fadeAnim,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Container(
                width: context.responsive(
                  mobile: 80.0,
                  tablet: 100.0,
                  desktop: 120.0,
                ),
                height: context.responsive(
                  mobile: 80.0,
                  tablet: 100.0,
                  desktop: 120.0,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.15),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Center(
                    child: Logo(
                      size: context.responsive(
                        mobile: 56.0,
                        tablet: 80.0,
                        desktop: 96.0,
                      ),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Healfy',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: context.responsive(
                    mobile: 28.0,
                    tablet: 34.0,
                    desktop: 40.0,
                  ),
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Admin Dashboard',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: context.responsive(
                    mobile: 13.0,
                    tablet: 15.0,
                    desktop: 16.0,
                  ),
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 48),
              SizedBox(
                width: 28,
                height: 28,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
