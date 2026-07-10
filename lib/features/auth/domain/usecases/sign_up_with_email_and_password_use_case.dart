import 'package:dartz/dartz.dart';
import 'package:flutter_coffee/core/errors/auth_failure.dart';
import 'package:flutter_coffee/features/auth/domain/entiteis/userentitey.dart';
import 'package:flutter_coffee/features/auth/domain/repositories/auth.repository.dart';

class SignUpWithEmailAndPasswordUseCase {
  final AuthRepository repository;

  SignUpWithEmailAndPasswordUseCase(this.repository);

  Future<Either<AuthFailure, UserEntity>> call(
    SignUpWithEmailAndPasswordParams params,
  ) {
    return repository.signUpWithEmailAndPassword(
      params.email,
      params.password,
      params.username,
      params.phoneNumber,
    );
  }
}

class SignUpWithEmailAndPasswordParams {
  final String email;
  final String password;
  final String username;
  final String phoneNumber;

  SignUpWithEmailAndPasswordParams({
    required this.email,
    required this.password,
    required this.username,
    required this.phoneNumber,
  });
}
