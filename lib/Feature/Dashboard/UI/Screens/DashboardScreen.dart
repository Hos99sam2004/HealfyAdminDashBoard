import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hossam_templete_for_apps/Feature/Dashboard/Logic/cubit/dashboard_cubit.dart';
import 'package:hossam_templete_for_apps/Feature/Dashboard/UI/Widgets/dashboard_body.dart';
import 'package:hossam_templete_for_apps/theme/app_colors.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: BlocProvider.value(
          value: context.read<DashboardCubit>(),
          child: const DashboardBody(),
        ),
      ),
    );
  }
}
