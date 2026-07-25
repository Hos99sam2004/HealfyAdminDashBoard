import 'doctor_document_model.dart';

class DoctorDetailsModel {
  final String id;
  final String fullName;
  final String? email;
  final String? phone;
  final String? avatarUrl;
  final String? role;
  final bool profileCompleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? gender;
  final int? age;
  final String? specialty;
  final int? yearsExperience;
  final String? licenseNumber;
  final String? clinicName;
  final String? city;
  final String? address;
  final String? bio;
  final List<DoctorDocumentModel> documents;

  DoctorDetailsModel({
    required this.id,
    required this.fullName,
    this.email,
    this.phone,
    this.avatarUrl,
    this.role,
    required this.profileCompleted,
    this.createdAt,
    this.updatedAt,
    this.gender,
    this.age,
    this.specialty,
    this.yearsExperience,
    this.licenseNumber,
    this.clinicName,
    this.city,
    this.address,
    this.bio,
    required this.documents,
  });

  factory DoctorDetailsModel.fromMap(Map<String, dynamic> map) {
    return DoctorDetailsModel(
      id: map['id']?.toString() ?? '',
      fullName: map['full_name']?.toString() ?? 'Unknown Doctor',
      email: map['email']?.toString(),
      phone: map['phone']?.toString(),
      avatarUrl: map['avatar_url']?.toString(),
      role: map['role']?.toString(),
      profileCompleted: map['profile_completed'] == true,
      createdAt: _parseDate(map['created_at']),
      updatedAt: _parseDate(map['updated_at']),
      gender: map['gender']?.toString(),
      age: _parseInt(map['age']),
      specialty: map['specialty']?.toString(),
      yearsExperience: _parseInt(map['years_experience']),
      licenseNumber: map['license_number']?.toString(),
      clinicName: map['clinic_name']?.toString(),
      city: map['city']?.toString(),
      address: map['address']?.toString(),
      bio: map['bio']?.toString(),
      documents: const [],
    );
  }
}

int? _parseInt(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  if (value is String) return int.tryParse(value);
  if (value is double) return value.toInt();
  return null;
}

DateTime? _parseDate(dynamic value) {
  if (value == null) return null;
  if (value is DateTime) return value;
  if (value is String) return DateTime.tryParse(value);
  return null;
}
