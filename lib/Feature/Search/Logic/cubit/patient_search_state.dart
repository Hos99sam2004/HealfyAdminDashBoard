import 'package:hossam_templete_for_apps/Feature/Search/Logic/models/PatientDoctorModel.dart';

abstract class PatientSearchState {}

class PatientSearchInitial extends PatientSearchState {}

class PatientSearchLoading extends PatientSearchState {}

class PatientSearchSuccess extends PatientSearchState {
  final List<PatientDoctorModel> results;
  final List<String> recentSearches;
  final String currentQuery;

  PatientSearchSuccess({
    required this.results,
    required this.recentSearches,
    required this.currentQuery,
  });
}

class PatientSearchError extends PatientSearchState {
  final String message;
  PatientSearchError(this.message);
}
