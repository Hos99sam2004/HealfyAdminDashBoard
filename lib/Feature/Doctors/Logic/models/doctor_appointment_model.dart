class DoctorAppointmentModel {
  final String id;
  final String? patientName;
  final String? status;
  final DateTime? appointmentDate;
  final String? clinicName;
  final double? amount;

  const DoctorAppointmentModel({
    required this.id,
    this.patientName,
    this.status,
    this.appointmentDate,
    this.clinicName,
    this.amount,
  });

  factory DoctorAppointmentModel.fromMap(Map<String, dynamic> map) {
    return DoctorAppointmentModel(
      id: map['id']?.toString() ?? '',
      patientName:
          map['patient_name']?.toString() ?? map['patientName']?.toString(),
      status: map['status']?.toString(),
      appointmentDate: _parseDate(map['appointment_date'] ?? map['created_at']),
      clinicName:
          map['clinic_name']?.toString() ?? map['clinicName']?.toString(),
      amount: map['amount'] is num
          ? (map['amount'] as num).toDouble()
          : double.tryParse(map['amount']?.toString() ?? ''),
    );
  }

  static DateTime? _parseDate(dynamic value) {
    if (value == null) return null;
    if (value is DateTime) return value;
    if (value is String) return DateTime.tryParse(value);
    return null;
  }
}
