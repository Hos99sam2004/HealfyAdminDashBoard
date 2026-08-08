import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hossam_templete_for_apps/Feature/Search/Logic/cubit/patient_search_state.dart';
import 'package:hossam_templete_for_apps/Feature/Search/Logic/repo/search_repo.dart';

class PatientSearchCubit extends Cubit<PatientSearchState> {
  final SearchRepo repo;

  PatientSearchCubit(this.repo) : super(PatientSearchInitial());

  void initSearch() async {
    final recents = await repo.getRecentSearches();
    emit(
      PatientSearchSuccess(
        results: [],
        recentSearches: recents,
        currentQuery: '',
      ),
    );
  }

  void search(String query, {String? specialtyId}) async {
    if (query.trim().isEmpty) {
      final recents = await repo.getRecentSearches();
      emit(
        PatientSearchSuccess(
          results: [],
          recentSearches: recents,
          currentQuery: '',
        ),
      );
      return;
    }

    emit(PatientSearchLoading());
    try {
      await repo.saveSearchQuery(query);
      final results = await repo.searchDoctors(
        query: query,
        specialtyId: specialtyId,
      );
      final recents = await repo.getRecentSearches();
      emit(
        PatientSearchSuccess(
          results: results,
          recentSearches: recents,
          currentQuery: query,
        ),
      );
    } catch (e) {
      emit(PatientSearchError(e.toString()));
    }
  }

  void clearHistory() async {
    await repo.clearRecentSearches();
    emit(
      PatientSearchSuccess(results: [], recentSearches: [], currentQuery: ''),
    );
  }
}
