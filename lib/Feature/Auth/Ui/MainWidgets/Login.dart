import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hossam_templete_for_apps/Core/Services/service_locator.dart';
import 'package:hossam_templete_for_apps/Feature/Auth/Logic/cubit/auth_cubit.dart';
import 'package:hossam_templete_for_apps/Feature/Auth/Ui/Widgets/Headers.dart';
import 'package:hossam_templete_for_apps/Feature/Auth/Ui/Widgets/LoginCard.dart';
class Login extends StatelessWidget {
  Login({super.key});

  @override
  Widget build(BuildContext context) {
    // final int index = Index;
    return BlocProvider(
      create: (context) => sl<AuthCubit>(),
      child: Scaffold(
        backgroundColor: const Color(0xffF6F9FC),
        body: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color.fromARGB(255, 42, 143, 245),
                Color(0xFF89BDF0),
                Color.fromARGB(255, 159, 189, 218),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                SizedBox(height: 150.h),
                FadeInDown(
                  delay: Duration(milliseconds: 300),
                  child: const Header(),
                ),
                SizedBox(height: 50.h),
                LoginCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
