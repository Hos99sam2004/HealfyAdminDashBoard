class RecentPaymentModel {
  final String id;
  final String? patientName;
  final String? doctorName;
  final double amount;
  final String status;
  final DateTime? createdAt;

  RecentPaymentModel({
    required this.id,
    this.patientName,
    this.doctorName,
    required this.amount,
    required this.status,
    this.createdAt,
  });

  factory RecentPaymentModel.fromMap(Map<String, dynamic> map) {
    return RecentPaymentModel(
      id: map['id']?.toString() ?? '',
      patientName:
          map['patient_name']?.toString() ?? map['patient']?.toString(),
      doctorName: map['doctor_name']?.toString() ?? map['doctor']?.toString(),
      amount: _parseAmount(map['amount']),
      status: map['status']?.toString() ?? 'unknown',
      createdAt: _parseDate(map['created_at']),
    );
  }
}

double _parseAmount(dynamic amount) {
  if (amount == null) return 0.0;
  if (amount is num) return amount.toDouble();
  return double.tryParse(amount.toString()) ?? 0.0;
}

DateTime? _parseDate(dynamic value) {
  if (value == null) return null;
  if (value is String) return DateTime.tryParse(value);
  if (value is DateTime) return value;
  return null;
}
