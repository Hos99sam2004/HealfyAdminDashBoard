import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:hossam_templete_for_apps/Feature/Doctors/Logic/models/doctor_details_model.dart';
import 'package:hossam_templete_for_apps/Feature/Doctors/Logic/models/doctors_overview_model.dart';
import 'package:hossam_templete_for_apps/Feature/Doctors/Logic/repo/repo.dart';

part 'doctors_state.dart';

class DoctorsCubit extends Cubit<DoctorsState> {
  final DoctorRepo repo;
  bool _actionInProgress = false;

  DoctorsCubit(this.repo) : super(DoctorsInitial());

  DoctorsOverviewModel? _currentOverview() {
    final current = state;
    if (current is DoctorsLoaded) return current.overview;
    if (current is DoctorsDetailLoading) return current.overview;
    if (current is DoctorsDetailError) return current.overview;
    if (current is BulkApprovedLoading) return current.overview;
    if (current is BulkApprovedError) return current.overview;
    if (current is BulkApprovedSuccess) return current.overview;
    if (current is BulkRejectedLoading) return current.overview;
    if (current is BulkRejectedError) return current.overview;
    if (current is BulkRejectedSuccess) return current.overview;
    return null;
  }

  DoctorDetailsModel? _currentSelected() {
    final current = state;
    if (current is DoctorsLoaded) return current.selectedDoctor;
    if (current is DoctorsDetailLoading) return current.selectedDoctor;
    if (current is DoctorsDetailError) return current.selectedDoctor;
    if (current is BulkApprovedLoading) return current.selectedDoctor;
    if (current is BulkApprovedError) return current.selectedDoctor;
    if (current is BulkApprovedSuccess) return current.selectedDoctor;
    if (current is BulkRejectedLoading) return current.selectedDoctor;
    if (current is BulkRejectedError) return current.selectedDoctor;
    if (current is BulkRejectedSuccess) return current.selectedDoctor;
    return null;
  }

  Future<void> loadDoctors({String? selectedDoctorId}) async {
    if (isClosed) return;
    emit(DoctorsLoading());

    final result = await repo.fetchDoctorsOverview();
    if (isClosed) return;

    await result.fold(
      (failure) async {
        if (!isClosed) emit(DoctorsError(message: failure.errMessage));
      },
      (overview) async {
        if (overview.doctors.isEmpty) {
          if (!isClosed) {
            emit(DoctorsLoaded(overview: overview));
          }
          return;
        }

        final requestedId = selectedDoctorId;
        final selected = overview.doctors.cast<dynamic>().firstWhere(
          (doctor) => doctor.id == requestedId,
          orElse: () => null,
        );
        final doctorId = selected?.id ?? overview.doctors.first.id;
        final detailsResult = await repo.fetchDoctorDetails(doctorId);

        if (isClosed) return;

        detailsResult.fold(
          (failure) {
            log('Failed to fetch doctor details: ${failure.errMessage}');
            final fallback = selected ?? overview.doctors.first;
            emit(
              DoctorsLoaded(
                overview: overview,
                selectedDoctor: fallback.toDetails(),
              ),
            );
          },
          (details) => emit(
            DoctorsLoaded(overview: overview, selectedDoctor: details),
          ),
        );
      },
    );
  }

  Future<void> loadDoctorDetails(String id) async {
    final overview = _currentOverview();
    final selected = _currentSelected();
    if (overview == null || isClosed) return;

    emit(
      DoctorsDetailLoading(
        overview: overview,
        selectedDoctor: selected,
      ),
    );

    final result = await repo.fetchDoctorDetails(id);
    if (isClosed) return;

    result.fold(
      (failure) => emit(
        DoctorsDetailError(
          overview: overview,
          selectedDoctor: selected,
          message: failure.errMessage,
        ),
      ),
      (details) => emit(
        DoctorsLoaded(overview: overview, selectedDoctor: details),
      ),
    );
  }

  Future<void> approveDoctor({required String doctorId}) async {
    if (_actionInProgress || isClosed) return;
    final overview = _currentOverview();
    final selected = _currentSelected();
    if (overview == null) return;

    _actionInProgress = true;
    emit(
      BulkApprovedLoading(
        overview: overview,
        selectedDoctor: selected,
      ),
    );

    final response = await repo.bulkApprove(doctorId);
    if (isClosed) return;

    await response.fold(
      (failure) async {
        emit(
          BulkApprovedError(
            message: failure.errMessage,
            overview: overview,
            selectedDoctor: selected,
          ),
        );
      },
      (_) async {
        emit(
          BulkApprovedSuccess(
            overview: overview,
            selectedDoctor: selected,
          ),
        );
        await _refreshKeepingSelection(doctorId);
      },
    );

    _actionInProgress = false;
  }

  Future<void> rejectDoctor(
    String? reason, {
    required String doctorId,
  }) async {
    if (_actionInProgress || isClosed) return;
    final overview = _currentOverview();
    final selected = _currentSelected();
    if (overview == null) return;

    _actionInProgress = true;
    emit(
      BulkRejectedLoading(
        overview: overview,
        selectedDoctor: selected,
      ),
    );

    final response = await repo.bulkReject(doctorId, reason);
    if (isClosed) return;

    await response.fold(
      (failure) async {
        emit(
          BulkRejectedError(
            message: failure.errMessage,
            overview: overview,
            selectedDoctor: selected,
          ),
        );
      },
      (_) async {
        emit(
          BulkRejectedSuccess(
            overview: overview,
            selectedDoctor: selected,
          ),
        );
        await _refreshKeepingSelection(doctorId);
      },
    );

    _actionInProgress = false;
  }

  Future<void> _refreshKeepingSelection(String doctorId) async {
    if (isClosed) return;
    await loadDoctors(selectedDoctorId: doctorId);
  }
}
