import 'package:flutter_coffee/features/auth/domain/entiteis/userentitey.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.name,
    required super.email,
    required super.phone,
    super.height,
    super.weight,
    super.goal,
    super.gender,
    super.currentSystemId,
    super.imageUrl, // ضفناه هنا
  });

  // قراءة البيانات من جدول profile
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? json['user_id'] ?? '',
      name: json['full_name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      height: json['height'] != null
          ? (json['height'] as num).toDouble()
          : null,
      weight: json['weight'] != null
          ? (json['weight'] as num).toDouble()
          : null,
      goal: json['goal'],
      gender: json['gender'],
      currentSystemId: json['current_system_id'],
      imageUrl: json['image_url'], // بيقرأ مسار الصورة من الداتابيز
    );
  }

  // قراءة البيانات وقت التسجيل لأول مرة (من المصادقة)
  factory UserModel.fromSupabaseUser(User user) {
    return UserModel(
      id: user.id,
      email: user.email ?? '',
      name: user.userMetadata?['full_name'] ?? 'مستخدم جديد',
      phone: user.userMetadata?['phone'] ?? '',
      height: user.userMetadata?['height']?.toDouble(),
      weight: user.userMetadata?['weight']?.toDouble(),
      goal: user.userMetadata?['goal'],
      gender: user.userMetadata?['gender'],
      currentSystemId: user.userMetadata?['current_system_id'],
      imageUrl: user.userMetadata?['image_url'], // بيقرأ مسار الصورة
    );
  }

  // رفع البيانات للداتابيز
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': name,
      'email': email,
      'phone': phone,
      'height': height,
      'weight': weight,
      'goal': goal,
      'gender': gender,
      'current_system_id': currentSystemId,
      'image_url': imageUrl,
    };
  }
}
