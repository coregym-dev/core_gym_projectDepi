import 'package:flutter_coffee/features/auth/domain/entiteis/userentitey.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserModel extends UserEntity {
  UserModel({super.id, super.name, super.email, super.phone});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['full_name'],
      email: json['email'],
      phone: json['phone'],
    );
  }
  factory UserModel.fromSupabaseUser(User user) {
    return UserModel(
      id: user.id,
      email: user.email ?? '',
      name: user.userMetadata?['full_name'] ?? 'مستخدم جديد',
      phone: user.userMetadata?['phone'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'full_name': name, 'email': email, 'phone': phone};
  }
}
