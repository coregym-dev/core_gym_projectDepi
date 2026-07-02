import 'package:dartz/dartz.dart';
import 'package:flutter_coffee/features/auth/domain/repositories/auth.repository.dart';
import 'package:flutter_coffee/core/errors/auth_failure.dart';

class UpdatePasswordUseCase {
  final AuthRepository repository;

  UpdatePasswordUseCase(this.repository);

  Future<Either<AuthFailure, void>> call(UpdatePasswordParams params) {
    return repository.updatePassword(params.newPassword);
  }
}

class UpdatePasswordParams {
  final String newPassword;

  UpdatePasswordParams({
    required this.newPassword,
  });
}
