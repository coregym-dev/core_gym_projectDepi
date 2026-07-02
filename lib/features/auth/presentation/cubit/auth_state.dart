import 'package:flutter_coffee/features/auth/domain/entiteis/userentitey.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthGoogleLoading extends AuthState {}

class AuthFacebookLoading extends AuthState {}

class AuthLoadedWithuser extends AuthState {
  final UserEntity user;
  AuthLoadedWithuser(this.user);
}

class AuthSignUpSuccessFully extends AuthState {}

class AuthVerificationEmailSent extends AuthState {}

class AuthResetPasswordSuccessfully extends AuthState {}

class AuthsignOutSuccessfully extends AuthState {}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}
