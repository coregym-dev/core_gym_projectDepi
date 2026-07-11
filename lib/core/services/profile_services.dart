import 'dart:io';

import 'package:flutter_coffee/features/profile/data/models/profile_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
// تأكد من استيراد اسم الملف الصحيح للموديل

class ProfileService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<ProfileUser?> getCurrentUserProfile() async {
    try {
      final user = _supabase.auth.currentUser;
      if (user == null) throw Exception('المستخدم غير مسجل دخول');

      final response = await _supabase
          .from('profile')
          .select()
          .eq('id', user.id)
          .maybeSingle();

      if (response == null) return null;
      print("==================================");
      print(response);
      print("========================================");

      return ProfileUser.fromJson(response);
    } catch (e) {
      print('خطأ أثناء جلب بيانات البروفايل: $e');
      rethrow;
    }
  }

  Future<void> saveOrUpdateProfile(ProfileUser profile) async {
    try {
      final user = _supabase.auth.currentUser;
      if (user == null) throw Exception('المستخدم غير مسجل دخول');

      // تحويل الموديل إلى Map
      final profileData = profile.toJson();

      await _supabase.from('profile').update(profileData).eq('id', user.id);
    } catch (e) {
      print('خطأ أثناء حفظ بيانات البروفايل: $e');
      rethrow;
    }
  }

  Future<void> updateProfileImage(String imageUrl) async {
    final user = _supabase.auth.currentUser;
    if (user == null) {
      throw Exception('المستخدم غير مسجل دخول');
    }

    await _supabase
        .from('profile')
        .update({'image_url': imageUrl})
        .eq('id', user.id);
  }
}
