import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hossam_templete_for_apps/Core/Services/service_locator.dart';
import 'package:hossam_templete_for_apps/Feature/Auth/Logic/cubit/auth_cubit.dart' show AuthCubit;
import 'package:hossam_templete_for_apps/Feature/Auth/Ui/Widgets/Headers.dart';
import 'package:hossam_templete_for_apps/Feature/Auth/Ui/Widgets/SignUpCard.dart';
class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F9FC),
      body: BlocProvider(
        create: (context) => sl<AuthCubit>(),
        child: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            gradient: LinearGradient(
              colors: [
                const Color.fromARGB(255, 4, 0, 249).withOpacity(0.5),
                const Color.fromARGB(255, 10, 215, 246).withOpacity(0.6),
                const Color.fromARGB(255, 148, 24, 236).withOpacity(0.4),
              ],
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Column(
                children: [
                  FadeInDown(
                    delay: Duration(milliseconds: 300),
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
    );
  }
}
