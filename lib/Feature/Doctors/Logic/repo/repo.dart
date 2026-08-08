import 'package:dartz/dartz.dart';
import 'package:hossam_templete_for_apps/Core/errors/exception.dart';
import 'package:hossam_templete_for_apps/Feature/Doctors/Logic/models/doctor_appointment_model.dart';
import 'package:hossam_templete_for_apps/Feature/Doctors/Logic/models/doctor_details_model.dart';
import 'package:hossam_templete_for_apps/Feature/Doctors/Logic/models/doctor_document_model.dart';
import 'package:hossam_templete_for_apps/Feature/Doctors/Logic/models/doctor_revenue_model.dart';
import 'package:hossam_templete_for_apps/Feature/Doctors/Logic/models/doctor_review_model.dart';
import 'package:hossam_templete_for_apps/Feature/Doctors/Logic/models/doctors_overview_model.dart';

abstract class DoctorRepo {
  Future<Either<CustomException, DoctorsOverviewModel>> fetchDoctorsOverview();
  Future<Either<CustomException, DoctorDetailsModel>> fetchDoctorDetails(
    String id,
  );
  Future<Either<CustomException, DoctorRevenueModel>> getDoctorStatistics(
    String id,
  );
  Future<Either<CustomException, List<DoctorAppointmentModel>>>
  getDoctorAppointments(
    String id, {
    String? status,
    int limit = 10,
    int offset = 0,
  });
  Future<Either<CustomException, List<DoctorReviewModel>>> getDoctorReviews(
    String id, {
    int limit = 10,
    int offset = 0,
  });
  Future<Either<CustomException, List<DoctorDocumentModel>>> getDoctorDocuments(
    String id,
  );

  Future<Either<CustomException, bool>> bulkApprove(String id);
  Future<Either<CustomException, bool>> bulkReject(String id, String? reason);
  Future<Either<CustomException, bool>> changeDoctorStatus(
    String id,
    String status, {
    String? reason,
  });
}
