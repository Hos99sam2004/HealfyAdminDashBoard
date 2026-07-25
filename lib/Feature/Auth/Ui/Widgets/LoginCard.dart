// lib/Feature/Auth/Ui/Widgets/LoginCard.dart

import 'package:animate_do/animate_do.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hossam_templete_for_apps/Core/Routes/Routes.dart' show Routes;
import 'package:hossam_templete_for_apps/Feature/Auth/Logic/cubit/auth_cubit.dart';
import 'package:hossam_templete_for_apps/Core/Services/Prefs.dart';
import 'package:hossam_templete_for_apps/Core/Services/service_locator.dart';
import 'package:hossam_templete_for_apps/Core/utils/CustomWidgets/SnakeBar.dart';
import 'package:hossam_templete_for_apps/Core/utils/CustomWidgets/inputField.dart';
import 'package:hossam_templete_for_apps/Feature/Auth/Logic/models/LoginRequestModel.dart';
import 'package:hossam_templete_for_apps/Feature/Auth/Ui/MainWidgets/SignUp.dart';
import 'package:hossam_templete_for_apps/generated/l10n.dart';
import 'package:hossam_templete_for_apps/theme/app_colors.dart';
import 'package:hossam_templete_for_apps/theme/app_spacing.dart';

class LoginCard extends StatelessWidget {
  const LoginCard({super.key, required this.cubit});

  final AuthCubit cubit;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Form(
      key: cubit.loginFormKey,
      autovalidateMode: cubit.autovalidateMode,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.07),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        padding: AppSpacing.cardPadding(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Title
            FadeInDown(
              child: Text(
                S.of(context).loginButton,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 4),
            FadeInDown(
              delay: const Duration(milliseconds: 100),
              child: Text(
                'Welcome back! Sign in to continue.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            SizedBox(height: AppSpacing.lg),

            // Email
            FadeInLeft(
              delay: const Duration(milliseconds: 200),
              child: InputField(
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return S.of(context).emailRequired;
                  if (!RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  ).hasMatch(value)) {
                    return S.of(context).emailInvalid;
                  }
                  return null;
                },
                hint: S.of(context).emailHint,
                mycontroller: cubit.emailController,
                label: S.of(context).emailLabel,
                icon: Icons.email_outlined,
                isEmail: true,
              ),
            ),
            SizedBox(height: AppSpacing.md),

            // Password
            FadeInRight(
              delay: const Duration(milliseconds: 300),
              child: InputField(
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return S.of(context).passwordRequired;
                  if (value.length < 8) return S.of(context).passwordTooShort;
                  return null;
                },
                hint: S.of(context).passwordHint,
                mycontroller: cubit.passwordController,
                label: S.of(context).passwordLabel,
                icon: Icons.lock_outline,
                isPassword: true,
                isObscure: true,
              ),
            ),
            const SizedBox(height: 8),

            // Forgot password
            FadeInUp(
              delay: const Duration(milliseconds: 400),
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    S.of(context).forgotPassword,
                    style: TextStyle(color: colorScheme.primary, fontSize: 13),
                  ),
                ),
              ),
            ),
            SizedBox(height: AppSpacing.md),

            // Login button
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthLoginFailure) {
                  showSnackBar(
                    context,
                    state.errMessage,
                    color: colorScheme.error,
                  );
                }
                if (state is AuthLoginSuccess) {
                  showSnackBar(
                    context,
                    S.of(context).loginSuccessful,
                    color: colorScheme.primary,
                  );
                  final data = state.loginResponseModels;
                  sl<Prefs>().setString(
                    'auth_token',
                    data.session!.accessToken,
                  );
                  cubit.supabase
                      .from('profiles')
                      .select()
                      .eq('id', data.session!.user.id)
                      .single()
                      .then((value) {
                        sl<Prefs>().setBool(
                          'completed_profile',
                          value['profile_completed'],
                        );
                        sl<Prefs>().setString('role', value['role']);
                        context.go(Routes.dashboard);
                      });
                }
              },
              builder: (context, state) {
                if (state is AuthLoginLoading) {
                  return const SizedBox(
                    height: 48,
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                return FadeInDown(
                  delay: const Duration(milliseconds: 500),
                  child: SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        if (cubit.loginFormKey.currentState!.validate()) {
                          cubit.loginUSer(
                            loginRequestModels: LoginRequestModels(
                              email: cubit.emailController.text,
                              password: cubit.passwordController.text,
                            ),
                          );
                        } else {
                          cubit.changeAutoValidateMode();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        S.of(context).loginButton,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: AppSpacing.md),

            // Sign-up link
            BounceInUp(
              delay: const Duration(milliseconds: 700),
              child: Text.rich(
                TextSpan(
                  text: '${S.of(context).noAccount} ',
                  style: TextStyle(fontSize: 13, color: colorScheme.onSurface),
                  children: [
                    TextSpan(
                      text: S.of(context).signUp,
                      style: TextStyle(
                        fontSize: 13,
                        color: colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignUp()),
                          );
                        },
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
