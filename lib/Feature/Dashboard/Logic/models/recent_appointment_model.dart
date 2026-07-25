class RecentAppointmentModel {
  final String id;
  final String? patientName;
  final String? doctorName;
  final DateTime? scheduledAt;
  final String status;

  RecentAppointmentModel({
    required this.id,
    this.patientName,
    this.doctorName,
    this.scheduledAt,
    required this.status,
  });

  factory RecentAppointmentModel.fromMap(Map<String, dynamic> map) {
    return RecentAppointmentModel(
      id: map['id']?.toString() ?? '',
      patientName:
          map['patient_name']?.toString() ?? map['patient']?.toString(),
      doctorName: map['doctor_name']?.toString() ?? map['doctor']?.toString(),
      scheduledAt: _parseDate(map['scheduled_at'] ?? map['created_at']),
      status: map['status']?.toString() ?? 'unknown',
    );
  }
}

DateTime? _parseDate(dynamic value) {
  if (value == null) return null;
  if (value is String) return DateTime.tryParse(value);
  if (value is DateTime) return value;
  return null;
}
