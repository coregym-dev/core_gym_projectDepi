import 'package:flutter_coffee/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:flutter_coffee/features/auth/data/datasources/datasource.dart';
import 'package:flutter_coffee/features/auth/data/datasources/user_remote_data_source.dart';
import 'package:flutter_coffee/features/auth/data/repositories/auth.repository_impl.dart';
import 'package:flutter_coffee/features/auth/domain/repositories/auth.repository.dart';
import 'package:flutter_coffee/features/auth/domain/usecases/get_current_user_use_case.dart';
import 'package:flutter_coffee/features/auth/domain/usecases/resend_verification_email_use_case.dart';
import 'package:flutter_coffee/features/auth/domain/usecases/reset_password_use_case.dart';
import 'package:flutter_coffee/features/auth/domain/usecases/sign_in_with_email_and_password_use_case.dart';
import 'package:flutter_coffee/features/auth/domain/usecases/sign_in_with_google_use_case.dart';
import 'package:flutter_coffee/features/auth/domain/usecases/sign_out_use_case.dart';
import 'package:flutter_coffee/features/auth/domain/usecases/sign_up_with_email_and_password_use_case.dart';
import 'package:flutter_coffee/features/auth/domain/usecases/update_password_use_case.dart';
import 'package:flutter_coffee/features/auth/domain/usecases/user_metrics_use_case.dart';
import 'package:flutter_coffee/features/auth/domain/usecases/verify_email_otp_use_case.dart';
import 'package:flutter_coffee/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final sl = GetIt.instance;

void initAuthDependencies() {
  sl.registerLazySingleton<SupabaseClient>(() => Supabase.instance.client);

  // ==================== Data Sources ====================
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(),
  );
  sl.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      sl(),
      localDataSource: sl(),
      userRemoteDataSource: sl(),
    ),
  );

  sl.registerLazySingleton(() => SignUpWithEmailAndPasswordUseCase(sl()));
  sl.registerLazySingleton(() => VerifyEmailOTPUseCase(sl()));
  sl.registerLazySingleton(() => ResendVerificationEmailUseCase(sl()));
  sl.registerLazySingleton(() => SignInWithEmailAndPasswordUseCase(sl()));
  sl.registerLazySingleton(() => SignInWithGoogleUseCase(sl()));
  sl.registerLazySingleton(() => ResetPasswordUseCase(sl()));
  sl.registerLazySingleton(() => SignOutUseCase(sl()));
  sl.registerLazySingleton(() => UpdatePasswordUseCase(sl()));
  sl.registerLazySingleton(() => GetCurrentUserUseCase(sl()));

  sl.registerLazySingleton(() => UpdateMetricsUseCase(sl()));

  sl.registerFactory<AuthCubit>(
    () => AuthCubit(
      sl(), // signUpWithEmailAndPasswordUseCase
      sl(), // verifyEmailOTPUseCase
      sl(), // resendVerificationEmailUseCase
      sl(), // signInWithEmailAndPasswordUseCase
      sl(), // signInWithGoogleUseCase
      sl(), // signInWithFacebookUseCase
      sl(), // resetPasswordUseCase
      sl(), // signOutUseCase
      sl(), // updatePasswordUseCase
      sl(), // getCurrentUserUseCase
    ),
  );
}
