class RecentDoctorModel {
  final String id;
  final String name;
  final String? email;
  final String? phone;
  final DateTime? createdAt;
  final bool profileCompleted;

  RecentDoctorModel({
    required this.id,
    required this.name,
    this.email,
    this.phone,
    this.createdAt,
    required this.profileCompleted,
  });

  factory RecentDoctorModel.fromMap(Map<String, dynamic> map) {
    return RecentDoctorModel(
      id: map['id']?.toString() ?? '',
      name:
          map['full_name']?.toString() ?? map['name']?.toString() ?? 'Unknown',
      email: map['email']?.toString(),
      phone: map['phone']?.toString(),
      createdAt: _parseDate(map['created_at']),
      profileCompleted: map['profile_completed'] == true,
    );
  }
}

DateTime? _parseDate(dynamic value) {
  if (value == null) return null;
  if (value is String) return DateTime.tryParse(value);
  if (value is DateTime) return value;
  return null;
}
