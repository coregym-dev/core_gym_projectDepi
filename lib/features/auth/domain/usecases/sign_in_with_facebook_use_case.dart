import 'package:dartz/dartz.dart';
import 'package:flutter_coffee/features/auth/domain/entiteis/userentitey.dart';
import 'package:flutter_coffee/features/auth/domain/repositories/auth.repository.dart';
import 'package:flutter_coffee/core/errors/auth_failure.dart';

class SignInWithFacebookUseCase {
  final AuthRepository repository;

  SignInWithFacebookUseCase(this.repository);

  Future<Either<AuthFailure, UserEntity>> call() {
    return repository.signInWithFacebook();
  }
}
