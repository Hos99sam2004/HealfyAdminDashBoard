import 'package:animate_do/animate_do.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hossam_templete_for_apps/Feature/Auth/Logic/cubit/auth_cubit.dart';
import 'package:hossam_templete_for_apps/Core/Services/Prefs.dart';
import 'package:hossam_templete_for_apps/Core/Services/service_locator.dart';
import 'package:hossam_templete_for_apps/Core/utils/CustomWidgets/SnakeBar.dart';
import 'package:hossam_templete_for_apps/Core/utils/CustomWidgets/inputField.dart';
import 'package:hossam_templete_for_apps/Feature/Auth/Logic/models/LoginRequestModel.dart';
import 'package:hossam_templete_for_apps/Feature/Auth/Ui/MainWidgets/SignUp.dart';
import 'package:hossam_templete_for_apps/generated/l10n.dart';

class LoginCard extends StatelessWidget {
  const LoginCard({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    return Form(
      key: cubit.loginFormKey,
      autovalidateMode: cubit.autovalidateMode,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 4, 0, 249).withOpacity(0.5),
              const Color.fromARGB(255, 10, 215, 246).withOpacity(0.6),
              const Color.fromARGB(255, 148, 24, 236).withOpacity(0.4),
            ],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            children: [
              FadeInLeft(
                delay: Duration(milliseconds: 400),
                child: InputField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return S.of(context).emailRequired;
                    }
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
              SizedBox(height: 16.h),
              FadeInRight(
                delay: Duration(milliseconds: 800),
                child: InputField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return S.of(context).passwordRequired;
                    }
                    if (value.length < 8) {
                      return S.of(context).passwordTooShort;
                    }
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
              SizedBox(height: 8.h),
              GestureDetector(
                onTap: () {
                  // UrlLauncherService.openUrl(
                  //   context,
                  //   // "https://student-attendane-app-api.vercel.app/api/v1/password/forgot-password/",
                  //   EndPoints.forGetPassword,
                  // );
                },
                child: FadeInUp(
                  delay: Duration(milliseconds: 1000),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      S.of(context).forgotPassword,
                      style: TextStyle(fontSize: 14.sp, color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is AuthLoginLoading) {}

                  if (state is AuthLoginFailure) {
                    showSnackBar(
                      context,
                      state.errMessage,
                      color: Colors.red[400]!,
                    );
                  }
                  if (state is AuthLoginSuccess) {
                    showSnackBar(
                      context,
                      S.of(context).loginSuccessful,
                      color: Colors.green[400]!,
                    );
                    final data = state.loginResponseModels;
                    sl<Prefs>().setString(
                      "auth_token",
                      (data.token).toString(),
                    );
                   
                  }
                },
                builder: (context, state) {
                  if (state is AuthLoginLoading) {
                    return SizedBox(
                      height: 48.h,
                      width: 300.w,
                      child: const Center(child: CircularProgressIndicator()),
                    );
                  }
                  return FadeInDown(
                    delay: Duration(milliseconds: 1200),
                    child: GestureDetector(
                      onTap: () {
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
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 4.w),
                        alignment: Alignment.center,
                        height: 48.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(16.r),
                          gradient: LinearGradient(
                            colors: [
                              const Color(0xFF9418EC).withOpacity(0.4),
                              // const Color(0xFF0AD7F6).withOpacity(0.6),
                              const Color(0xFF0400F9).withOpacity(0.5),
                            ],
                          ),
                        ),
                        child: Text(
                          S.of(context).loginButton,
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 12.h),
              BounceInUp(
                delay: Duration(milliseconds: 1600),
                child: Text.rich(
                  TextSpan(
                    text: S.of(context).noAccount + " ",
                    style: TextStyle(fontSize: 14.sp, color: Colors.black),
                    children: [
                      TextSpan(
                        text: S.of(context).signUp,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => SignUp()),
                            );
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
