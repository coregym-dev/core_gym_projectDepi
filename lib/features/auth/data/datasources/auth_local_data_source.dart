import 'package:flutter_coffee/core/errors/excepetions.dart';
import 'package:flutter_coffee/features/auth/data/models/user_model.dart';
import 'package:hive/hive.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheUserData(UserModel user);
  Future<UserModel?> getCachedUserData();
  Future<void> clearCachedUser();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final String _kUserBoxName = 'user_box';
  final String _kUserKey = 'cached_user';

  Future<Box> _getBox() async {
    if (Hive.isBoxOpen(_kUserBoxName)) {
      return Hive.box(_kUserBoxName);
    } else {
      return await Hive.openBox(_kUserBoxName);
    }
  }

  @override
  Future<void> cacheUserData(UserModel user) async {
    try {
      final box = await _getBox();
      await box.put(_kUserKey, user.toJson());
    } catch (e) {
      throw CacheException('Failed to cache user data: $e');
    }
  }

  @override
  Future<UserModel?> getCachedUserData() async {
    try {
      final box = await _getBox();
      final jsonMap = box.get(_kUserKey);

      if (jsonMap != null) {
        final map = Map<String, dynamic>.from(jsonMap as Map);
        return UserModel.fromJson(map);
      }
      return null;
    } catch (e) {
      throw CacheException('Failed to read cached user data: $e');
    }
  }

  @override
  Future<void> clearCachedUser() async {
    try {
      final box = await _getBox();
      await box.delete(_kUserKey);
    } catch (e) {
      throw CacheException('Failed to clear cached user data: $e');
    }
  }
}
