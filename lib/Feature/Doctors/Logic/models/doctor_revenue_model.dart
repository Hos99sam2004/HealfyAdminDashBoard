class DoctorRevenueModel {
  final String doctorId;
  final double? rating;
  final int? totalReviews;
  final int? totalAppointments;
  final int? completedAppointments;

  const DoctorRevenueModel({
    required this.doctorId,
    this.rating,
    this.totalReviews,
    this.totalAppointments,
    this.completedAppointments,
  });

  factory DoctorRevenueModel.fromMap(Map<String, dynamic> map) {
    return DoctorRevenueModel(
      doctorId: map['doctor_id']?.toString() ?? '',
      rating: _parseDouble(map['rating']),
      totalReviews: _parseInt(map['total_reviews']),
      totalAppointments: _parseInt(map['total_appointments']),
      completedAppointments: _parseInt(map['completed_appointments']),
    );
  }
}

int? _parseInt(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  if (value is num) return value.toInt();
  return int.tryParse(value.toString());
}

double? _parseDouble(dynamic value) {
  if (value == null) return null;
  if (value is num) return value.toDouble();
  return double.tryParse(value.toString());
}
