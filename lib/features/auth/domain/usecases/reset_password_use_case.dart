import 'package:dartz/dartz.dart';
import 'package:flutter_coffee/core/errors/auth_failure.dart';
import 'package:flutter_coffee/features/auth/domain/repositories/auth.repository.dart';


class ResetPasswordUseCase {
  final AuthRepository repository;

  ResetPasswordUseCase(this.repository);

  Future<Either<AuthFailure, void>> call(ResetPasswordParams params) {
    return repository.resetPassword(params.email);
  }
}

class ResetPasswordParams {
  final String email;

  ResetPasswordParams({
    required this.email,
  });
}
