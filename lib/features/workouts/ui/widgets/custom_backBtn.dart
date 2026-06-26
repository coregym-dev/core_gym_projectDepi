import 'package:flutter/material.dart';
import 'package:flutter_coffee/core/theme/app_color.dart';

class CustomBackButton extends StatelessWidget {
  final VoidCallback? onTap;
  final double? width;
  const CustomBackButton({super.key, this.onTap, this.width});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () => Navigator.pop(context),
      child: Container(
        width: width,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.backgroundColor.withOpacity(0.7),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white10),
        ),
        child: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }
}
