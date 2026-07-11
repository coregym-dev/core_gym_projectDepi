import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_coffee/core/errors/auth_failure.dart';
import 'package:flutter_coffee/features/auth/data/models/googel_model.dart';
import 'package:flutter_coffee/features/auth/domain/entiteis/userentitey.dart';

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
  Future<Either<AuthFailure, GoogleSignInResult>> signInWithGoogle();
  Future<Either<AuthFailure, UserEntity?>> getCurrentUser();
  Future<Either<AuthFailure, void>> resetPassword(String email);
  Future<Either<AuthFailure, void>> updatePassword(String newPassword);
  Future<Either<AuthFailure, UserEntity>> verifyEmailOTP({
    required String email,
    required String otpCode,
  });
  Future<Either<AuthFailure, void>> resendVerificationEmail(String email);
  Future<bool> isLoggedIn();
  Future<Either<AuthFailure, void>> updateUserMetrics({
    required String uid,
    required double height,
    required double weight,
    required String goal,
    required String gender,
    File? imageFile,
  });
}
