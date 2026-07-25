import 'doctor_model.dart';
import 'doctor_statistics_model.dart';

class DoctorsOverviewModel {
  final DoctorStatisticsModel statistics;
  final List<DoctorModel> doctors;

  const DoctorsOverviewModel({required this.statistics, required this.doctors});
}
