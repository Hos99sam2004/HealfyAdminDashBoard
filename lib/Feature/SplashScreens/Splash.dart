import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hossam_templete_for_apps/Core/Routes/Routes.dart';
import 'package:hossam_templete_for_apps/Core/Services/Prefs.dart';
import 'package:hossam_templete_for_apps/Core/Services/service_locator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 5), () {
      if (!mounted) return;
      handleNavigation();
    });
  }

  void handleNavigation() {
    final token = sl<Prefs>().getString("auth_token");
    final userRole = sl<Prefs>().getString("user_role");
    final teacherStatus = sl<Prefs>().getString("teacherStatus");
    final isShowOnboarding = sl<Prefs>().getBool("showOnboarding");

    if (!mounted) return;

    log("Token: $token, User Role: $userRole, Teacher Status: $teacherStatus");

    if (token != null && token.isNotEmpty) {
      if (userRole == "Student") {
        // context.go(Routes.studentHome);
      } else if (userRole == "Teacher" && teacherStatus == "Approved") {
        // context.pushReplacement(Routes.teacherHome);
      } else {
        // context.go(Routes.verifyTeacher);
      }
    } else {
      if (isShowOnboarding != true) {
        context.go(Routes.onboarding);
      } else {
        context.go(Routes.login);
      }
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
            colors: [
              Color.fromARGB(255, 42, 143, 245),
              Color(0xFF89BDF0),
              Color.fromARGB(255, 159, 189, 218),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(child: Image.asset('assets/images/logo.png')),
      ),
    );
  }
}
