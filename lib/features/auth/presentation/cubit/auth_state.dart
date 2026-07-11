import 'package:flutter_coffee/features/auth/domain/entiteis/userentitey.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthGoogleFirstLogin extends AuthState {
  final UserEntity user;

  AuthGoogleFirstLogin(this.user);
}

class AuthLoadedWithuser extends AuthState {
  final UserEntity user;
  AuthLoadedWithuser(this.user);
}

class AuthGoogleLoading extends AuthState {}

class AuthSignUpSuccessFully extends AuthState {}

class AuthMetricsSavedSuccessfully extends AuthState {}

class AuthVerificationEmailSent extends AuthState {}

class AuthResetPasswordSuccessfully extends AuthState {}

class AuthsignOutSuccessfully extends AuthState {}

class AuthMetricsUpdatedSuccessfully extends AuthState {}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}
