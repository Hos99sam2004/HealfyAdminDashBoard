part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthChangeValidateMode extends AuthState {}
final class ChangeSelectedRoleState extends AuthState {}

// Loading states
final class AuthLoginLoading extends AuthState {}

final class AuthRegisterLoading extends AuthState {}

// Success states
final class AuthLoginSuccess extends AuthState {
  final LoginResponseModels loginResponseModels;
  AuthLoginSuccess({required this.loginResponseModels});
}

final class AuthRegisterSuccess extends AuthState {
  final RegisterResponseModels registerResponseModels;
  AuthRegisterSuccess({required this.registerResponseModels});
}


// Failure states
final class AuthLoginFailure extends AuthState {
  final String errMessage;
  AuthLoginFailure({required this.errMessage});
}

final class AuthRegisterFailure extends AuthState {
  final String errMessage;
  AuthRegisterFailure({required this.errMessage});
}
