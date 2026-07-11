import 'package:flutter_coffee/features/auth/domain/entiteis/userentitey.dart';

class GoogleSignInResult {
  final UserEntity user;
  final bool isNewUser;

  GoogleSignInResult({required this.user, required this.isNewUser});
}
