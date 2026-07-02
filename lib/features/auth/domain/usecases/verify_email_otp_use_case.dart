import 'package:dartz/dartz.dart';
import 'package:flutter_coffee/features/auth/domain/entiteis/userentitey.dart';
import 'package:flutter_coffee/features/auth/domain/repositories/auth.repository.dart';
import 'package:flutter_coffee/core/errors/auth_failure.dart';

class VerifyEmailOTPUseCase {
  final AuthRepository repository;

  VerifyEmailOTPUseCase(this.repository);

  Future<Either<AuthFailure, UserEntity>> call(VerifyEmailOTPParams params) {
    return repository.verifyEmailOTP(
      email: params.email,
      otpCode: params.otpCode,
    );
  }
}

class VerifyEmailOTPParams {
  final String email;
  final String otpCode;

  VerifyEmailOTPParams({
    required this.email,
    required this.otpCode,
  });
}
