class DoctorRevenueModel {
  final String doctorId;
  final double totalRevenue;
  final int completedAppointments;
  final int upcomingAppointments;
  final int cancelledAppointments;
  final double averageRating;
  final int reviewsCount;
  final int patientCount;

  const DoctorRevenueModel({
    required this.doctorId,
    required this.totalRevenue,
    required this.completedAppointments,
    required this.upcomingAppointments,
    required this.cancelledAppointments,
    required this.averageRating,
    required this.reviewsCount,
    required this.patientCount,
  });

  factory DoctorRevenueModel.fromMap(Map<String, dynamic> map) {
    return DoctorRevenueModel(
      doctorId: map['doctor_id']?.toString() ?? map['id']?.toString() ?? '',
      totalRevenue: map['total_revenue'] is num
          ? (map['total_revenue'] as num).toDouble()
          : double.tryParse(map['total_revenue']?.toString() ?? '') ?? 0,
      completedAppointments: map['completed_appointments'] is int
          ? map['completed_appointments'] as int
          : int.tryParse(map['completed_appointments']?.toString() ?? '') ?? 0,
      upcomingAppointments: map['upcoming_appointments'] is int
          ? map['upcoming_appointments'] as int
          : int.tryParse(map['upcoming_appointments']?.toString() ?? '') ?? 0,
      cancelledAppointments: map['cancelled_appointments'] is int
          ? map['cancelled_appointments'] as int
          : int.tryParse(map['cancelled_appointments']?.toString() ?? '') ?? 0,
      averageRating: map['average_rating'] is num
          ? (map['average_rating'] as num).toDouble()
          : double.tryParse(map['average_rating']?.toString() ?? '') ?? 0,
      reviewsCount: map['reviews_count'] is int
          ? map['reviews_count'] as int
          : int.tryParse(map['reviews_count']?.toString() ?? '') ?? 0,
      patientCount: map['patient_count'] is int
          ? map['patient_count'] as int
          : int.tryParse(map['patient_count']?.toString() ?? '') ?? 0,
    );
  }
}
