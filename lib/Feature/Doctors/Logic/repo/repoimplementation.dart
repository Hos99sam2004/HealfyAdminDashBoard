import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:hossam_templete_for_apps/Core/errors/exception.dart';
import 'package:hossam_templete_for_apps/Feature/Doctors/Logic/models/doctor_appointment_model.dart';
import 'package:hossam_templete_for_apps/Feature/Doctors/Logic/models/doctor_details_model.dart';
import 'package:hossam_templete_for_apps/Feature/Doctors/Logic/models/doctor_document_model.dart';
import 'package:hossam_templete_for_apps/Feature/Doctors/Logic/models/doctor_model.dart';
import 'package:hossam_templete_for_apps/Feature/Doctors/Logic/models/doctor_revenue_model.dart';
import 'package:hossam_templete_for_apps/Feature/Doctors/Logic/models/doctor_review_model.dart';
import 'package:hossam_templete_for_apps/Feature/Doctors/Logic/models/doctors_overview_model.dart';
import 'package:hossam_templete_for_apps/Feature/Doctors/Logic/repo/repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DoctorRepoImplementation implements DoctorRepo {
  final SupabaseClient supabase;

  DoctorRepoImplementation({required this.supabase});

  static const _profileFields = '''
    id,
    experience_years,
    license_number,
    about,
    status,
    rating,
    total_reviews,
    consultation_price,
    created_at,
    updated_at,
    rejected_reason,
    profiles(
      id,
      full_name,
      email,
      phone,
      avatar_url,
      profile_completed
    ),
    specialties(
      id,
      name
    ),
    doctor_clinics(
      clinic_name,
      city,
      address
    )
  ''';

  @override
  Future<Either<CustomException, DoctorsOverviewModel>>
  fetchDoctorsOverview() async {
    try {
      final response = await supabase.from('doctors').select(_profileFields);
      final rows = response as List<dynamic>? ?? const [];
      final doctors = rows
          .whereType<Map<String, dynamic>>()
          .map(DoctorModel.fromMap)
          .toList();

      final statistics = DoctorStatisticsModel(
        totalDoctors: doctors.length,
        verifiedDoctors: doctors.where((doctor) => doctor.status == 'approved').length,
        pendingDoctors: doctors.where((doctor) => doctor.status == 'pending').length,
        rejectedDoctors: doctors.where((doctor) => doctor.status == 'rejected').length,
      );

      return Right(
        DoctorsOverviewModel(statistics: statistics, doctors: doctors),
      );
    } catch (e) {
      log('Error fetching doctors overview: $e');
      return Left(CustomException(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<CustomException, DoctorDetailsModel>> fetchDoctorDetails(
    String id,
  ) async {
    try {
      final response = await supabase
          .from('doctors')
          .select('''
            id,
            status,
            rating,
            total_reviews,
            consultation_price,
            experience_years,
            license_number,
            about,
            created_at,
            updated_at,
            rejected_reason,
            profiles(
              id,
              full_name,
              email,
              phone,
              profile_completed,
              avatar_url
            ),
            specialties(
              id,
              name
            ),
            doctor_clinics(
              clinic_name,
              city,
              address
            ),
            doctor_schedules(
              day_of_week,
              start_time,
              end_time,
              slot_duration,
              is_available
            )
          ''')
          .eq('id', id)
          .maybeSingle();

      if (response == null) {
        return Left(CustomException(errMessage: 'Doctor not found.'));
      }

      final merged = Map<String, dynamic>.from(response);

      try {
        final statsResponse = await supabase
            .from('doctor_statistics')
            .select('''
              total_appointments,
              completed_appointments,
              total_reviews,
              rating
            ''')
            .eq('doctor_id', id)
            .maybeSingle();

        if (statsResponse != null) {
          merged['doctor_statistics'] = statsResponse;
        }
      } catch (statsErr) {
        log('Warning fetching doctor statistics: $statsErr');
      }

      final docsResult = await getDoctorDocuments(id);
      docsResult.fold(
        (err) => log('Warning fetching doctor documents: ${err.errMessage}'),
        (docs) => merged['doctor_documents'] = docs.map((doc) => doc.toMap()).toList(),
      );

      final clinicsRaw = merged['doctor_clinics'];
      if (clinicsRaw is List && clinicsRaw.isNotEmpty && clinicsRaw.first is Map) {
        final clinic = Map<String, dynamic>.from(clinicsRaw.first as Map);
        merged['clinic_name'] = clinic['clinic_name'];
        merged['city'] = clinic['city'];
        merged['address'] = clinic['address'];
      } else if (clinicsRaw is Map<String, dynamic>) {
        merged['clinic_name'] = clinicsRaw['clinic_name'];
        merged['city'] = clinicsRaw['city'];
        merged['address'] = clinicsRaw['address'];
      }

      final specialtyRaw = merged['specialties'];
      if (specialtyRaw is List && specialtyRaw.isNotEmpty && specialtyRaw.first is Map) {
        merged['specialty'] = (specialtyRaw.first as Map)['name']?.toString();
      } else if (specialtyRaw is Map<String, dynamic>) {
        merged['specialty'] = specialtyRaw['name']?.toString();
      }

      return Right(DoctorDetailsModel.fromMap(merged));
    } catch (e) {
      log('Error fetching doctor details: $e');
      return Left(CustomException(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<CustomException, DoctorRevenueModel>> getDoctorStatistics(
    String id,
  ) async {
    try {
      final response = await supabase
          .from('doctor_statistics')
          .select('''
            completed_appointments,
            total_appointments,
            total_reviews,
            rating
          ''')
          .eq('doctor_id', id)
          .maybeSingle();

      if (response == null) {
        return Left(CustomException(errMessage: 'Doctor statistics not found.'));
      }

      return Right(DoctorRevenueModel.fromMap(response));
    } catch (e) {
      log('Error fetching doctor statistics: $e');
      return Left(CustomException(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<CustomException, List<DoctorAppointmentModel>>>
  getDoctorAppointments(
    String id, {
    String? status,
    int limit = 10,
    int offset = 0,
  }) async {
    try {
      var query = supabase
          .from('appointments')
          .select('''
            id,
            appointment_date,
            status,
            amount,
            patient_name,
            clinic_name,
            doctor_id
          ''')
          .eq('doctor_id', id);

      if (status != null && status.isNotEmpty) {
        query = query.eq('status', status);
      }

      final response = await query.range(offset, offset + limit - 1);
      final rows = response as List<dynamic>? ?? const [];
      return Right(
        rows
            .whereType<Map<String, dynamic>>()
            .map(DoctorAppointmentModel.fromMap)
            .toList(),
      );
    } catch (e) {
      log('Error fetching doctor appointments: $e');
      return Left(CustomException(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<CustomException, List<DoctorReviewModel>>> getDoctorReviews(
    String id, {
    int limit = 10,
    int offset = 0,
  }) async {
    try {
      final response = await supabase
          .from('doctor_reviews')
          .select('''
            id,
            doctor_id,
            patient_name,
            rating,
            comment,
            created_at
          ''')
          .eq('doctor_id', id)
          .range(offset, offset + limit - 1);

      final rows = response as List<dynamic>? ?? const [];
      return Right(
        rows
            .whereType<Map<String, dynamic>>()
            .map(DoctorReviewModel.fromMap)
            .toList(),
      );
    } catch (e) {
      log('Error fetching doctor reviews: $e');
      return Left(CustomException(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<CustomException, List<DoctorDocumentModel>>> getDoctorDocuments(
    String id,
  ) async {
    try {
      final response = await supabase
          .from('doctor_documents')
          .select('''
            id,
            doctor_id,
            document_type,
            document_url,
            created_at
          ''')
          .eq('doctor_id', id);

      final rows = response as List<dynamic>? ?? const [];
      return Right(
        rows
            .whereType<Map<String, dynamic>>()
            .map(DoctorDocumentModel.fromMap)
            .toList(),
      );
    } catch (e) {
      log('Error fetching doctor documents: $e');
      return Left(CustomException(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<CustomException, bool>> bulkApprove(String doctorId) async {
    try {
      final response = await supabase
          .from('doctors')
          .update({'status': 'approved'})
          .eq('id', doctorId)
          .select('id, status');

      if (response.isEmpty) {
        return Left(CustomException(errMessage: 'No doctor was updated.'));
      }

      return const Right(true);
    } catch (e) {
      log('Error approving doctor: $e');
      return Left(CustomException(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<CustomException, bool>> bulkReject(
    String doctorId,
    String? reason,
  ) async {
    try {
      final response = await supabase
          .from('doctors')
          .update({
            'status': 'rejected',
            'rejected_reason':
                reason == null || reason.trim().isEmpty
                    ? 'Rejected By Admin'
                    : reason.trim(),
          })
          .eq('id', doctorId)
          .select('id, status, rejected_reason');

      if (response.isEmpty) {
        return Left(CustomException(errMessage: 'No doctor was updated.'));
      }

      return const Right(true);
    } catch (e) {
      log('Error rejecting doctor: $e');
      return Left(CustomException(errMessage: e.toString()));
    }
  }
}
