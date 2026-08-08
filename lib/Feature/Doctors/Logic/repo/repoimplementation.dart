import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:hossam_templete_for_apps/Core/errors/exception.dart';
import 'package:hossam_templete_for_apps/Feature/Doctors/Logic/models/doctor_appointment_model.dart';
import 'package:hossam_templete_for_apps/Feature/Doctors/Logic/models/doctor_details_model.dart';
import 'package:hossam_templete_for_apps/Feature/Doctors/Logic/models/doctor_document_model.dart';
import 'package:hossam_templete_for_apps/Feature/Doctors/Logic/models/doctor_model.dart';
import 'package:hossam_templete_for_apps/Feature/Doctors/Logic/models/doctor_revenue_model.dart';
import 'package:hossam_templete_for_apps/Feature/Doctors/Logic/models/doctor_review_model.dart';
import 'package:hossam_templete_for_apps/Feature/Doctors/Logic/models/doctor_statistics_model.dart';
import 'package:hossam_templete_for_apps/Feature/Doctors/Logic/models/doctor_verification_model.dart';
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
      print('response $response');
      final rows = response as List<dynamic>? ?? [];
      final doctors = rows.map((row) => DoctorModel.fromMap(row)).toList();

      final statistics = DoctorStatisticsModel(
        totalDoctors: doctors.length,
        verifiedDoctors: doctors.where((it) => it.status == 'approved').length,
        pendingDoctors: doctors.where((it) => it.status == 'pending').length,
        rejectedDoctors: doctors
            .where((it) => it.status == 'rejected')
            .length, // 🟢 تم تعديل rejecedDoctors إلى rejectedDoctors
      );

      print('==========================================================');
      print("Total Doctors: ${statistics.totalDoctors}");
      print(" verifiedDoctors ${statistics.verifiedDoctors}");
      print("Pending Doctors: ${statistics.pendingDoctors}");
      print("Rejected Doctors: ${statistics.rejectedDoctors}");

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
      // 1️⃣ طلب بيانات الطبيب الأساسية والعلاقات المباشرة (تم إزالة doctor_documents لتجنب مشاكل الـ Foreign Key)
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
            day_of_week
          )
        ''')
          .eq('id', id)
          .maybeSingle();

      if (response == null) {
        return Left(CustomException(errMessage: 'Doctor not found.'));
      }
      print(response);
      final merged = Map<String, dynamic>.from(response);

      // 2️⃣ جلب إحصائيات الطبيب بشكل منفصل (View)
      try {
        final statsResponse = await supabase
            .from('doctor_statistics')
            .select('''
              total_appointments,
              completed_appointments
            ''')
            .eq('doctor_id', id)
            .maybeSingle();

        if (statsResponse != null) {
          merged['doctor_statistics'] = statsResponse;
        }
      } catch (statsErr) {
        log('Warning fetching doctor statistics view: $statsErr');
      }

      // 3️⃣ 🔥 جلب المستندات بشكل منفصل باستخدام دالة getDoctorDocuments المباشرة
      final docsResult = await getDoctorDocuments(id);
      docsResult.fold(
        (err) => log('Warning fetching doctor documents: ${err.errMessage}'),
        (docsList) {
          // تحويل قائمة DoctorDocumentModel إلى قائمة Maps ليتعامل معها Model التفاصيل بشكل صحيح
          merged['doctor_documents'] = docsList
              .map((doc) => doc.toMap())
              .toList();
        },
      );

      // 4️⃣ تجهيز ومعالجة بيانات العيادة
      final clinicsRaw = merged['doctor_clinics'];
      if (clinicsRaw is List<dynamic> && clinicsRaw.isNotEmpty) {
        final firstClinic = Map<String, dynamic>.from(clinicsRaw.first);
        merged['clinic_name'] = firstClinic['clinic_name'];
        merged['city'] = firstClinic['city'];
        merged['address'] = firstClinic['address'];
      } else if (clinicsRaw is Map<String, dynamic>) {
        merged['clinic_name'] = clinicsRaw['clinic_name'];
        merged['city'] = clinicsRaw['city'];
        merged['address'] = clinicsRaw['address'];
      }

      // 5️⃣ تجهيز ومعالجة التخصص
      final specsRaw = merged['specialties'];
      if (specsRaw is List<dynamic> && specsRaw.isNotEmpty) {
        final firstSpec = Map<String, dynamic>.from(specsRaw.first);
        merged['specialty'] = firstSpec['name']?.toString();
      } else if (specsRaw is Map<String, dynamic>) {
        merged['specialty'] = specsRaw['name']?.toString();
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
          .eq('doctor_id', id) // تم التأكد من استخدام doctor_id
          .maybeSingle();

      if (response == null) {
        return Left(
          CustomException(errMessage: 'Doctor statistics not found.'),
        );
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
      final rows = response as List<dynamic>? ?? [];
      return Right(
        rows
            .map(
              (row) => DoctorAppointmentModel.fromMap(
                Map<String, dynamic>.from(row),
              ),
            )
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

      final rows = response as List<dynamic>? ?? [];
      return Right(
        rows
            .map(
              (row) =>
                  DoctorReviewModel.fromMap(Map<String, dynamic>.from(row)),
            )
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

      final rows = response as List<dynamic>? ?? [];
      return Right(
        rows
            .map(
              (row) =>
                  DoctorDocumentModel.fromMap(Map<String, dynamic>.from(row)),
            )
            .toList(),
      );
    } catch (e) {
      log('Error fetching doctor documents: $e');
      return Left(CustomException(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<CustomException, DoctorVerificationModel>> verifyDoctor(
    String id, {
    required String status,
    String? reason,
    String? verifiedBy,
  }) async {
    try {
      final response = await supabase
          .from('doctor_verifications')
          .upsert({
            'doctor_id': id,
            'status': status,
            'reason': reason,
            'verified_by': verifiedBy,
            'verified_at': DateTime.now().toIso8601String(),
          })
          .select()
          .single();

      return Right(
        DoctorVerificationModel.fromMap(Map<String, dynamic>.from(response)),
      );
    } catch (e) {
      log('Error verifying doctor: $e');
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
          .select();

      log(response.toString());

      if (response == null) {
        return Left(CustomException(errMessage: 'Update returned null'));
      }

      if (response.isEmpty) {
        return Left(CustomException(errMessage: 'No rows updated'));
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
            'rejected_reason': reason ?? 'Rejected By Admin',
          })
          .eq('id', doctorId) // 👈 تم التغيير من in_ إلى eq
          .select();

      if (response.isEmpty) {
        return Left(
          CustomException(
            errMessage: 'No rows were updated. Check RLS policy.',
          ),
        );
      }

      return const Right(true);
    } catch (e) {
      log('Error rejecting doctor: $e');
      return Left(CustomException(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<CustomException, bool>> bulkActivate(List<String> ids) async {
    try {
      await supabase
          .from('doctors')
          .update({'status': 'approved'})
          .filter('id', 'in', '(${ids.join(",")})');
      return const Right(true);
    } catch (e) {
      log('Error bulk activating doctors: $e');
      return Left(CustomException(errMessage: e.toString()));
    }
  }
}
