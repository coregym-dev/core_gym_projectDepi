import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:flutter_coffee/features/auth/presentation/cubit/auth_cubit.dart';

import 'package:flutter_coffee/features/auth/domain/usecases/index.dart';

import 'package:flutter_coffee/features/auth/domain/repositories/auth.repository.dart';
import 'package:flutter_coffee/features/auth/data/repositories/auth.repository_impl.dart';

import 'package:flutter_coffee/features/auth/data/datasources/datasource.dart';
import 'package:flutter_coffee/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:flutter_coffee/features/auth/data/datasources/user_remote_data_source.dart';

final sl = GetIt.instance;

void initAuthDependencies() {
  sl.registerLazySingleton<SupabaseClient>(() => Supabase.instance.client);

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

  sl.registerFactory(() => AuthCubit(sl(), sl(), sl(), sl(), sl(), sl(), sl()));
}
