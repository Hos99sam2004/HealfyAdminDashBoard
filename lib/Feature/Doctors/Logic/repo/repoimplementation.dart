import 'package:dartz/dartz.dart';
import 'package:hossam_templete_for_apps/Core/errors/exception.dart';
import 'package:hossam_templete_for_apps/Feature/Doctors/Logic/models/doctor_details_model.dart';
import 'package:hossam_templete_for_apps/Feature/Doctors/Logic/models/doctor_model.dart';
import 'package:hossam_templete_for_apps/Feature/Doctors/Logic/models/doctor_statistics_model.dart';
import 'package:hossam_templete_for_apps/Feature/Doctors/Logic/models/doctors_overview_model.dart';
import 'package:hossam_templete_for_apps/Feature/Doctors/Logic/repo/repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DoctorRepoImplementation implements DoctorRepo {
  final SupabaseClient supabase;

  DoctorRepoImplementation({required this.supabase});

  @override
  Future<Either<CustomException, DoctorsOverviewModel>>
  fetchDoctorsOverview() async {
    try {
      final response = await supabase.from('doctors').select('''
      id,
      status,
      rating,
      total_reviews,
      consultation_price,
      experience_years,
      license_number,
      about,
      profiles(
        id,
        full_name,
        email,
        phone,
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
      )
    ''');
      final rows = response as List<dynamic>? ?? [];
      final doctors = rows
          .map((row) => DoctorModel.fromMap(row as Map<String, dynamic>))
          .toList();

      final statistics = DoctorStatisticsModel(
        totalDoctors: doctors.length,
        verifiedDoctors: doctors.where((it) => it.profileCompleted).length,
        pendingDoctors: doctors.where((it) => !it.profileCompleted).length,
      );

      return Right(
        DoctorsOverviewModel(statistics: statistics, doctors: doctors),
      );
    } catch (e) {
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
      profiles(
        id,
        full_name,
        email,
        phone,
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
      )
    ''')
          .eq('id', id)
          .maybeSingle();

      if (response == null) {
        return Left(CustomException(errMessage: 'Doctor not found.'));
      }

      return Right(
        DoctorDetailsModel.fromMap(response as Map<String, dynamic>),
      );
    } catch (e) {
      return Left(CustomException(errMessage: e.toString()));
    }
  }
}
