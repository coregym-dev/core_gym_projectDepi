import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_coffee/core/errors/auth_failure.dart';
import 'package:flutter_coffee/core/errors/excepetions.dart';

import 'package:flutter_coffee/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:flutter_coffee/features/auth/data/datasources/datasource.dart';
import 'package:flutter_coffee/features/auth/data/datasources/user_remote_data_source.dart';
import 'package:flutter_coffee/features/auth/data/models/googel_model.dart';
import 'package:flutter_coffee/features/auth/data/models/user_model.dart';
import 'package:flutter_coffee/features/auth/domain/entiteis/userentitey.dart';
import 'package:flutter_coffee/features/auth/domain/repositories/auth.repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  final UserRemoteDataSource userRemoteDataSource;

  const AuthRepositoryImpl(
    this.remoteDataSource, {
    required this.localDataSource,
    required this.userRemoteDataSource,
  });

  @override
  Future<Either<AuthFailure, UserEntity?>> getCurrentUser() async {
    try {
      final user = remoteDataSource.getCurrentSupabaseUser();
      if (user != null) {
        final cashuser = await localDataSource.getCachedUserData();
        if (cashuser != null) {
          return right(cashuser);
        } else {
          final userProfile = await userRemoteDataSource.getUserProfile(
            user.id,
          );

          await localDataSource.cacheUserData(userProfile);

          return right(userProfile);
        }
      } else {
        return right(null);
      }
    } on ServerException catch (e) {
      return left(AuthFailure(e.message));
    } on CacheException catch (e) {
      return left(AuthFailure(e.message));
    } catch (e) {
      return left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<AuthFailure, UserEntity>> signUpWithEmailAndPassword(
    String email,
    String password,
    String username,
    String phoneNumber,
  ) async {
    try {
      final userModel = await remoteDataSource.signUpWithEmailAndPassword(
        email,
        password,
      );
      final userProfileModel = UserModel(
        id: userModel.id,
        email: email,
        name: username,
        phone: phoneNumber,
      );
      print("Auth User ID: ${userModel.id}");
      await userRemoteDataSource.createUserProfile(userProfileModel);
      print("Auth User ID: ${userModel.id}");
      await localDataSource.cacheUserData(userProfileModel);
      return right(userProfileModel);
    } on ServerException catch (e) {
      return left(AuthFailure(e.message));
    } on CacheException catch (e) {
      return left(AuthFailure(e.message));
    } catch (e) {
      return left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<AuthFailure, UserEntity>> verifyEmailOTP({
    required String email,
    required String otpCode,
  }) async {
    try {
      final userModel = await remoteDataSource.verifyEmailOTP(
        email: email,
        otpCode: otpCode,
      );
      await localDataSource.cacheUserData(userModel);
      return right(userModel);
    } on ServerException catch (e) {
      return left(AuthFailure(e.message));
    } on CacheException catch (e) {
      return left(AuthFailure(e.message));
    } catch (e) {
      return left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<AuthFailure, void>> resendVerificationEmail(
    String email,
  ) async {
    try {
      await remoteDataSource.resendVerificationEmail(email);
      return right(null);
    } on ServerException catch (e) {
      return left(AuthFailure(e.message));
    } on CacheException catch (e) {
      return left(AuthFailure(e.message));
    } catch (e) {
      return left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<AuthFailure, UserEntity>> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final userModel = await remoteDataSource.signInWithEmailAndPassword(
        email,
        password,
      );
      final userProfileModel = await userRemoteDataSource.getUserProfile(
        userModel.id!,
      );
      await localDataSource.cacheUserData(userProfileModel);
      return right(userProfileModel);
    } on ServerException catch (e) {
      return left(AuthFailure(e.message));
    } on CacheException catch (e) {
      return left(AuthFailure(e.message));
    } catch (e) {
      return left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<AuthFailure, GoogleSignInResult>> signInWithGoogle() async {
    try {
      await remoteDataSource.signInWithGoogle();
      final user = remoteDataSource.getCurrentSupabaseUser();

      if (user == null) {
        return left(const AuthFailure('Login failed: No user found'));
      }

      try {
        final existingProfile = await userRemoteDataSource.getUserProfile(
          user.id,
        );

        await localDataSource.cacheUserData(existingProfile);
        return right(
          GoogleSignInResult(user: existingProfile, isNewUser: false),
        );
      } catch (e) {
        final newUserModel = UserModel(
          id: user.id,
          email: user.email ?? '',
          name: user.userMetadata?['full_name'] ?? 'Google User',
          phone: '',
        );
        print(user?.id);
        print(user?.email);

        await userRemoteDataSource.createUserProfile(newUserModel);
        await localDataSource.cacheUserData(newUserModel);
        return right(GoogleSignInResult(user: newUserModel, isNewUser: true));
      }
    } on ServerException catch (e) {
      return left(AuthFailure(e.message));
    } on CacheException catch (e) {
      return left(AuthFailure(e.message));
    } catch (e) {
      return left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<AuthFailure, void>> resetPassword(String email) async {
    try {
      await remoteDataSource.resetPassword(email);
      return right(null);
    } on ServerException catch (e) {
      return left(AuthFailure(e.message));
    } on CacheException catch (e) {
      return left(AuthFailure(e.message));
    } catch (e) {
      return left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<AuthFailure, void>> updatePassword(String newPassword) async {
    try {
      await remoteDataSource.updatePassword(newPassword);
      return right(null);
    } on ServerException catch (e) {
      return left(AuthFailure(e.message));
    } on CacheException catch (e) {
      return left(AuthFailure(e.message));
    } catch (e) {
      return left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<AuthFailure, void>> signOut() async {
    try {
      await remoteDataSource.signOut();
      return right(null);
    } on ServerException catch (e) {
      return left(AuthFailure(e.message));
    } on CacheException catch (e) {
      return left(AuthFailure(e.message));
    } catch (e) {
      return left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    return await remoteDataSource.isLoggedIn();
  }

  @override
  Future<Either<AuthFailure, void>> updateUserMetrics({
    required String uid,
    required double height,
    required double weight,
    required String goal,
    required String gender,
    File? imageFile,
  }) async {
    try {
      await userRemoteDataSource.updateUserMetrics(
        uid,
        height,
        weight,
        goal,
        gender,
        imageFile,
      );

      return right(null); // نجاح
    } on ServerException catch (e) {
      return left(AuthFailure(e.message));
    } on CacheException catch (e) {
      return left(AuthFailure(e.message));
    } catch (e) {
      return left(const AuthFailure('حدث خطأ غير متوقع أثناء حفظ البيانات.'));
    }
  }
}
