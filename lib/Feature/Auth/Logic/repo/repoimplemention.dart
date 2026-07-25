import 'package:dartz/dartz.dart';
import 'package:hossam_templete_for_apps/Core/errors/exception.dart';
import 'package:hossam_templete_for_apps/Feature/Auth/Logic/models/LoginRequestModel.dart';
import 'package:hossam_templete_for_apps/Feature/Auth/Logic/models/LoginResponseModel.dart';
import 'package:hossam_templete_for_apps/Feature/Auth/Logic/models/RegisterRequestModel.dart';
// import 'package:hossam_templete_for_apps/Feature/Auth/Logic/models/RegisterResponseModel.dart';
import 'package:hossam_templete_for_apps/Feature/Auth/Logic/repo/repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Repoimplemention implements Repo {
  final SupabaseClient supabase;

  Repoimplemention({required this.supabase});

  @override
  Future<Either<CustomException, LoginResponseModels>> login({
    required LoginRequestModels loginRequestModel,
  }) async {
    try {
      final response = await supabase.auth.signInWithPassword(
        email: loginRequestModel.email ?? '',
        password: loginRequestModel.password ?? '',
      );
      final data = LoginResponseModels(
        user: response.user,
        session: response.session,
      );
      return Right(data);
    } catch (e) {
      return Left(CustomException(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<CustomException, LoginResponseModels>> register({
    required RegisterRequestModels registerRequestModel,
  }) async {
    try {
      final response = await supabase.auth.signUp(
        password: registerRequestModel.password!,
        email: registerRequestModel.email!,
        data: {
          "FullName": registerRequestModel.name,
          "Phone": registerRequestModel.phone,
          // "Role": registerRequestModel.role,
        },
      );

      await supabase.from('profiles').insert({
        'id': response.user!.id,
        'full_name': registerRequestModel.name,
        'phone': registerRequestModel.phone,
        'email': registerRequestModel.email,
        'avatar_url': null,
        'role': registerRequestModel.role,
      });

      final data = LoginResponseModels(
        user: response.user,
        session: response.session,
      );
      print(response);
      return Right(data);
    }  catch (e) {
      return Left(CustomException(errMessage: e.toString()));
    }
  }
}
