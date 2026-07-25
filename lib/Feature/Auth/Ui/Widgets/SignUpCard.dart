import 'package:animate_do/animate_do.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hossam_templete_for_apps/Core/utils/CustomWidgets/SnakeBar.dart';
import 'package:hossam_templete_for_apps/Core/utils/CustomWidgets/inputField.dart';
import 'package:hossam_templete_for_apps/Feature/Auth/Logic/cubit/auth_cubit.dart';
import 'package:hossam_templete_for_apps/Feature/Auth/Logic/models/RegisterRequestModel.dart';
import 'package:hossam_templete_for_apps/Feature/Auth/Ui/MainWidgets/Login.dart';
import 'package:hossam_templete_for_apps/generated/l10n.dart';

class SignUpCard extends StatelessWidget {
  SignUpCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    return Container(
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
        child: Form(
          autovalidateMode: cubit.autovalidateMode,
          key: cubit.registerFormKey,
          child: Column(
            children: [
              FadeInLeft(
                delay: Duration(milliseconds: 300),
                child: InputField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return S.of(context).fullNameRequired;
                    }
                    return null;
                  },
                  mycontroller: cubit.nameController,
                  label: S.of(context).fullNameLabel,
                  icon: Icons.person_outline,
                ),
              ),
              SizedBox(height: 16.h),
              FadeInLeft(
                delay: Duration(milliseconds: 700),

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
                  mycontroller: cubit.emailController,
                  label: S.of(context).emailAddressLabel,
                  icon: Icons.email_outlined,
                  isEmail: true,
                ),
              ),
              SizedBox(height: 16.h),
              FadeInLeft(
                delay: Duration(milliseconds: 1100),
                child: InputField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return S.of(context).passwordRequired;
                    }
                    if (value.length < 8) {
                      return S.of(context).passwordTooShortSignUp;
                    }
                    if (!value.contains(RegExp(r'[A-Z]'))) {
                      return S.of(context).passwordUppercaseRequired;
                    }
                    if (!value.contains(RegExp(r'[@#$%^&!*()]'))) {
                      return S.of(context).passwordSpecialCharRequired;
                    }

                    return null;
                  },

                  mycontroller: cubit.passwordController,
                  label: S.of(context).passwordLabel,
                  icon: Icons.lock_outline,
                  isPassword: true,
                ),
              ),
              SizedBox(height: 16.h),
              FadeInLeft(
                delay: Duration(milliseconds: 1500),
                child: InputField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return S.of(context).phoneRequired;
                    }
                    if (value.length != 11) {
                      return S.of(context).phoneLengthInvalid;
                    }
                    if (!RegExp(r'^\+?[0-9]{7,15}$').hasMatch(value)) {
                      return S.of(context).phoneInvalid;
                    }
                    return null;
                  },
                  mycontroller: cubit.phoneController,
                  label: S.of(context).phoneNumberLabel,
                  icon: Icons.phone_outlined,
                  isPassword: false,
                  isPhone: true,
                ),
              ),
              SizedBox(height: 16.h),
              FadeInLeft(
                delay: Duration(milliseconds: 1900),
                child: DropdownButtonFormField(
                  initialValue: cubit.selectedRole,
                  items: [
                    DropdownMenuItem(
                      value: "Student",
                      child: Text(S.of(context).roleStudent),
                    ),
                    DropdownMenuItem(
                      value: "Teacher",
                      child: Text(S.of(context).roleTeacher),
                    ),
                  ],
                  dropdownColor: Colors.indigo,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  focusColor: Colors.transparent,
                  autofocus: true,
                  onChanged: (value) {
                    if (value != null) {
                      cubit.changeSelectedRole(value);
                    }
                  },
                  decoration: InputDecoration(
                    hintText: S.of(context).selectRoleHint,
                    prefixIcon: Icon(Icons.person_outline),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is AuthRegisterLoading) {
                    CircularProgressIndicator();
                  }

                  if (state is AuthRegisterFailure) {
                    showSnackBar(
                      context,
                      state.errMessage,
                      color: Colors.red[400]!,
                    );
                  }
                  if (state is AuthRegisterSuccess) {
                    final data = state.registerResponseModels;

                    ScaffoldMessenger.of(context).showSnackBar(
                      snackBarAnimationStyle: AnimationStyle(
                        curve: ElasticInOutCurve(),
                        duration: const Duration(seconds: 2),
                      ),
                      SnackBar(
                        content: Text(data.message.toString()),
                        backgroundColor: Colors.green[400]!,
                      ),
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is AuthRegisterLoading) {
                    return const CircularProgressIndicator();
                  }
                  return InkWell(
                    onTap: () {
                      if (cubit.registerFormKey.currentState!.validate()) {
                        cubit.registerUser(
                          registerRequestModels: RegisterRequestModels(
                            name: cubit.nameController.text,
                            email: cubit.emailController.text,
                            password: cubit.passwordController.text,
                            phone: cubit.phoneController.text,
                            role: cubit.selectedRole,
                          ),
                        );
                      } else {
                        cubit.changeAutoValidateMode();
                      }
                    },
                    child: FadeInLeft(
                      delay: Duration(milliseconds: 1900),
                      child: Container(
                        width: double.infinity,
                        height: 48.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          gradient: LinearGradient(
                            colors: [
                              const Color(0xFF9418EC).withOpacity(0.4),
                              // const Color(0xFF0AD7F6).withOpacity(0.6),
                              const Color(0xFF0400F9).withOpacity(0.5),
                            ],
                          ),
                        ),
                        child: Text(
                          S.of(context).createAccount,
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 16.h),
              BounceInUp(
                delay: Duration(milliseconds: 2200),
                child: Text.rich(
                  TextSpan(
                    text: S.of(context).alreadyHaveAccount + " ",
                    style: TextStyle(fontSize: 14.sp, color: Colors.black),
                    children: [
                      TextSpan(
                        text: S.of(context).signIn,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => Login()),
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
