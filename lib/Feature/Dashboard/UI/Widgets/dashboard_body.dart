import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hossam_templete_for_apps/Feature/Dashboard/Logic/cubit/dashboard_cubit.dart';
import 'package:hossam_templete_for_apps/Feature/Dashboard/UI/Widgets/dashboard_cards.dart';
import 'package:hossam_templete_for_apps/Feature/Dashboard/UI/Widgets/dashboard_empty_state.dart';
import 'package:hossam_templete_for_apps/Feature/Dashboard/UI/Widgets/dashboard_error_state.dart';
import 'package:hossam_templete_for_apps/Feature/Dashboard/UI/Widgets/dashboard_loading_state.dart';

class DashboardBody extends StatefulWidget {
  const DashboardBody({super.key});

  @override
  State<DashboardBody> createState() => _DashboardBodyState();
}

class _DashboardBodyState extends State<DashboardBody> {
  @override
  void initState() {
    super.initState();
    context.read<DashboardCubit>().loadDashboard();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        if (state is DashboardLoading) {
          return const DashboardLoadingState();
        }
        if (state is DashboardError) {
          return DashboardErrorState(message: state.message);
        }
        if (state is DashboardLoaded) {
          return DashboardCards(dashboard: state.dashboard);
        }
        return const DashboardEmptyState();
      },
    );
  }
}
