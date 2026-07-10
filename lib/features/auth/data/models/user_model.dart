import 'package:flutter_coffee/features/auth/domain/entiteis/userentitey.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserModel extends UserEntity {
  UserModel({super.id, super.name, super.email, super.phone, super.height, super.weight});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['full_name'],
      email: json['email'],
      phone: json['phone'],
      height: json['height'] != null ? (json['height'] as num).toDouble() : null,
      weight: json['weight'] != null ? (json['weight'] as num).toDouble() : null,
    );
  }
  factory UserModel.fromSupabaseUser(User user) {
    return UserModel(
      id: user.id,
      email: user.email ?? '',
      name: user.userMetadata?['full_name'] ?? 'مستخدم جديد',
      phone: user.userMetadata?['phone'] ?? '',
      height: user.userMetadata?['height']?.toDouble(),
      weight: user.userMetadata?['weight']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': name,
      'email': email,
      'phone': phone,
      'height': height,
      'weight': weight,
    };
  }
}
