import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hossam_templete_for_apps/Core/Services/service_locator.dart';
import 'package:hossam_templete_for_apps/Core/responsive/responsive_layout.dart';
import 'package:hossam_templete_for_apps/Feature/Auth/Logic/cubit/auth_cubit.dart'
    show AuthCubit;
import 'package:hossam_templete_for_apps/Feature/Auth/Ui/Widgets/Headers.dart';
import 'package:hossam_templete_for_apps/Feature/Auth/Ui/Widgets/SignUpCard.dart';
import 'package:hossam_templete_for_apps/Core/widgets/logo_widget.dart';
import 'package:hossam_templete_for_apps/theme/app_spacing.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: BlocProvider(
        create: (context) => sl<AuthCubit>(),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: colorScheme.surface,
            gradient: LinearGradient(
              colors: [
                colorScheme.primary.withOpacity(0.20),
                colorScheme.secondaryContainer.withOpacity(0.60),
                colorScheme.tertiaryContainer.withOpacity(0.35),
              ],
            ),
          ),
          child: ResponsiveLayout(
            desktop: const _DesktopSignUp(),
            tablet: const _MobileSignUp(),
            mobile: const _MobileSignUp(),
          ),
        ),
      ),
    );
  }
}

class _DesktopSignUp extends StatelessWidget {
  const _DesktopSignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(AppSpacing.xl),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  colorScheme.primary.withOpacity(0.85),
                  colorScheme.secondaryContainer.withOpacity(0.90),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Logo(
                  width: 250.w,
                  height: 350.h,
                  fit: BoxFit.cover,
                  size: 80,
                  // color: Colors.white,
                ),
                SizedBox(height: 24.h),
                Text(
                  'Create your admin account',
                  style: TextStyle(
                    color: colorScheme.onPrimary,
                    fontSize: 32.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  'Register once and manage appointments, doctors, patients, and settings from a single dashboard.',
                  style: TextStyle(
                    color: colorScheme.onPrimary.withOpacity(0.90),
                    fontSize: 16.sp,
                    height: 1.6,
                  ),
                ),
                SizedBox(height: 32.h),
                Container(
                  width: 160.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(999),
                    color: colorScheme.onPrimary.withOpacity(0.65),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.xl,
                vertical: AppSpacing.xxl,
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 520),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    FadeInDown(
                      delay: const Duration(milliseconds: 300),
                      child: const Header(),
                    ),
                    SizedBox(height: 24.h),
                    SignUpCard(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _MobileSignUp extends StatelessWidget {
  const _MobileSignUp({Key? key}) : super(key: key);

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
              tablet: 520.0,
              desktop: 520.0,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FadeInDown(
                delay: const Duration(milliseconds: 300),
                child: const Header(),
              ),
              SizedBox(height: 24.h),
              SignUpCard(),
            ],
          ),
        ),
      ),
    );
  }
}
