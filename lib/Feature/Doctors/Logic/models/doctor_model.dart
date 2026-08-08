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
  final double? rating;
  final int? totalReviews;
  final double? consultationPrice;
  final String? rejectedReason;

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
    this.rating,
    this.totalReviews,
    this.consultationPrice,
    this.rejectedReason,
    this.clinicName,
    this.city,
    this.address,
    this.documents = const [],
  });

  factory DoctorModel.fromMap(Map<String, dynamic> map) {
    final doctorMap = map['doctors'] is Map<String, dynamic>
        ? map['doctors'] as Map<String, dynamic>
        : map;
    final profileMap = map['profiles'] is Map<String, dynamic>
        ? map['profiles'] as Map<String, dynamic>
        : map;

    String? extractedSpecialty;
    final specialties = map['specialties'];
    if (specialties is Map<String, dynamic>) {
      extractedSpecialty = specialties['name']?.toString();
    } else if (specialties is List && specialties.isNotEmpty) {
      final first = specialties.first;
      if (first is Map) {
        extractedSpecialty = first['name']?.toString();
      }
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

    final docs = <DoctorDocumentModel>[];
    final rawDocuments = map['doctor_documents'];
    if (rawDocuments is List) {
      for (final raw in rawDocuments) {
        if (raw is Map) {
          docs.add(DoctorDocumentModel.fromMap(Map<String, dynamic>.from(raw)));
        }
      }
    }

    return DoctorModel(
      id: doctorMap['id']?.toString() ?? profileMap['id']?.toString() ?? '',
      fullName: profileMap['full_name']?.toString() ?? 'Unknown Doctor',
      email: profileMap['email']?.toString(),
      phone: profileMap['phone']?.toString(),
      avatarUrl: profileMap['avatar_url']?.toString(),
      role: profileMap['role']?.toString() ?? 'doctor',
      status: doctorMap['status']?.toString(),
      profileCompleted: profileMap['profile_completed'] == true,
      createdAt: _parseDate(doctorMap['created_at'] ?? profileMap['created_at']),
      updatedAt: _parseDate(doctorMap['updated_at'] ?? profileMap['updated_at']),
      about: doctorMap['about']?.toString(),
      specialty: extractedSpecialty,
      yearsExperience: _parseInt(doctorMap['experience_years']),
      licenseNumber: doctorMap['license_number']?.toString(),
      rating: _parseDouble(doctorMap['rating']),
      totalReviews: _parseInt(doctorMap['total_reviews']),
      consultationPrice: _parseDouble(doctorMap['consultation_price']),
      rejectedReason: doctorMap['rejected_reason']?.toString(),
      clinicName: clinicData['clinic_name']?.toString(),
      city: clinicData['city']?.toString(),
      address: clinicData['address']?.toString(),
      documents: docs,
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
      rating: rating,
      totalReviews: totalReviews,
      consultationPrice: consultationPrice,
      clinicName: clinicName,
      city: city,
      address: address,
      bio: about,
      workingDays: const [],
      joinedAt: createdAt,
      verificationReason: rejectedReason,
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
