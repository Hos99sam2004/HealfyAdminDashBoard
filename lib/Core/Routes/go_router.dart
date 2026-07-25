import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:hossam_templete_for_apps/Core/Routes/Routes.dart';
import 'package:hossam_templete_for_apps/Core/Services/Prefs.dart';
import 'package:hossam_templete_for_apps/Core/Services/service_locator.dart';
import 'package:hossam_templete_for_apps/Feature/Auth/Ui/MainWidgets/Login.dart';
import 'package:hossam_templete_for_apps/Feature/Dashboard/Logic/cubit/dashboard_cubit.dart';
import 'package:hossam_templete_for_apps/Feature/Dashboard/UI/Screens/DashboardScreen.dart';
import 'package:hossam_templete_for_apps/Feature/Doctors/Logic/cubit/doctors_cubit.dart';
import 'package:hossam_templete_for_apps/Feature/Doctors/UI/Screens/DoctorsScreen.dart';
import 'package:hossam_templete_for_apps/Feature/Onbording/Onboarding.dart';
import 'package:hossam_templete_for_apps/Feature/SplashScreens/Splash.dart';
import 'package:hossam_templete_for_apps/layout/responsive_scaffold.dart';

/// Placeholder used until the real feature screen is built.
class _PlaceholderScreen extends StatelessWidget {
  final String title;
  const _PlaceholderScreen({required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
      ),
    );
  }
}

// ── Auth guard redirect ───────────────────────────────────────────────────────
String? _authRedirect(BuildContext context, GoRouterState state) {
  final session = Supabase.instance.client.auth.currentSession;
  final publicRoutes = {Routes.splash, Routes.login, Routes.onboarding};
  if (session == null && !publicRoutes.contains(state.uri.toString())) {
    return Routes.login;
  }
  return null;
}

// ── Router ───────────────────────────────────────────────────────────────────
final GoRouter router = GoRouter(
  initialLocation: Routes.splash,
  redirect: _authRedirect,
  routes: <RouteBase>[
    // Public routes (no scaffold)
    GoRoute(
      path: Routes.splash,
      name: 'splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: Routes.onboarding,
      name: 'onboarding',
      builder: (context, state) => const Onboarding(),
    ),
    GoRoute(
      path: Routes.login,
      name: 'login',
      builder: (context, state) => Login(),
    ),

    // Protected routes (wrapped in ResponsiveScaffold)
    ShellRoute(
      builder: (context, state, child) => ResponsiveScaffold(child: child),
      routes: [
        GoRoute(
          path: Routes.dashboard,
          name: 'dashboard',
          builder: (context, state) => BlocProvider(
            create: (_) => sl<DashboardCubit>()..loadDashboard(),
            child: const DashboardScreen(),
          ),
        ),
        GoRoute(
          path: Routes.doctors,
          name: 'doctors',
          builder: (context, state) => BlocProvider(
            create: (_) => sl<DoctorsCubit>()..loadDoctors(),
            child: const DoctorsScreen(),
          ),
        ),
        GoRoute(
          path: Routes.patients,
          name: 'patients',
          builder: (context, state) =>
              const _PlaceholderScreen(title: 'Patients'),
        ),
        GoRoute(
          path: Routes.appointments,
          name: 'appointments',
          builder: (context, state) =>
              const _PlaceholderScreen(title: 'Appointments'),
        ),
        GoRoute(
          path: Routes.payments,
          name: 'payments',
          builder: (context, state) =>
              const _PlaceholderScreen(title: 'Payments'),
        ),
        GoRoute(
          path: Routes.reviews,
          name: 'reviews',
          builder: (context, state) =>
              const _PlaceholderScreen(title: 'Reviews'),
        ),
        GoRoute(
          path: Routes.notifications,
          name: 'notifications',
          builder: (context, state) =>
              const _PlaceholderScreen(title: 'Notifications'),
        ),
        GoRoute(
          path: Routes.reports,
          name: 'reports',
          builder: (context, state) =>
              const _PlaceholderScreen(title: 'Reports'),
        ),
        GoRoute(
          path: Routes.settings,
          name: 'settings',
          builder: (context, state) =>
              const _PlaceholderScreen(title: 'Settings'),
        ),
        GoRoute(
          path: Routes.admins,
          name: 'admins',
          builder: (context, state) =>
              const _PlaceholderScreen(title: 'Admins'),
        ),
        GoRoute(
          path: Routes.profile,
          name: 'profile',
          builder: (context, state) =>
              const _PlaceholderScreen(title: 'Profile'),
        ),
        GoRoute(
          path: Routes.logout,
          name: 'logout',
          builder: (context, state) {
            // Perform logout and redirect to login
            Supabase.instance.client.auth.signOut();
            sl<Prefs>().setString('auth_token', '');
            return Login();
          },
        ),
      ],
    ),
  ],
);
