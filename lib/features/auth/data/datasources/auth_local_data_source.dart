
import 'package:flutter_coffee/core/errors/excepetions.dart';
import 'package:hive/hive.dart';

import '../models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheUserData(UserModel user);
  Future<UserModel?> getCachedUserData();
  Future<void> clearCachedUser();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final String _kUserBoxName = 'user_box';
  final String _kUserKey = 'cached_user';

  @override
  Future<void> cacheUserData(UserModel user) async {
    try {
      final box = Hive.box(_kUserBoxName);
      await box.put(_kUserKey, user.toJson());
    } catch (e) {
      throw const CacheException('Failed to cache user data');
    }
  }

  @override
  Future<UserModel?> getCachedUserData() async {
    try {
      final box = Hive.box(_kUserBoxName);
      final jsonMap = box.get(_kUserKey);

      if (jsonMap != null) {
        return UserModel.fromJson(Map<String, dynamic>.from(jsonMap));
      }
      return null;
    } catch (e) {
      throw const CacheException('Failed to read cached user data');
    }
  }

  @override
  Future<void> clearCachedUser() async {
    try {
      final box = Hive.box(_kUserBoxName);
      await box.delete(_kUserKey);
    } catch (e) {
      throw const CacheException('Failed to clear cached user data');
    }
  }
}
