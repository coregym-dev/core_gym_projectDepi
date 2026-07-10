import 'package:dartz/dartz.dart';
import 'package:flutter_coffee/core/errors/auth_failure.dart';
import 'package:flutter_coffee/features/auth/domain/entiteis/userentitey.dart';
import 'package:flutter_coffee/features/auth/domain/repositories/auth.repository.dart';

class SignInWithEmailAndPasswordUseCase {
  final AuthRepository repository;

  SignInWithEmailAndPasswordUseCase(this.repository);

  Future<Either<AuthFailure, UserEntity>> call(SignInWithEmailAndPasswordParams params) {
    return repository.signInWithEmailAndPassword(params.email, params.password);
  }
}

class SignInWithEmailAndPasswordParams {
  final String email;
  final String password;

  SignInWithEmailAndPasswordParams({
    required this.email,
    required this.password,
  });
}
