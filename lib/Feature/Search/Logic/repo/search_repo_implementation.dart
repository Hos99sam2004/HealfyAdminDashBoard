import 'package:hossam_templete_for_apps/Feature/Search/Logic/models/PatientDoctorModel.dart';
import 'package:hossam_templete_for_apps/Feature/Search/Logic/repo/search_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchRepoImplementation implements SearchRepo {
  final SupabaseClient supabase;

  SearchRepoImplementation({required this.supabase});

  static const String _recentSearchesKey = 'patient_recent_searches';

  @override
  Future<List<PatientDoctorModel>> searchDoctors({
    required String query,
    String? specialtyId,
  }) async {
    try {
      var dbQuery = supabase
          .from('doctors')
          .select(
            '*, profiles!user_id(id, full_name, email, phone, avatar_url), specialties(id, name), doctor_clinics(*)',
          );

      if (specialtyId != null &&
          specialtyId.isNotEmpty &&
          specialtyId != 'all') {
        dbQuery = dbQuery.eq('specialty_id', specialtyId);
      }

      final response = await dbQuery.order('rating', ascending: false);

      if (response is List) {
        var list = response
            .map((e) => PatientDoctorModel.fromJson(e as Map<String, dynamic>))
            .toList();

        if (query.trim().isNotEmpty) {
          final q = query.trim().toLowerCase();
          list = list
              .where(
                (d) =>
                    d.fullName.toLowerCase().contains(q) ||
                    d.specialtyName.toLowerCase().contains(q) ||
                    (d.clinicAddress ?? '').toLowerCase().contains(q),
              )
              .toList();
        }

        return list;
      }
    } catch (_) {}
    return [];
  }

  @override
  Future<List<String>> getRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_recentSearchesKey) ?? [];
  }

  @override
  Future<void> saveSearchQuery(String query) async {
    if (query.trim().isEmpty) return;
    final prefs = await SharedPreferences.getInstance();
    List<String> searches = prefs.getStringList(_recentSearchesKey) ?? [];
    searches.remove(query.trim());
    searches.insert(0, query.trim());
    if (searches.length > 10) searches = searches.sublist(0, 10);
    await prefs.setStringList(_recentSearchesKey, searches);
  }

  @override
  Future<void> clearRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_recentSearchesKey);
  }
}
