import 'package:dartz/dartz.dart';
import 'package:hossam_templete_for_apps/Core/errors/exception.dart';
import 'package:hossam_templete_for_apps/Feature/Dashboard/Logic/models/dashboard_model.dart';

abstract class DashboardRepo {
  Future<Either<CustomException, DashboardModel>> fetchDashboardData();
}
