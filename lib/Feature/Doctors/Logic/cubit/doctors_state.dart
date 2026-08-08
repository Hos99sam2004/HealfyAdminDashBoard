part of 'doctors_cubit.dart';

sealed class DoctorsState {}

final class DoctorsInitial extends DoctorsState {}

final class BulkApprovedLoading extends DoctorsState {
  final DoctorsOverviewModel overview;
  final DoctorDetailsModel? selectedDoctor;

  BulkApprovedLoading({required this.overview, this.selectedDoctor});
}

final class BulkApprovedError extends DoctorsState {
  final String message;
  final DoctorsOverviewModel overview;
  final DoctorDetailsModel? selectedDoctor;

  BulkApprovedError({
    required this.message,
    required this.overview,
    this.selectedDoctor,
  });
}

final class BulkApprovedSuccess extends DoctorsState {
  final DoctorsOverviewModel overview;
  final DoctorDetailsModel? selectedDoctor;

  BulkApprovedSuccess({required this.overview, this.selectedDoctor});
}

final class BulkRejectedLoading extends DoctorsState {
  final DoctorsOverviewModel overview;
  final DoctorDetailsModel? selectedDoctor;

  BulkRejectedLoading({required this.overview, this.selectedDoctor});
}

final class BulkRejectedError extends DoctorsState {
  final String message;
  final DoctorsOverviewModel overview;
  final DoctorDetailsModel? selectedDoctor;

  BulkRejectedError({
    required this.message,
    required this.overview,
    this.selectedDoctor,
  });
}

final class BulkRejectedSuccess extends DoctorsState {
  final DoctorsOverviewModel overview;
  final DoctorDetailsModel? selectedDoctor;

  BulkRejectedSuccess({required this.overview, this.selectedDoctor});
}

final class DoctorsLoading extends DoctorsState {}

final class DoctorsLoaded extends DoctorsState {
  final DoctorsOverviewModel overview;
  final DoctorDetailsModel? selectedDoctor;

  DoctorsLoaded({required this.overview, this.selectedDoctor});
}

final class DoctorsDetailLoading extends DoctorsState {
  final DoctorsOverviewModel overview;
  final DoctorDetailsModel? selectedDoctor;

  DoctorsDetailLoading({required this.overview, this.selectedDoctor});
}

final class DoctorsError extends DoctorsState {
  final String message;

  DoctorsError({required this.message});
}

final class DoctorsDetailError extends DoctorsState {
  final DoctorsOverviewModel overview;
  final DoctorDetailsModel? selectedDoctor;
  final String message;

  DoctorsDetailError({
    required this.overview,
    this.selectedDoctor,
    required this.message,
  });
}
