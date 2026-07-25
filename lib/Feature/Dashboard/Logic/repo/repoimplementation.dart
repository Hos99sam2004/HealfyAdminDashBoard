import 'package:dartz/dartz.dart';
import 'package:hossam_templete_for_apps/Core/errors/exception.dart';
import 'package:hossam_templete_for_apps/Feature/Dashboard/Logic/models/dashboard_model.dart';
import 'package:hossam_templete_for_apps/Feature/Dashboard/Logic/models/recent_appointment_model.dart';
import 'package:hossam_templete_for_apps/Feature/Dashboard/Logic/models/recent_doctor_model.dart';
import 'package:hossam_templete_for_apps/Feature/Dashboard/Logic/models/recent_patient_model.dart';
import 'package:hossam_templete_for_apps/Feature/Dashboard/Logic/models/recent_payment_model.dart';
import 'package:hossam_templete_for_apps/Feature/Dashboard/Logic/repo/repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DashboardRepoImplementation implements DashboardRepo {
  final SupabaseClient supabase;

  DashboardRepoImplementation({required this.supabase});

  @override
  Future<Either<CustomException, DashboardModel>> fetchDashboardData() async {
    try {
      final profilesResponse = await supabase
          .from('profiles')
          .select('id,full_name,email,phone,created_at,role,profile_completed');

      final profileData = profilesResponse as List<dynamic>? ?? [];
      final doctors = profileData
          .where((row) => row['role'] == 'doctor')
          .toList(growable: false);
      final patients = profileData
          .where((row) => row['role'] == 'patient')
          .toList(growable: false);
      final pendingDoctors = doctors
          .where((row) => row['profile_completed'] == false)
          .length;
      final verifiedDoctors = doctors
          .where((row) => row['profile_completed'] == true)
          .length;
      final latestRegisteredDoctors = doctors
          .map((row) => RecentDoctorModel.fromMap(row as Map<String, dynamic>))
          .toList();
      final latestPatients = patients
          .map((row) => RecentPatientModel.fromMap(row as Map<String, dynamic>))
          .toList();

      final now = DateTime.now().toUtc();
      final todayString =
          '${now.year.toString().padLeft(4, '0')}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
      final todaysAppointmentsCount = await _countAppointmentsByDate(
        todayString,
      );
      final completedAppointmentsCount = await _countAppointmentsByStatus(
        'completed',
      );
      final cancelledAppointmentsCount = await _countAppointmentsByStatus(
        'cancelled',
      );
      final pendingPaymentsCount = await _countPaymentsByStatus('pending');
      final platformRevenue = await _sumPaymentsAmount();
      final latestBookings = await _fetchRecentAppointments();
      final latestPayments = await _fetchRecentPayments();

      final dashboard = DashboardModel(
        totalDoctors: doctors.length,
        pendingDoctors: pendingDoctors,
        verifiedDoctors: verifiedDoctors,
        totalPatients: patients.length,
        todaysAppointments: todaysAppointmentsCount,
        completedAppointments: completedAppointmentsCount,
        cancelledAppointments: cancelledAppointmentsCount,
        pendingPayments: pendingPaymentsCount,
        platformRevenue: platformRevenue,
        latestRegisteredDoctors: latestRegisteredDoctors,
        latestPatients: latestPatients,
        latestBookings: latestBookings,
        latestPayments: latestPayments,
      );

      return Right(dashboard);
    } catch (e) {
      return Left(CustomException(errMessage: e.toString()));
    }
  }

  Future<int> _countAppointmentsByDate(String date) async {
    try {
      final response = await supabase
          .from('appointments')
          .select('id')
          .eq('date', date);
      return (response as List<dynamic>?)?.length ?? 0;
    } catch (_) {
      return 0;
    }
  }

  Future<int> _countAppointmentsByStatus(String status) async {
    try {
      final response = await supabase
          .from('appointments')
          .select('id')
          .eq('status', status);
      return (response as List<dynamic>?)?.length ?? 0;
    } catch (_) {
      return 0;
    }
  }

  Future<int> _countPaymentsByStatus(String status) async {
    try {
      final response = await supabase
          .from('payments')
          .select('id')
          .eq('status', status);
      return (response as List<dynamic>?)?.length ?? 0;
    } catch (_) {
      return 0;
    }
  }

  Future<double> _sumPaymentsAmount() async {
    try {
      final response = await supabase.from('payments').select('amount');
      final rows = response as List<dynamic>? ?? [];
      return rows.fold<double>(0.0, (sum, row) {
        if (row is Map<String, dynamic>) {
          final amount = row['amount'];
          if (amount is num) return sum + amount.toDouble();
          if (amount is String) return sum + (double.tryParse(amount) ?? 0.0);
        }
        return sum;
      });
    } catch (_) {
      return 0.0;
    }
  }

  Future<List<RecentAppointmentModel>> _fetchRecentAppointments() async {
    try {
      final response = await supabase
          .from('appointments')
          .select('id,patient_name,doctor_name,date,status')
          .order('date', ascending: false)
          .limit(5);
      final rows = response as List<dynamic>? ?? [];
      return rows
          .map(
            (row) =>
                RecentAppointmentModel.fromMap(row as Map<String, dynamic>),
          )
          .toList();
    } catch (_) {
      return [];
    }
  }

  Future<List<RecentPaymentModel>> _fetchRecentPayments() async {
    try {
      final response = await supabase
          .from('payments')
          .select('id,patient_name,doctor_name,amount,status,created_at')
          .order('created_at', ascending: false)
          .limit(5);
      final rows = response as List<dynamic>? ?? [];
      return rows
          .map((row) => RecentPaymentModel.fromMap(row as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return [];
    }
  }
}
