import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_coffee/features/auth/domain/usecases/sign_up_with_email_and_password_use_case.dart';
import 'package:flutter_coffee/features/auth/domain/usecases/user_metrics_use_case.dart';
import 'package:flutter_coffee/features/auth/domain/usecases/verify_email_otp_use_case.dart';

import 'package:flutter_coffee/features/auth/domain/usecases/get_current_user_use_case.dart';
import 'package:flutter_coffee/features/auth/domain/usecases/resend_verification_email_use_case.dart';
import 'package:flutter_coffee/features/auth/domain/usecases/reset_password_use_case.dart';
import 'package:flutter_coffee/features/auth/domain/usecases/sign_in_with_email_and_password_use_case.dart';
import 'package:flutter_coffee/features/auth/domain/usecases/sign_in_with_google_use_case.dart';
import 'package:flutter_coffee/features/auth/domain/usecases/sign_out_use_case.dart';
import 'package:flutter_coffee/features/auth/domain/usecases/update_password_use_case.dart';

import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SignUpWithEmailAndPasswordUseCase signUpWithEmailAndPasswordUseCase;
  final VerifyEmailOTPUseCase verifyEmailOTPUseCase;
  final ResendVerificationEmailUseCase resendVerificationEmailUseCase;
  final SignInWithEmailAndPasswordUseCase signInWithEmailAndPasswordUseCase;
  final SignInWithGoogleUseCase signInWithGoogleUseCase;
  final ResetPasswordUseCase resetPasswordUseCase;
  final SignOutUseCase signOutUseCase;
  final UpdatePasswordUseCase updatePasswordUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final UpdateMetricsUseCase updateMetricsUseCase;

  AuthCubit(
    this.signUpWithEmailAndPasswordUseCase,
    this.verifyEmailOTPUseCase,
    this.resendVerificationEmailUseCase,
    this.signInWithEmailAndPasswordUseCase,
    this.signInWithGoogleUseCase,
    this.resetPasswordUseCase,
    this.signOutUseCase,
    this.updatePasswordUseCase,
    this.getCurrentUserUseCase,
    this.updateMetricsUseCase,
  ) : super(AuthInitial());

  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String username,
    required String phoneNumber,
  }) async {
    emit(AuthLoading());
    final result = await signUpWithEmailAndPasswordUseCase(
      SignUpWithEmailAndPasswordParams(
        email: email,
        password: password,
        username: username,
        phoneNumber: phoneNumber,
      ),
    );
    result.fold((failure) {
      print(
        '================ SUPABASE ERROR: ${failure.errMessage} ================',
      );
      emit(AuthError(failure.errMessage));
    }, (user) => emit(AuthSignUpSuccessFully()));
  }

  Future<void> verifyEmailOTP({
    required String email,
    required String otpCode,
  }) async {
    emit(AuthLoading());
    final result = await verifyEmailOTPUseCase(
      VerifyEmailOTPParams(email: email, otpCode: otpCode),
    );
    result.fold(
      (failure) => emit(AuthError(failure.errMessage)),
      (user) => emit(AuthLoadedWithuser(user)),
    );
  }

  Future<void> resendVerificationEmail(String email) async {
    emit(AuthLoading());
    final result = await resendVerificationEmailUseCase(
      ResendVerificationEmailParams(email: email),
    );
    result.fold(
      (failure) => emit(AuthError(failure.errMessage)),
      (_) => emit(AuthVerificationEmailSent()),
    );
  }

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    final result = await signInWithEmailAndPasswordUseCase(
      SignInWithEmailAndPasswordParams(email: email, password: password),
    );
    result.fold(
      (failure) => emit(AuthError(failure.errMessage)),
      (user) => emit(AuthLoadedWithuser(user)),
    );
  }

  Future<void> signInWithGoogle() async {
    emit(AuthGoogleLoading());
    final result = await signInWithGoogleUseCase();
    result.fold(
      (failure) => emit(AuthError(failure.errMessage)),
      (user) => emit(AuthLoadedWithuser(user)),
    );
  }

  Future<void> resetPassword(String email) async {
    emit(AuthLoading());
    final result = await resetPasswordUseCase(
      ResetPasswordParams(email: email),
    );
    result.fold(
      (failure) => emit(AuthError(failure.errMessage)),
      (_) => emit(AuthResetPasswordSuccessfully()),
    );
  }

  Future<void> signOut() async {
    emit(AuthLoading());
    final result = await signOutUseCase();
    result.fold(
      (failure) => emit(AuthError(failure.errMessage)),
      (_) => emit(AuthsignOutSuccessfully()),
    );
  }

  Future<void> updateUserMetrics({
    required double weight,
    required double height,
  }) async {
    emit(AuthLoading());
    try {
      final userResult = await getCurrentUserUseCase();

      userResult.fold(
        (failure) {
          emit(AuthError("User not found"));
        },
        (user) async {
          final result = await updateMetricsUseCase(
            UpdateMetricsParams(uid: user!.id!, height: height, weight: weight),
          );

          // 3. نتعامل مع نتيجة التحديث
          result.fold(
            (failure) => emit(AuthError(failure.errMessage)),
            (_) => emit(AuthMetricsUpdatedSuccessfully()),
          );
        },
      );
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
