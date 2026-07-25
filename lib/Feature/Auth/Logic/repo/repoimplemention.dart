import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:hossam_templete_for_apps/Core/Services/api_service.dart';
import 'package:hossam_templete_for_apps/Core/constants/Endpoints.dart';
import 'package:hossam_templete_for_apps/Core/errors/Failure.dart';
import 'package:hossam_templete_for_apps/Feature/Auth/Logic/models/LoginRequestModel.dart';
import 'package:hossam_templete_for_apps/Feature/Auth/Logic/models/LoginResponseModel.dart';
import 'package:hossam_templete_for_apps/Feature/Auth/Logic/models/RegisterRequestModel.dart';
import 'package:hossam_templete_for_apps/Feature/Auth/Logic/models/RegisterResponseModel.dart';
import 'package:hossam_templete_for_apps/Feature/Auth/Logic/repo/repo.dart';

class Repoimplemention implements Repo {
  final ApiService apiService;
  Repoimplemention({required this.apiService});

  @override
  Future<Either<Failure, LoginResponseModels>> login({
    required LoginRequestModels loginRequestModel,
  }) async {
    try {
      final response = await apiService.post(
        EndPoints.login,
        data: loginRequestModel.toJson(),
      );

      return Right(LoginResponseModels.fromJson(response));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioExcepiton(e));
    }
  }

  @override
  Future<Either<Failure, RegisterResponseModels>> register({
    required RegisterRequestModels registerRequestModel,
  }) async {
    try {
      final response = await apiService.post(
        EndPoints.register,
        data: registerRequestModel.toJson(),
      );

      return Right(RegisterResponseModels.fromJson(response));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioExcepiton(e));
    }
  }

}
