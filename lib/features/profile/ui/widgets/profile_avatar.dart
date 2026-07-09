import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_coffee/core/constans/appConstants.dart';
import 'package:flutter_coffee/core/theme/app_color.dart';

class ProfileAvatar extends StatelessWidget {
  final String? imageUrl;
  final double size;
  final bool showCameraBadge;
  final VoidCallback? onCameraTap;

  const ProfileAvatar({
    super.key,
    required this.imageUrl,
    this.size = AppConstants.profileAvatarSize,
    this.showCameraBadge = false,
    this.onCameraTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: showCameraBadge
                    ? AppColors.borderGray500
                    : AppColors.borderGray600,
                width: 2,
              ),
            ),
            child: ClipOval(
              child: imageUrl != null
                  ? CachedNetworkImage(
                      imageUrl: imageUrl!,
                      fit: showCameraBadge ? BoxFit.cover : BoxFit.cover,
                      alignment: showCameraBadge
                          ? const Alignment(0, -0.5)
                          : Alignment.center,
                      errorWidget: (_, _, _) => const Icon(
                        Icons.person,
                        color: AppColors.textSecondary,
                        size: 48,
                      ),
                    )
                  : Icon(Icons.person),
            ),
          ),
          if (showCameraBadge)
            Positioned(
              right: 0,
              bottom: 0,
              child: GestureDetector(
                onTap: onCameraTap,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.accentColor,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.backgroundColor,
                      width: 2,
                    ),
                  ),
                  child: const Icon(
                    Icons.camera_alt_outlined,
                    size: 16,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
