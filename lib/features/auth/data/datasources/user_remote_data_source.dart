// lib/features/users/data/datasources/user_remote_data_source.dart
import 'package:flutter_coffee/core/errors/excepetions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<void> createUserProfile(UserModel user);
  Future<UserModel> getUserProfile(String uid);
  Future<void> updateUserMetrics(String uid, double height, double weight);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final SupabaseClient supabaseClient;

  UserRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<void> createUserProfile(UserModel user) async {
    try {
      await supabaseClient.from('users').upsert({
        'id': user.id,
        'email': user.email,
        'full_name': user.name,
        'phone': user.phone,
        'height': user.height,
        'weight': user.weight,
        'created_at': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      throw ServerException('Failed to save user data: $e');
    }
  }

  @override
  Future<UserModel> getUserProfile(String uid) async {
    try {
      final response = await supabaseClient
          .from('users')
          .select()
          .eq('id', uid)
          .single();

      return UserModel.fromJson(response);
    } catch (e) {
      throw ServerException('Failed to fetch user data: $e');
    }
  }
  @override
  Future<void> updateUserMetrics(String uid, double height, double weight) async {
    try {
      await supabaseClient.from('users').update({
        'height': height,
        'weight': weight,
      }).eq('id', uid); 
    } catch (e) {
      throw ServerException('Failed to update user metrics: $e');
    }
  }
}
