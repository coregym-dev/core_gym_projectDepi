import 'package:flutter/material.dart';
import 'package:flutter_coffee/core/theme/app_color.dart';

class ExerciseSearchField extends StatelessWidget {
  const ExerciseSearchField({super.key, this.controller, this.onChanged});

  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: AppColors.cardColor,
          borderRadius: BorderRadius.circular(14),
        ),
        child: TextField(
          controller: controller,
          onChanged: onChanged,
          style: const TextStyle(color: AppColors.textPrimary, fontSize: 14),
          decoration: const InputDecoration(
            hintText: 'Search exercises...',
            hintStyle: TextStyle(color: AppColors.textSecondary, fontSize: 14),
            prefixIcon: Icon(
              Icons.search,
              color: AppColors.textSecondary,
              size: 20,
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 14),
          ),
        ),
      ),
    );
  }
}
