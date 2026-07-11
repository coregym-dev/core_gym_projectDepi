// lib/features/users/data/datasources/user_remote_data_source.dart
import 'dart:io';

import 'package:flutter_coffee/core/errors/excepetions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<void> createUserProfile(UserModel user);
  Future<UserModel> getUserProfile(String uid);
  Future<void> updateUserMetrics(
    String uid,
    double height,
    double weight,
    String goal,
    String gender,
    File? imageFile,
  );
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final SupabaseClient supabaseClient;

  UserRemoteDataSourceImpl(this.supabaseClient);
  @override
  Future<void> createUserProfile(UserModel user) async {
    try {
      await supabaseClient.from('profile').upsert({
        'id': user.id,
        'email': user.email,
        'full_name': user.name,
        'phone': user.phone,
        'height': user.height,
        'weight': user.weight,
        'goal': user.goal,
        'gender': user.gender,
        'current_system_id': user.currentSystemId,
        'image_url': user.imageUrl,
      });
      print(user.id);
    } catch (e) {
      throw ServerException('Failed to save user data: $e');
    }
  }

  @override
  Future<UserModel> getUserProfile(String uid) async {
    try {
      final response = await supabaseClient
          .from('profile')
          .select()
          .eq('id', uid)
          .single();

      return UserModel.fromJson(response);
    } catch (e) {
      throw ServerException('Failed to fetch user data: $e');
    }
  }

  @override
  Future<void> updateUserMetrics(
    String uid,
    double height,
    double weight,
    String goal,
    String gender,
    File? imageFile,
  ) async {
    try {
      String? imageUrl;

      if (imageFile != null) {
        final imageExtension = imageFile.path.split('.').last;
        final imagePath = '$uid/profile.$imageExtension';

        await supabaseClient.storage
            .from('avatars')
            .upload(
              imagePath,
              imageFile,
              fileOptions: const FileOptions(upsert: true),
            );

        imageUrl = supabaseClient.storage
            .from('avatars')
            .getPublicUrl(imagePath);
      }

      final updateData = {
        'height': height,
        'weight': weight,
        'goal': goal,
        'gender': gender,
      };

      if (imageUrl != null) {
        updateData['image_url'] = imageUrl;
      }

      await supabaseClient.from('profile').update(updateData).eq('id', uid);
    } catch (e) {
      throw ServerException('Failed to update user metrics: $e');
    }
  }
}
