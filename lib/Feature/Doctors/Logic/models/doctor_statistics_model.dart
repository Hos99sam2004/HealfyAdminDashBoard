class DoctorStatisticsModel {
  final int totalDoctors;
  final int verifiedDoctors;
  final int rejectedDoctors;
  final int pendingDoctors;

  const DoctorStatisticsModel({
    required this.totalDoctors,
    required this.verifiedDoctors,
    required this.rejectedDoctors,
    required this.pendingDoctors,
  });
}
