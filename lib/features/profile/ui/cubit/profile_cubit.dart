import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter_coffee/features/profile/data/models/profile_model.dart';
import 'package:flutter_coffee/features/profile/data/repositories/profile.repository.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  BaseProfileRepository repo;
  ProfileCubit(this.repo) : super(ProfileInitial());
  ProfileUser? profile;
  Future getCurrentUserProfileCubit() async {
    emit(ProfileLoading());
    try {
      final response = await repo.getCurrentUserProfile();
      profile = response;
      print("==================================");
      print(response);
      print("========================================");

      emit(ProfileSuccess(profile: response));
    } catch (e) {
      print("#####################################");
      print(e.toString());
      emit(ProfileError(e.toString()));
    }
  }

  Future saveOrUpdateProfile(ProfileUser profile) async {
    emit(ProfileLoading());
    try {
      await repo.saveOrUpdateProfile(profile);
      await getCurrentUserProfileCubit();
    } catch (e) {
      print("#####################################");
      print(e.toString());
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> updateProfileImage(String imageUrl) async {
    try {
      await repo.updateProfileImage(imageUrl);
      await getCurrentUserProfileCubit();
    } catch (e) {
      print("#####################################");
      print(e.toString());
      emit(ProfileError(e.toString()));
    }
  }
}
