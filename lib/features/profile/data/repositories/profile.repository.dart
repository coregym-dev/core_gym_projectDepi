import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_coffee/core/services/profile_services.dart';
import 'package:flutter_coffee/features/profile/data/models/profile_model.dart';

abstract class BaseProfileRepository {
  Future<ProfileUser?> getCurrentUserProfile();
  Future<void> saveOrUpdateProfile(ProfileUser profile);
  Future<void> updateProfileImage(String imageUrl);
}

class ProfileRepositoryImpl implements BaseProfileRepository {
  ProfileService profileService;
  ProfileRepositoryImpl(this.profileService);
  @override
  Future<ProfileUser?> getCurrentUserProfile() async {
    final res = await profileService.getCurrentUserProfile();
    return res;
  }

  @override
  Future<void> saveOrUpdateProfile(ProfileUser profile) async {
    await profileService.saveOrUpdateProfile(profile);
  }

  @override
  Future<void> updateProfileImage(String imageUrl) async {
    await profileService.updateProfileImage(imageUrl);
  }
}
