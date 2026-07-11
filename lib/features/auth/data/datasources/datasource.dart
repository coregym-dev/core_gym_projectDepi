import 'package:flutter_coffee/core/errors/excepetions.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> signUpWithEmailAndPassword(String email, String password);
  Future<void> saveUserDataToDatabase(UserModel user);
  Future<UserModel> getUserDataFromDatabase(String uid);
  Future<UserModel> signInWithEmailAndPassword(String email, String password);
  Future<UserModel> verifyEmailOTP({
    required String email,
    required String otpCode,
  });
  Future<void> resendVerificationEmail(String email);
  Future<void> signInWithGoogle();
  Future<void> resetPassword(String email);
  Future<void> updatePassword(String newPassword);
  Future<void> signOut();
  User? getCurrentSupabaseUser();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;

  AuthRemoteDataSourceImpl(this.supabaseClient);

  @override
  User? getCurrentSupabaseUser() {
    return supabaseClient.auth.currentUser;
  }

  @override
  Future<UserModel> signUpWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final response = await supabaseClient.auth.signUp(
      email: email,
      password: password,
    );
    print(response.user);
    print(response.session);
    if (response.user == null) {
      throw const ServerException('Sign up failed: User is null');
    }
    return UserModel.fromSupabaseUser(response.user!);
  }

  @override
  Future<void> saveUserDataToDatabase(UserModel user) async {
    await supabaseClient.from('profile').upsert(user.toJson());
  }

  @override
  Future<UserModel> getUserDataFromDatabase(String uid) async {
    final response = await supabaseClient
        .from('profile')
        .select()
        .eq('id', uid)
        .single();

    return UserModel.fromJson(response);
  }

  @override
  Future<UserModel> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final response = await supabaseClient.auth.signInWithPassword(
      email: email,
      password: password,
    );
    if (response.user == null) {
      throw const ServerException('Login failed: User is null');
    }
    return UserModel.fromSupabaseUser(response.user!);
  }

  @override
  Future<UserModel> verifyEmailOTP({
    required String email,
    required String otpCode,
  }) async {
    final response = await supabaseClient.auth.verifyOTP(
      email: email,
      token: otpCode,
      type: OtpType.signup,
    );
    if (response.user == null) {
      throw const ServerException('Verification failed');
    }
    return UserModel.fromSupabaseUser(response.user!);
  }

  @override
  Future<void> resendVerificationEmail(String email) async {
    await supabaseClient.auth.resend(type: OtpType.signup, email: email);
  }

  @override
  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(
        serverClientId:
            '157339110583-d7tnr2pii0bvt4epu7oo3fo96ebc8t7m.apps.googleusercontent.com',
      );

      final googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        return;
      }

      final googleAuth = await googleUser.authentication;
      final idToken = googleAuth.idToken;
      final accessToken = googleAuth.accessToken;

      if (accessToken == null || idToken == null) {
        throw const ServerException('Missing Google auth tokens');
      }

      final authResponse = await supabaseClient.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );

      if (authResponse.user == null) {
        throw const ServerException('Supabase auth failed');
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> resetPassword(String email) async {
    await supabaseClient.auth.resetPasswordForEmail(email);
  }

  @override
  Future<void> updatePassword(String newPassword) async {
    await supabaseClient.auth.updateUser(UserAttributes(password: newPassword));
  }

  @override
  Future<void> signOut() async {
    await supabaseClient.auth.signOut();
  }
}
