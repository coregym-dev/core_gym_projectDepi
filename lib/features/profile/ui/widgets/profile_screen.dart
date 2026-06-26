import 'package:flutter/material.dart';
import 'package:flutter_coffee/core/theme/app_color.dart';
import 'package:flutter_coffee/core/theme/app_text_styles.dart';

class ProfileScreenHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onBack;
  final bool useLargeTitle;

  const ProfileScreenHeader({
    super.key,
    required this.title,
    this.onBack,
    this.useLargeTitle = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: onBack ?? () => Navigator.pop(context),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.textPrimary,
            size: 24,
          ),
        ),
        Expanded(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: useLargeTitle
                ? AppTextStyles.screenTitleLarge
                : AppTextStyles.screenTitle,
          ),
        ),
        const SizedBox(width: 24),
      ],
    );
  }
}
