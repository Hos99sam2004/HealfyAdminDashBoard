import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hossam_templete_for_apps/Core/Routes/Routes.dart';
import 'package:hossam_templete_for_apps/Feature/Auth/Ui/MainWidgets/Login.dart';
import 'package:hossam_templete_for_apps/Feature/Onbording/Onboarding.dart';
import 'package:hossam_templete_for_apps/Feature/SplashScreens/Splash.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: Routes.splash,
      name: 'Splash',
      builder: (BuildContext context, GoRouterState state) {
        return const SplashScreen();
      },
    ),
    GoRoute(
      path: Routes.onboarding,
      name: 'Onboarding',
      builder: (BuildContext context, GoRouterState state) {
        return Onboarding();
      },
    ),
    GoRoute(
      path: Routes.login,
      name: 'Login',
      builder: (BuildContext context, GoRouterState state) {
        return Login();
      },
    ),
   
  ],
);
