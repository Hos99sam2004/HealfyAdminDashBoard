import 'package:bloc/bloc.dart';
import 'package:hossam_templete_for_apps/Feature/Doctors/Logic/models/doctor_details_model.dart';
import 'package:hossam_templete_for_apps/Feature/Doctors/Logic/models/doctors_overview_model.dart';
import 'package:hossam_templete_for_apps/Feature/Doctors/Logic/repo/repo.dart';
part 'doctors_state.dart';

class DoctorsCubit extends Cubit<DoctorsState> {
  final DoctorRepo repo;

  DoctorsCubit(this.repo) : super(DoctorsInitial());

  Future<void> loadDoctors() async {
    emit(DoctorsLoading());
    final result = await repo.fetchDoctorsOverview();
    result.fold((failure) => emit(DoctorsError(message: failure.errMessage)), (
      overview,
    ) {
      final selectedDoctor = overview.doctors.isNotEmpty
          ? overview.doctors.first.toDetails()
          : null;
      emit(DoctorsLoaded(overview: overview, selectedDoctor: selectedDoctor));
    });
  }

  Future<void> loadDoctorDetails(String id) async {
    final currentState = state;
    if (currentState is! DoctorsLoaded) return;
    emit(
      DoctorsDetailLoading(
        overview: currentState.overview,
        selectedDoctor: currentState.selectedDoctor,
      ),
    );

    final result = await repo.fetchDoctorDetails(id);
    result.fold(
      (failure) => emit(
        DoctorsDetailError(
          overview: currentState.overview,
          message: failure.errMessage,
        ),
      ),
      (details) => emit(
        DoctorsLoaded(overview: currentState.overview, selectedDoctor: details),
      ),
    );
  }
}
