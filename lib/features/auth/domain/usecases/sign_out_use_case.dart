import 'package:dartz/dartz.dart';
import 'package:flutter_coffee/features/auth/domain/repositories/auth.repository.dart';
import 'package:flutter_coffee/core/errors/auth_failure.dart';

class SignOutUseCase {
  final AuthRepository repository;

  SignOutUseCase(this.repository);

  Future<Either<AuthFailure, void>> call() {
    return repository.signOut();
  }
}
