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
  final int? profileCompletionPercent;
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
    this.profileCompletionPercent,
    this.joinedAt,
    this.verificationReason,
    required this.documents,
  });

  factory DoctorDetailsModel.fromMap(Map<String, dynamic> map) {
    // 1️⃣ التعامل مع profiles (سواء كانت Map متداخلة أو مسطحة)
    final profileData = map['profiles'] is Map<String, dynamic>
        ? map['profiles'] as Map<String, dynamic>
        : map;

    // 2️⃣ التعامل مع specialties
    String? extractedSpecialty;
    if (map['specialties'] is Map<String, dynamic>) {
      extractedSpecialty = map['specialties']['name']?.toString();
    } else if (map['specialties'] is List &&
        (map['specialties'] as List).isNotEmpty) {
      extractedSpecialty = (map['specialties'] as List).first['name']
          ?.toString();
    } else {
      extractedSpecialty = map['specialty']?.toString();
    }

    // 3️⃣ التعامل مع doctor_clinics
    Map<String, dynamic> clinicData = {};
    if (map['doctor_clinics'] is List &&
        (map['doctor_clinics'] as List).isNotEmpty) {
      clinicData =
          (map['doctor_clinics'] as List).first as Map<String, dynamic>;
    } else if (map['doctor_clinics'] is Map<String, dynamic>) {
      clinicData = map['doctor_clinics'] as Map<String, dynamic>;
    }

    // 4️⃣ التعامل مع doctor_schedules (أيام العمل)
    List<String> workingDaysList = [];
    final schedulesRaw = map['doctor_schedules'];
    if (schedulesRaw is List && schedulesRaw.isNotEmpty) {
      workingDaysList = schedulesRaw
          .map((item) {
            if (item is Map) {
              return item['day_of_week']?.toString();
            }
            return item?.toString();
          })
          .whereType<String>()
          .toList();
    } else if (map['workingDays'] is List) {
      workingDaysList = (map['workingDays'] as List)
          .map((e) => e.toString())
          .toList();
    }

    // 5️⃣ التعامل مع doctor_documents (المستندات)
    List<DoctorDocumentModel> docsList = [];
    if (map['doctor_documents'] is List) {
      docsList = (map['doctor_documents'] as List)
          .map(
            (doc) => DoctorDocumentModel.fromMap(doc as Map<String, dynamic>),
          )
          .toList();
    }

    // 6️⃣ حساب النسبة المئوية للمواعيد المكتملة profileCompletionPercent
    Map<String, dynamic> statsData = {};
    if (map['doctor_statistics'] is Map<String, dynamic>) {
      statsData = map['doctor_statistics'] as Map<String, dynamic>;
    } else {
      statsData = map;
    }

    final totalAppointments = _parseInt(statsData['total_appointments']) ?? 0;
    final completedAppointments =
        _parseInt(statsData['completed_appointments']) ?? 0;

    int calculatedPercent = 0;
    if (totalAppointments > 0) {
      calculatedPercent = ((completedAppointments / totalAppointments) * 100)
          .round();
    } else if (map['profile_completion'] != null ||
        map['profileCompletion'] != null) {
      // إرجاع النسبة المكتوبة صراحة إن لم توجد مواعيد
      calculatedPercent =
          _parseInt(map['profile_completion'] ?? map['profileCompletion']) ?? 0;
    }

    return DoctorDetailsModel(
      id: map['id']?.toString() ?? profileData['id']?.toString() ?? '',

      // البيانات الشخصية من profiles
      fullName: profileData['full_name']?.toString() ?? 'Unknown Doctor',
      email: profileData['email']?.toString(),
      phone: profileData['phone']?.toString(),
      avatarUrl: profileData['avatar_url']?.toString(),
      role: profileData['role']?.toString() ?? 'doctor',
      profileCompleted: profileData['profile_completed'] == true,
      gender: profileData['gender']?.toString(),
      age: _parseInt(profileData['age']),
      createdAt: _parseDate(profileData['created_at']),
      updatedAt: _parseDate(profileData['updated_at']),

      // البيانات المهنية من doctors
      licenseNumber: map['license_number']?.toString(),
      yearsExperience: _parseInt(
        map['experience_years'] ?? map['years_experience'],
      ),
      bio: map['about']?.toString() ?? map['bio']?.toString(),

      // البيانات من الجداول المرتبطة
      specialty: extractedSpecialty,
      clinicName:
          clinicData['clinic_name']?.toString() ??
          map['clinic_name']?.toString(),
      city: clinicData['city']?.toString() ?? map['city']?.toString(),
      address: clinicData['address']?.toString() ?? map['address']?.toString(),
      status:
          map['status']?.toString() ?? map['verification_status']?.toString(),
      rating: _parseDouble(map['rating']),
      totalReviews: _parseInt(map['total_reviews']),
      consultationPrice: _parseDouble(map['consultation_price']),
      workingDays: workingDaysList,
      profileCompletionPercent: calculatedPercent,
      joinedAt: _parseDate(map['joined_at'] ?? map['created_at']),
      verificationReason:
          map['rejected_reason']?.toString() ?? map['reason']?.toString(),

      documents: docsList,
    );
  }
}

// Helper Functions
int? _parseInt(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  if (value is String) return int.tryParse(value);
  if (value is double) return value.toInt();
  return null;
}

double? _parseDouble(dynamic value) {
  if (value == null) return null;
  if (value is double) return value;
  if (value is int) return value.toDouble();
  if (value is String) return double.tryParse(value);
  return null;
}

DateTime? _parseDate(dynamic value) {
  if (value == null) return null;
  if (value is DateTime) return value;
  if (value is String) return DateTime.tryParse(value);
  return null;
}
