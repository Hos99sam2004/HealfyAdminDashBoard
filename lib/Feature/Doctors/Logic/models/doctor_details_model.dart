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
  final String? status;
  final double? rating;
  final int? totalReviews;
  final double? consultationPrice;
  final List<String> workingDays;
  final DateTime? joinedAt;
  final String? verificationReason;
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
    this.status,
    this.rating,
    this.totalReviews,
    this.consultationPrice,
    required this.workingDays,
    this.joinedAt,
    this.verificationReason,
    required this.documents,
  });

  factory DoctorDetailsModel.fromMap(Map<String, dynamic> map) {
    final doctorData = map['doctors'] is Map<String, dynamic>
        ? map['doctors'] as Map<String, dynamic>
        : map;
    final profileData = map['profiles'] is Map<String, dynamic>
        ? map['profiles'] as Map<String, dynamic>
        : map;

    String? extractedSpecialty;
    final specialties = map['specialties'];
    if (specialties is Map<String, dynamic>) {
      extractedSpecialty = specialties['name']?.toString();
    } else if (specialties is List && specialties.isNotEmpty) {
      final first = specialties.first;
      if (first is Map) extractedSpecialty = first['name']?.toString();
    } else {
      extractedSpecialty = map['specialty']?.toString();
    }

    Map<String, dynamic> clinicData = {};
    final clinics = map['doctor_clinics'];
    if (clinics is List && clinics.isNotEmpty && clinics.first is Map) {
      clinicData = Map<String, dynamic>.from(clinics.first as Map);
    } else if (clinics is Map<String, dynamic>) {
      clinicData = clinics;
    }

    final workingDaysList = <String>[];
    final schedules = map['doctor_schedules'];
    if (schedules is List) {
      for (final item in schedules) {
        if (item is Map && item['day_of_week'] != null) {
          workingDaysList.add(item['day_of_week'].toString());
        }
      }
    } else if (map['workingDays'] is List) {
      workingDaysList.addAll(
        (map['workingDays'] as List).map((item) => item.toString()),
      );
    }

    final documents = <DoctorDocumentModel>[];
    final rawDocuments = map['doctor_documents'];
    if (rawDocuments is List) {
      for (final raw in rawDocuments) {
        if (raw is Map) {
          documents.add(
            DoctorDocumentModel.fromMap(Map<String, dynamic>.from(raw)),
          );
        }
      }
    }

    return DoctorDetailsModel(
      id: doctorData['id']?.toString() ?? profileData['id']?.toString() ?? '',
      fullName: profileData['full_name']?.toString() ?? 'Unknown Doctor',
      email: profileData['email']?.toString(),
      phone: profileData['phone']?.toString(),
      avatarUrl: profileData['avatar_url']?.toString(),
      role: profileData['role']?.toString() ?? 'doctor',
      profileCompleted: profileData['profile_completed'] == true,
      gender: profileData['gender']?.toString(),
      age: _parseInt(profileData['age']),
      createdAt: _parseDate(doctorData['created_at'] ?? profileData['created_at']),
      updatedAt: _parseDate(doctorData['updated_at'] ?? profileData['updated_at']),
      licenseNumber: doctorData['license_number']?.toString(),
      yearsExperience: _parseInt(doctorData['experience_years']),
      bio: doctorData['about']?.toString(),
      specialty: extractedSpecialty,
      clinicName: clinicData['clinic_name']?.toString(),
      city: clinicData['city']?.toString(),
      address: clinicData['address']?.toString(),
      status: doctorData['status']?.toString(),
      rating: _parseDouble(doctorData['rating']),
      totalReviews: _parseInt(doctorData['total_reviews']),
      consultationPrice: _parseDouble(doctorData['consultation_price']),
      workingDays: workingDaysList,
      joinedAt: _parseDate(doctorData['created_at'] ?? profileData['created_at']),
      verificationReason: doctorData['rejected_reason']?.toString(),
      documents: documents,
    );
  }
}

int? _parseInt(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  if (value is num) return value.toInt();
  return int.tryParse(value.toString());
}

double? _parseDouble(dynamic value) {
  if (value == null) return null;
  if (value is num) return value.toDouble();
  return double.tryParse(value.toString());
}

DateTime? _parseDate(dynamic value) {
  if (value == null) return null;
  if (value is DateTime) return value;
  return DateTime.tryParse(value.toString());
}
