import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_coffee/core/constans/appConstants.dart';
import 'package:flutter_coffee/core/theme/app_color.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    super.key,
    this.localImagePath,
    this.backendImagePath,
    this.onTap,
    this.size = AppConstants.profileAvatarSize,
  });

  final String? localImagePath;
  final String? backendImagePath;
  final VoidCallback? onTap;
  final double size;

  @override
  Widget build(BuildContext context) {
    ImageProvider? image;

    if (localImagePath != null && localImagePath!.isNotEmpty) {
      image = FileImage(File(localImagePath!));
    } else if (backendImagePath != null && backendImagePath!.isNotEmpty) {
      image = FileImage(
        File(Uri.parse(backendImagePath!).toFilePath()),
      );
    }

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.borderGray500,
                width: 2,
              ),
            ),
            child: ClipOval(
              child: image != null
                  ? Image(
                      image: image,
                      fit: BoxFit.cover,
                    )
                  : const Icon(
                      Icons.person,
                      size: 50,
                      color: AppColors.textSecondary,
                    ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: InkWell(
              onTap: onTap,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.borderGray600,
                ),
                child: const Icon(
                  Icons.camera_alt,
                  size: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}