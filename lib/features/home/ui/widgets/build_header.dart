import 'package:flutter/material.dart';
import 'package:flutter_coffee/core/theme/app_color.dart';
import 'package:flutter_coffee/core/widget/custom_text.dart';

class BuildHeader extends StatelessWidget {
  const BuildHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // نص التحية
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: 'Good Morning',
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
              Row(
                children: [
                  CustomText(
                    text: 'Ahmed ',
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                  const Text('🔥', style: TextStyle(fontSize: 22)),
                ],
              ),
            ],
          ),
        ),
        // زر الإشعارات

        // صورة البروفايل
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.accentColor, width: 2),
          ),
          child: ClipOval(
            child: Image.network(
              'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100&h=100&fit=crop',
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) =>
                  const Icon(Icons.person, color: AppColors.textSecondary),
            ),
          ),
        ),
      ],
    );
  }
}
