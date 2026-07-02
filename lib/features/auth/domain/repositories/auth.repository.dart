import 'package:dartz/dartz.dart';
import 'package:flutter_coffee/features/auth/domain/entiteis/userentitey.dart';
import 'package:flutter_coffee/core/errors/auth_failure.dart';

abstract class AuthRepository {
  Future<Either<AuthFailure, UserEntity>> signInWithEmailAndPassword(
    String email,
    String password,
  );
  Future<Either<AuthFailure, UserEntity>> signUpWithEmailAndPassword(
    String email,
    String password,
    String username,
    String phoneNumber,
  );
  Future<Either<AuthFailure, void>> signOut();
  Future<Either<AuthFailure, UserEntity>> signInWithGoogle();
  Future<Either<AuthFailure, UserEntity>> signInWithFacebook();
  Future<Either<AuthFailure, UserEntity?>> getCurrentUser();
  Future<Either<AuthFailure, void>> resetPassword(String email);
  Future<Either<AuthFailure, void>> updatePassword(String newPassword);
  Future<Either<AuthFailure, UserEntity>> verifyEmailOTP({
    required String email,
    required String otpCode,
  });
  Future<Either<AuthFailure, void>> resendVerificationEmail(String email);
}
