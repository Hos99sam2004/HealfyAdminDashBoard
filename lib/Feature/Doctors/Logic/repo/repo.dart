import 'package:dartz/dartz.dart';
import 'package:hossam_templete_for_apps/Core/errors/exception.dart';
import 'package:hossam_templete_for_apps/Feature/Doctors/Logic/models/doctor_details_model.dart';
import 'package:hossam_templete_for_apps/Feature/Doctors/Logic/models/doctors_overview_model.dart';

abstract class DoctorRepo {
  Future<Either<CustomException, DoctorsOverviewModel>> fetchDoctorsOverview();
  Future<Either<CustomException, DoctorDetailsModel>> fetchDoctorDetails(
    String id,
  );
}
