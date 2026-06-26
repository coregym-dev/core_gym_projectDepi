import 'package:flutter/material.dart';
import 'package:flutter_coffee/core/theme/app_color.dart';
import 'package:flutter_coffee/core/theme/app_text_styles.dart';

class MembershipBadge extends StatelessWidget {
  const MembershipBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.star, size: 16, color: AppColors.gold),
        const SizedBox(width: 4),
        Text('GOLD MEMBER', style: AppTextStyles.membershipBadge),
      ],
    );
  }
}
