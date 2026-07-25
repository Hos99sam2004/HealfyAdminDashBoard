import 'package:hossam_templete_for_apps/Feature/Dashboard/Logic/models/recent_appointment_model.dart';
import 'package:hossam_templete_for_apps/Feature/Dashboard/Logic/models/recent_doctor_model.dart';
import 'package:hossam_templete_for_apps/Feature/Dashboard/Logic/models/recent_patient_model.dart';
import 'package:hossam_templete_for_apps/Feature/Dashboard/Logic/models/recent_payment_model.dart';

class DashboardModel {
  final int totalDoctors;
  final int pendingDoctors;
  final int verifiedDoctors;
  final int totalPatients;
  final int todaysAppointments;
  final int completedAppointments;
  final int cancelledAppointments;
  final int pendingPayments;
  final double platformRevenue;
  final List<RecentDoctorModel> latestRegisteredDoctors;
  final List<RecentPatientModel> latestPatients;
  final List<RecentAppointmentModel> latestBookings;
  final List<RecentPaymentModel> latestPayments;

  const DashboardModel({
    required this.totalDoctors,
    required this.pendingDoctors,
    required this.verifiedDoctors,
    required this.totalPatients,
    required this.todaysAppointments,
    required this.completedAppointments,
    required this.cancelledAppointments,
    required this.pendingPayments,
    required this.platformRevenue,
    required this.latestRegisteredDoctors,
    required this.latestPatients,
    required this.latestBookings,
    required this.latestPayments,
  });

  factory DashboardModel.empty() => const DashboardModel(
    totalDoctors: 0,
    pendingDoctors: 0,
    verifiedDoctors: 0,
    totalPatients: 0,
    todaysAppointments: 0,
    completedAppointments: 0,
    cancelledAppointments: 0,
    pendingPayments: 0,
    platformRevenue: 0,
    latestRegisteredDoctors: [],
    latestPatients: [],
    latestBookings: [],
    latestPayments: [],
  );
}
