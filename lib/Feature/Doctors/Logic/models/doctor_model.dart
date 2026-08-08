import 'package:hossam_templete_for_apps/Feature/Doctors/Logic/models/doctor_details_model.dart';
import 'package:hossam_templete_for_apps/Feature/Doctors/Logic/models/doctor_document_model.dart';

class DoctorModel {
  final String id;
  final String fullName;
  final String? email;
  final String? phone;
  final String? avatarUrl;
  final String? role;
  final String? status;
  final bool profileCompleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  final String? specialty;
  final String? about;

  final int? yearsExperience;
  final String? licenseNumber;

  final String? clinicName;
  final String? city;
  final String? address;

  final List<DoctorDocumentModel> documents;

  DoctorModel({
    required this.id,
    required this.fullName,
    this.email,
    this.phone,
    this.avatarUrl,
    this.role,
    this.status,
    required this.profileCompleted,
    this.createdAt,
    this.updatedAt,
    this.specialty,
    this.about,
    this.yearsExperience,
    this.licenseNumber,
    this.clinicName,
    this.city,
    this.address,
    this.documents = const [],
  });

  factory DoctorModel.fromMap(Map<String, dynamic> map) {
    // 1️⃣ تحديد مصدر بيانات doctor و profile
    final isDoctorRoot =
        map.containsKey('experience_years') ||
        map.containsKey('license_number');

    final Map<String, dynamic> doctorMap = isDoctorRoot
        ? map
        : (map['doctors'] is Map<String, dynamic> ? map['doctors'] : map);

    final Map<String, dynamic> profileMap =
        map['profiles'] is Map<String, dynamic>
        ? map['profiles'] as Map<String, dynamic>
        : map;

    // 2️⃣ استخراج التخصص
    String? extractedSpecialty;
    if (map['specialties'] is Map<String, dynamic>) {
      extractedSpecialty = map['specialties']['name']?.toString();
    } else if (map['specialties'] is List &&
        (map['specialties'] as List).isNotEmpty) {
      final firstSpecialty = (map['specialties'] as List).first;
      if (firstSpecialty is Map<String, dynamic>) {
        extractedSpecialty = firstSpecialty['name']?.toString();
      }
    } else {
      extractedSpecialty = map['specialty']?.toString();
    }

    // 3️⃣ استخراج بيانات العيادة
    Map<String, dynamic> clinicData = {};
    if (map['doctor_clinics'] is List &&
        (map['doctor_clinics'] as List).isNotEmpty) {
      final firstClinic = (map['doctor_clinics'] as List).first;
      if (firstClinic is Map<String, dynamic>) {
        clinicData = firstClinic;
      }
    } else if (map['doctor_clinics'] is Map<String, dynamic>) {
      clinicData = map['doctor_clinics'] as Map<String, dynamic>;
    }

    // 4️⃣ المستندات
    List<DoctorDocumentModel> docsList = [];
    if (map['doctor_documents'] is List) {
      docsList = (map['doctor_documents'] as List)
          .whereType<Map<String, dynamic>>()
          .map((doc) => DoctorDocumentModel.fromMap(doc))
          .toList();
    }

    return DoctorModel(
      // 🟢 أخذ الـ ID الخاص بجدول doctors أولاً
      id: doctorMap['id']?.toString() ?? profileMap['id']?.toString() ?? '',
      fullName: profileMap['full_name']?.toString() ?? 'Unknown Doctor',
      email: profileMap['email']?.toString(),
      phone: profileMap['phone']?.toString(),
      avatarUrl: profileMap['avatar_url']?.toString(),
      role: profileMap['role']?.toString() ?? 'doctor',

      // 🟢 قراءة الـ status الحقيقية من جدول doctors دائمًا
      status: doctorMap['status']?.toString() ?? 'pending',

      profileCompleted: profileMap['profile_completed'] == true,
      createdAt: _parseDate(
        doctorMap['created_at'] ?? profileMap['created_at'],
      ),
      updatedAt: _parseDate(
        doctorMap['updated_at'] ?? profileMap['updated_at'],
      ),

      about: doctorMap['about']?.toString() ?? profileMap['about']?.toString(),
      specialty: extractedSpecialty,
      yearsExperience: _parseInt(
        doctorMap['experience_years'] ?? doctorMap['years_experience'],
      ),
      licenseNumber: doctorMap['license_number']?.toString(),

      clinicName:
          clinicData['clinic_name']?.toString() ??
          doctorMap['clinic_name']?.toString(),
      city: clinicData['city']?.toString() ?? doctorMap['city']?.toString(),
      address:
          clinicData['address']?.toString() ?? doctorMap['address']?.toString(),

      documents: docsList,
    );
  }
  DoctorDetailsModel toDetails() {
    return DoctorDetailsModel(
      id: id,
      fullName: fullName,
      email: email,
      phone: phone,
      avatarUrl: avatarUrl,
      role: role,
      status: status,
      profileCompleted: profileCompleted,
      createdAt: createdAt,
      updatedAt: updatedAt,
      specialty: specialty,
      yearsExperience: yearsExperience,
      licenseNumber: licenseNumber,
      clinicName: clinicName,
      city: city,
      address: address,
      bio: about,
      documents: documents,
      workingDays: [],
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
