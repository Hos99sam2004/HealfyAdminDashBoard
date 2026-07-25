import 'package:dartz/dartz.dart';
import 'package:hossam_templete_for_apps/Core/errors/Failure.dart';
import 'package:hossam_templete_for_apps/Feature/Auth/Logic/models/LoginRequestModel.dart';
import 'package:hossam_templete_for_apps/Feature/Auth/Logic/models/LoginResponseModel.dart';
import 'package:hossam_templete_for_apps/Feature/Auth/Logic/models/RegisterRequestModel.dart';
import 'package:hossam_templete_for_apps/Feature/Auth/Logic/models/RegisterResponseModel.dart';
abstract class Repo {
  Future<Either<Failure, LoginResponseModels>> login({
    required LoginRequestModels loginRequestModel,
  });
  Future<Either<Failure, RegisterResponseModels>> register({
    required RegisterRequestModels registerRequestModel,
  });

}
