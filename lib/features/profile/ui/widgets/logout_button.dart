import 'package:flutter/material.dart';
import 'package:flutter_coffee/core/theme/app_color.dart';
import 'package:flutter_coffee/core/constans/appConstants.dart';
import 'package:flutter_coffee/core/theme/app_color.dart';
import 'package:flutter_coffee/core/theme/app_text_styles.dart';
import 'package:flutter_coffee/core/utils/app_snackbars.dart';
import 'package:flutter_coffee/core/widget/app_state.dart';
import 'package:flutter_coffee/features/profile/ui/widgets/about_info_tile.dart';
import 'package:flutter_coffee/features/profile/ui/widgets/primary_action_btn.dart';
import 'package:flutter_coffee/features/profile/ui/widgets/profile_screen.dart';
import 'package:flutter_coffee/features/profile/ui/widgets/social_media_button.dart';

class LogoutButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isProfileStyle;

  const LogoutButton({super.key, this.onPressed, this.isProfileStyle = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          side: BorderSide(
            color: isProfileStyle
                ? AppColors.logoutRed
                : AppColors.logoutBorder,
          ),
          backgroundColor: isProfileStyle
              ? Colors.transparent
              : AppColors.logoutBackground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppConstants.buttonBorderRadius,
            ),
          ),
        ),
        child: Text(
          'Log Out',
          style: isProfileStyle
              ? AppTextStyles.logoutButtonProfile
              : AppTextStyles.logoutButton,
        ),
      ),
    );
  }
}
