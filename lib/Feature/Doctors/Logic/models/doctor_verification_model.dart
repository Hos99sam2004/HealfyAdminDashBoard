class DoctorVerificationModel {
  final String id;
  final String? status;
  final String? verifiedBy;
  final DateTime? verifiedAt;
  final String? reason;
  final String? notes;

  const DoctorVerificationModel({
    required this.id,
    this.status,
    this.verifiedBy,
    this.verifiedAt,
    this.reason,
    this.notes,
  });

  factory DoctorVerificationModel.fromMap(Map<String, dynamic> map) {
    return DoctorVerificationModel(
      id: map['id']?.toString() ?? '',
      status: map['status']?.toString(),
      verifiedBy:
          map['verified_by']?.toString() ?? map['verifiedBy']?.toString(),
      verifiedAt: _parseDate(map['verified_at'] ?? map['created_at']),
      reason: map['reason']?.toString() ?? map['rejected_reason']?.toString(),
      notes: map['notes']?.toString(),
    );
  }

  static DateTime? _parseDate(dynamic value) {
    if (value == null) return null;
    if (value is DateTime) return value;
    if (value is String) return DateTime.tryParse(value);
    return null;
  }
}
