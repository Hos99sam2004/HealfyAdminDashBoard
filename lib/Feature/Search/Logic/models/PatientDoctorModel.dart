class PatientDoctorModel {
  final String id;
  final String userId;
  final String fullName;
  final String? avatarUrl;
  final String? specialtyId;
  final String specialtyName;
  final double rating;
  final int totalReviews;
  final int experienceYears;
  final double consultationPrice;
  final String? about;
  final String? clinicAddress;
  final String? distance;

  PatientDoctorModel({
    required this.id,
    required this.userId,
    required this.fullName,
    this.avatarUrl,
    this.specialtyId,
    required this.specialtyName,
    this.rating = 4.8,
    this.totalReviews = 0,
    this.experienceYears = 5,
    this.consultationPrice = 0.0,
    this.about,
    this.clinicAddress,
    this.distance = '1.5 km',
  });

  factory PatientDoctorModel.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> profile = {};
    if (json['profiles'] is Map) {
      profile = json['profiles'] as Map<String, dynamic>;
    }

    Map<String, dynamic> specialty = {};
    if (json['specialties'] is Map) {
      specialty = json['specialties'] as Map<String, dynamic>;
    }

    Map<String, dynamic> clinic = {};
    if (json['doctor_clinics'] is List &&
        (json['doctor_clinics'] as List).isNotEmpty) {
      clinic = (json['doctor_clinics'] as List).first as Map<String, dynamic>;
    } else if (json['doctor_clinics'] is Map) {
      clinic = json['doctor_clinics'] as Map<String, dynamic>;
    }

    return PatientDoctorModel(
      id: json['id']?.toString() ?? '',
      userId: json['user_id']?.toString() ?? profile['id']?.toString() ?? '',
      fullName:
          profile['full_name']?.toString() ??
          json['full_name']?.toString() ??
          'Doctor',
      avatarUrl:
          profile['avatar_url']?.toString() ?? json['avatar_url']?.toString(),
      specialtyId: json['specialty_id']?.toString(),
      specialtyName:
          specialty['name']?.toString() ??
          json['specialty_name']?.toString() ??
          'General',
      rating: (json['rating'] as num?)?.toDouble() ?? 4.8,
      totalReviews: (json['total_reviews'] as num?)?.toInt() ?? 120,
      experienceYears: (json['experience_years'] as num?)?.toInt() ?? 5,
      consultationPrice:
          (json['consultation_price'] as num?)?.toDouble() ?? 0.0,
      about: json['about']?.toString(),
      clinicAddress:
          clinic['address']?.toString() ??
          json['clinic_address']?.toString() ??
          'Medical Center',
      distance: json['distance']?.toString() ?? '1.5 km',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'user_id': userId,
    'full_name': fullName,
    'avatar_url': avatarUrl,
    'specialty_id': specialtyId,
    'specialty_name': specialtyName,
    'rating': rating,
    'total_reviews': totalReviews,
    'experience_years': experienceYears,
    'consultation_price': consultationPrice,
    'about': about,
    'clinic_address': clinicAddress,
    'distance': distance,
  };
}
