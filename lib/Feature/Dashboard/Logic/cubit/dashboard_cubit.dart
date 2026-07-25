import 'package:bloc/bloc.dart';
import 'package:hossam_templete_for_apps/Feature/Dashboard/Logic/models/dashboard_model.dart';
import 'package:hossam_templete_for_apps/Feature/Dashboard/Logic/repo/repo.dart';
part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final DashboardRepo repo;

  DashboardCubit(this.repo) : super(DashboardInitial());

  Future<void> loadDashboard() async {
    emit(DashboardLoading());
    final result = await repo.fetchDashboardData();
    result.fold(
      (failure) => emit(DashboardError(message: failure.errMessage)),
      (dashboard) => emit(DashboardLoaded(dashboard: dashboard)),
    );
  }
}
