class DoctorReviewModel {
  final String id;
  final String? patientName;
  final int? rating;
  final String? comment;
  final DateTime? createdAt;

  const DoctorReviewModel({
    required this.id,
    this.patientName,
    this.rating,
    this.comment,
    this.createdAt,
  });

  factory DoctorReviewModel.fromMap(Map<String, dynamic> map) {
    return DoctorReviewModel(
      id: map['id']?.toString() ?? '',
      patientName:
          map['patient_name']?.toString() ?? map['patientName']?.toString(),
      rating: map['rating'] is int
          ? map['rating'] as int
          : int.tryParse(map['rating']?.toString() ?? ''),
      comment: map['comment']?.toString() ?? map['review']?.toString(),
      createdAt: _parseDate(map['created_at'] ?? map['createdAt']),
    );
  }

  static DateTime? _parseDate(dynamic value) {
    if (value == null) return null;
    if (value is DateTime) return value;
    if (value is String) return DateTime.tryParse(value);
    return null;
  }
}
