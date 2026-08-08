import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:hossam_templete_for_apps/Feature/Doctors/Logic/models/doctor_details_model.dart';
import 'package:hossam_templete_for_apps/Feature/Doctors/Logic/models/doctors_overview_model.dart';
import 'package:hossam_templete_for_apps/Feature/Doctors/Logic/repo/repo.dart';

part 'doctors_state.dart';

class DoctorsCubit extends Cubit<DoctorsState> {
  final DoctorRepo repo;

  DoctorsCubit(this.repo) : super(DoctorsInitial());

  Future<void> loadDoctors() async {
    if (isClosed) return;
    emit(DoctorsLoading());

    final result = await repo.fetchDoctorsOverview();
    if (isClosed) return;

    await result.fold(
      (failure) async {
        if (!isClosed) emit(DoctorsError(message: failure.errMessage));
      },
      (overview) async {
        log("result => Completed ${overview.doctors.length} doctors loaded");

        if (overview.doctors.isEmpty) {
          if (!isClosed) {
            emit(DoctorsLoaded(overview: overview, selectedDoctor: null));
          }
          return;
        }

        final firstDoctorId = overview.doctors.first.id;
        final detailsResult = await repo.fetchDoctorDetails(firstDoctorId);

        if (isClosed) return;

        detailsResult.fold(
          (failure) {
            log("Failed to fetch first doctor details: ${failure.errMessage}");
            if (!isClosed) {
              emit(
                DoctorsLoaded(
                  overview: overview,
                  selectedDoctor: overview.doctors.first.toDetails(),
                ),
              );
            }
          },
          (details) {
            log("First doctor full details loaded successfully!");
            if (!isClosed) {
              emit(DoctorsLoaded(overview: overview, selectedDoctor: details));
            }
          },
        );
      },
    );
  }

  Future<void> loadDoctorDetails(String id) async {
    log("Loading doctor details for ID: $id...");

    DoctorsOverviewModel? currentOverview;
    DoctorDetailsModel? currentSelected;

    if (state is DoctorsLoaded) {
      final s = state as DoctorsLoaded;
      currentOverview = s.overview;
      currentSelected = s.selectedDoctor;
    } else if (state is DoctorsDetailLoading) {
      final s = state as DoctorsDetailLoading;
      currentOverview = s.overview;
      currentSelected = s.selectedDoctor;
    } else if (state is DoctorsDetailError) {
      final s = state as DoctorsDetailError;
      currentOverview = s.overview;
    }

    if (currentOverview == null) return;

    if (isClosed) return;
    emit(
      DoctorsDetailLoading(
        overview: currentOverview,
        selectedDoctor: currentSelected,
      ),
    );

    final result = await repo.fetchDoctorDetails(id);
    if (isClosed) return;

    result.fold(
      (failure) {
        if (!isClosed) {
          emit(
            DoctorsDetailError(
              overview: currentOverview!,
              message: failure.errMessage,
            ),
          );
        }
      },
      (details) {
        if (!isClosed) {
          emit(
            DoctorsLoaded(overview: currentOverview!, selectedDoctor: details),
          );
        }
      },
    );
  }

  Future<void> approveDoctor({required String doctorId}) async {
    if (isClosed) return;
    emit(BulkApprovedLoading());

    final response = await repo.bulkApprove(doctorId);
    if (isClosed) return;

    await response.fold(
      (failure) async {
        if (!isClosed) emit(BulkApprovedError(message: failure.errMessage));
      },
      (right) async {
        if (!isClosed) {
          emit(BulkApprovedSuccess());
          // 🟢 التعديل هنا: نستخدم loadDoctors() عشان يبعت State جديدة بالبيانات للـ UI
          await loadDoctors();
        }
      },
    );
  }

  Future<void> rejectDoctor(String? reason, {required String doctorId}) async {
    if (isClosed) return;
    emit(BulkRejectedLoading());

    final response = await repo.bulkReject(doctorId, reason);
    if (isClosed) return;

    await response.fold(
      (failure) async {
        if (!isClosed) emit(BulkRejectedError(message: failure.errMessage));
      },
      (right) async {
        if (!isClosed) {
          emit(BulkRejectedSuccess());
          // 🟢 التعديل هنا: نستخدم loadDoctors() عشان يبعت State جديدة بالبيانات للـ UI
          await loadDoctors();
        }
      },
    );
  }
}
