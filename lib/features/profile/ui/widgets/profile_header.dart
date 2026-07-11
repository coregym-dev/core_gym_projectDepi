import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_coffee/core/theme/app_color.dart';
import 'package:flutter_coffee/core/theme/app_text_styles.dart';
import 'package:flutter_coffee/features/profile/data/models/profile_model.dart';
import 'package:flutter_coffee/features/profile/ui/cubit/profile_cubit.dart';
import 'package:flutter_coffee/features/profile/ui/widgets/edit_profile_screen.dart';
import 'package:flutter_coffee/features/profile/ui/widgets/profile_avatar.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ProfileCubit, ProfileState, ProfileUser?>(
      selector: (state) {
        if (state is ProfileSuccess) {
          return state.profile;
        }
        return null;
      },
      builder: (context, profile) {
        if (profile == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EditProfileScreen(
                      initialImage: profile.imageUrl != null
                          ? File(Uri.parse(profile.imageUrl!).toFilePath())
                          : null,
                      name: profile.fullName,
                      email: profile.email,
                      height: profile.height?.toString(),
                      Weight: profile.weight?.toString(),
                    ),
                  ),
                );
              },
              child: ProfileAvatar(backendImagePath: profile.imageUrl),
            ),
            const SizedBox(height: 16),
            Text(
              profile.fullName ?? "Unknown User",
              style: AppTextStyles.profileName,
            ),
          ],
        );
      },
    );
  }
}
