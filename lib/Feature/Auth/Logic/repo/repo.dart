import 'package:dartz/dartz.dart';
import 'package:hossam_templete_for_apps/Core/errors/exception.dart';
import 'package:hossam_templete_for_apps/Feature/Auth/Logic/models/LoginRequestModel.dart';
import 'package:hossam_templete_for_apps/Feature/Auth/Logic/models/LoginResponseModel.dart';
import 'package:hossam_templete_for_apps/Feature/Auth/Logic/models/RegisterRequestModel.dart';
// import 'package:hossam_templete_for_apps/Feature/Auth/Logic/models/RegisterResponseModel.dart';

abstract class Repo {
  Future<Either<CustomException, LoginResponseModels >> login({
    required LoginRequestModels loginRequestModel,
  });
  Future<Either<CustomException, LoginResponseModels>> register({
    required RegisterRequestModels registerRequestModel,
  });

}
