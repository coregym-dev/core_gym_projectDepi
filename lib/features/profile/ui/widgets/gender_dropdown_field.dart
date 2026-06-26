import 'package:flutter/material.dart';
import 'package:flutter_coffee/core/constans/appConstants.dart';
import 'package:flutter_coffee/core/theme/app_color.dart';
import 'package:flutter_coffee/core/theme/app_text_styles.dart';

class GenderDropdownField extends StatelessWidget {
  final String value;
  final ValueChanged<String?> onChanged;

  const GenderDropdownField({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Gender', style: AppTextStyles.inputLabel),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            color: AppColors.inputBackground,
            borderRadius: BorderRadius.circular(AppConstants.inputBorderRadius),
          ),
          child: DropdownButtonFormField<String>(
            value: value,
            onChanged: onChanged,
            dropdownColor: AppColors.inputBackground,
            style: AppTextStyles.inputValue,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  AppConstants.inputBorderRadius,
                ),
                borderSide: BorderSide.none,
              ),
            ),
            icon: const Icon(
              Icons.keyboard_arrow_down,
              color: AppColors.textSecondary,
              size: 20,
            ),
            items: AppConstants.genderOptions
                .map(
                  (gender) =>
                      DropdownMenuItem(value: gender, child: Text(gender)),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
