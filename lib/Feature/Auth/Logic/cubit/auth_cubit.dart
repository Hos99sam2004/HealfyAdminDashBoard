import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hossam_templete_for_apps/Feature/Auth/Logic/models/LoginRequestModel.dart';
import 'package:hossam_templete_for_apps/Feature/Auth/Logic/models/LoginResponseModel.dart';
import 'package:hossam_templete_for_apps/Feature/Auth/Logic/models/RegisterRequestModel.dart';
// import 'package:hossam_templete_for_apps/Feature/Auth/Logic/models/RegisterResponseModel.dart';
import 'package:hossam_templete_for_apps/Feature/Auth/Logic/repo/repo.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._repo) : super(AuthInitial());

  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  String selectedRole = "patient";
  final supabase = Supabase.instance.client;

  void changeSelectedRole(String value) {
    selectedRole = value;
    emit(ChangeSelectedRoleState());
  }

  final Repo _repo;

  Future<void> loginUSer({
    required LoginRequestModels loginRequestModels,
  }) async {
    emit(AuthLoginLoading());
    try {
      final result = await _repo.login(loginRequestModel: loginRequestModels);
      result.fold((failure) {
        emit(AuthLoginFailure(errMessage: failure.errMessage));
      }, (r) => emit(AuthLoginSuccess(loginResponseModels: r)));
    } catch (e) {
      emit(AuthLoginFailure(errMessage: e.toString()));
    }
  }

  Future<void> registerUser({
    required RegisterRequestModels registerRequestModels,
  }) async {
    emit(AuthRegisterLoading());
    try {
      final result = await _repo.register(
        registerRequestModel: registerRequestModels,
      );
      result.fold((failure) {
        emit(AuthRegisterFailure(errMessage: failure.errMessage));
      }, (r) => emit(AuthRegisterSuccess(loginResponseModels: r)));
    } catch (e) {
      emit(AuthRegisterFailure(errMessage: e.toString()));
    }
  }

  void changeAutoValidateMode() {
    autovalidateMode = autovalidateMode == AutovalidateMode.disabled
        ? AutovalidateMode.always
        : AutovalidateMode.disabled;
    emit(AuthChangeValidateMode());
  }
}
