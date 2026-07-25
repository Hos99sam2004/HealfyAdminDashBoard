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
      label: map['label']?.toString(),
      url: map['url']?.toString(),
      uploadedAt: _parseDate(map['uploaded_at']),
    );
  }
}

DateTime? _parseDate(dynamic value) {
  if (value == null) return null;
  if (value is DateTime) return value;
  if (value is String) return DateTime.tryParse(value);
  return null;
}
