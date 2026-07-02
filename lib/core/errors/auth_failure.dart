import 'package:supabase_flutter/supabase_flutter.dart';

import 'failures.dart';

class AuthFailure extends Failure {
  const AuthFailure(super.errMessage);

  factory AuthFailure.fromSupabase(AuthException exception) {
    final message = exception.message.toLowerCase();

    if (message.contains('invalid login credentials')) {
      return const AuthFailure('Invalid email or password.');
    } else if (message.contains('user already registered')) {
      return const AuthFailure('This email is already registered.');
    } else if (message.contains('password should be at least')) {
      return const AuthFailure(
        'Password is too weak. Please use a stronger password.',
      );
    } else if (message.contains('email rate limit exceeded')) {
      return const AuthFailure('Too many requests. Please try again later.');
    } else if (message.contains('email not confirmed')) {
      return const AuthFailure('Please verify your email address first.');
    } else {
      return AuthFailure(exception.message);
    }
  }
}
