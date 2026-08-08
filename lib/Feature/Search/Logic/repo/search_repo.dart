import 'package:hossam_templete_for_apps/Feature/Search/Logic/models/PatientDoctorModel.dart';

abstract class SearchRepo {
  Future<List<PatientDoctorModel>> searchDoctors({
    required String query,
    String? specialtyId,
  });
  Future<List<String>> getRecentSearches();
  Future<void> saveSearchQuery(String query);
  Future<void> clearRecentSearches();
}
