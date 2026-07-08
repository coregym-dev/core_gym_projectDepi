import 'package:flutter/material.dart';
import 'package:flutter_coffee/core/theme/app_color.dart';
import 'package:flutter_coffee/core/widget/custom_text.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          text: title,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
      ],
    );
  }
}
