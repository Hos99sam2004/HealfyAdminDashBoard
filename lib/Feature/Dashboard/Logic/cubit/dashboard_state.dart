part of 'dashboard_cubit.dart';

sealed class DashboardState {}

final class DashboardInitial extends DashboardState {}

final class DashboardLoading extends DashboardState {}

final class DashboardLoaded extends DashboardState {
  final DashboardModel dashboard;
  DashboardLoaded({required this.dashboard});
}

final class DashboardError extends DashboardState {
  final String message;
  DashboardError({required this.message});
}
