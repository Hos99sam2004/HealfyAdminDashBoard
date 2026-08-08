class DoctorDocumentModel {
  final String id;
  final String? label;
  final String? url;
  final DateTime? uploadedAt;

  DoctorDocumentModel({
    required this.id,
    this.label,
    this.url,
    this.uploadedAt,
  });

  factory DoctorDocumentModel.fromMap(Map<String, dynamic> map) {
    return DoctorDocumentModel(
      id: map['id']?.toString() ?? '',
      // تقرأ document_type من الداتابيز أو label كخيار احتياطي
      label: map['document_type']?.toString() ?? map['label']?.toString(),
      // تقرأ document_url من الداتابيز أو url كخيار احتياطي
      url: map['document_url']?.toString() ?? map['url']?.toString(),
      // تقرأ created_at من الداتابيز أو uploaded_at كخيار احتياطي
      uploadedAt: _parseDate(map['created_at'] ?? map['uploaded_at']),
    );
  }

  // ✅ اضف هذه الدالة هنا ليختفي خطأ .toMap() فوراً
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'document_type': label,
      'document_url': url,
      'created_at': uploadedAt?.toIso8601String(),
    };
  }
}

DateTime? _parseDate(dynamic value) {
  if (value == null) return null;
  if (value is DateTime) return value;
  if (value is String) return DateTime.tryParse(value);
  return null;
}
