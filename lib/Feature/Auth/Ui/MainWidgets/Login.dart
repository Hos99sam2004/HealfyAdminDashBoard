// lib/Feature/Auth/Ui/MainWidgets/Login.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hossam_templete_for_apps/Core/responsive/responsive_layout.dart';
import 'package:hossam_templete_for_apps/Core/Services/service_locator.dart';
import 'package:hossam_templete_for_apps/Feature/Auth/Logic/cubit/auth_cubit.dart';
import 'package:hossam_templete_for_apps/Feature/Auth/Ui/Widgets/LoginCard.dart';
import 'package:hossam_templete_for_apps/theme/app_colors.dart';
import 'package:hossam_templete_for_apps/theme/app_spacing.dart';
import 'package:hossam_templete_for_apps/Core/widgets/logo_widget.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final AuthCubit _cubit = sl<AuthCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        backgroundColor: const Color(0xFFF0F4FF),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFEFF6FF), Color(0xFFDBEAFE), Color(0xFFC7D2FE)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: ResponsiveLayout(
            desktop: _DesktopLogin(cubit: _cubit),
            tablet: _MobileLogin(cubit: _cubit),
            mobile: _MobileLogin(cubit: _cubit),
          ),
        ),
      ),
    );
  }
}

// ── Desktop: two-column (illustration + card) ─────────────────────────────────
class _DesktopLogin extends StatelessWidget {
  final AuthCubit cubit;
  const _DesktopLogin({required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Left: branding / illustration
        Expanded(
          child: Container(
            color: AppColors.success,
            padding: EdgeInsets.all(AppSpacing.xl),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Logo(
                  width: 250.w,
                  height: 350.h,
                  fit: BoxFit.cover,
                  size: 80,
                  color: Colors.white,
                ),
                SizedBox(height: 24),
                // Text(
                //   'Healfy',
                //   style: TextStyle(
                //     color: Colors.white,
                //     fontSize: 40,
                //     fontWeight: FontWeight.bold,
                //     letterSpacing: 1.5,
                //   ),
                // ),
                SizedBox(height: 12),
                Text(
                  'Admin Dashboard',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 32),
                Text(
                  'Manage your clinic, doctors, patients,\nappointments and more — all in one place.',
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 15,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
        ),
        // Right: login card
        Expanded(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.xl,
                  vertical: AppSpacing.xxl,
                ),
                child: LoginCard(cubit: cubit),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ── Mobile / Tablet: centered card ───────────────────────────────────────────
class _MobileLogin extends StatelessWidget {
  final AuthCubit cubit;
  const _MobileLogin({required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.pagePaddingH(context),
          vertical: AppSpacing.xxl,
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: context.responsive(
              mobile: double.infinity,
              tablet: 480.0,
              desktop: 480.0,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Mini branding
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Logo(width: 32, height: 32),
                  const SizedBox(width: 10),
                  const Text(
                    'Healfy Admin',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppSpacing.xl),
              LoginCard(cubit: cubit),
            ],
          ),
        ),
      ),
    );
  }
}
