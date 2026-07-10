import 'package:supabase_flutter/supabase_flutter.dart';

class UserEntity {
  final String id;
  final String name;
  final String email;
  final String phone;
  final double? height;
  final double? weight;
  final String? goal;
  final String? gender;
  final dynamic currentSystemId;
  final String? imageUrl;

  UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.height,
    this.weight,
    this.goal,
    this.gender,
    this.currentSystemId,
    this.imageUrl,
  });
}
