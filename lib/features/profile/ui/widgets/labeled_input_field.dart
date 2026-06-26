import 'package:flutter/material.dart';
import 'package:flutter_coffee/core/constans/appConstants.dart';
import 'package:flutter_coffee/core/theme/app_color.dart';
import 'package:flutter_coffee/core/theme/app_text_styles.dart';
import 'package:flutter_coffee/core/utils/app_snackbars.dart';
import 'package:flutter_coffee/core/widget/app_state.dart';
import 'package:flutter_coffee/features/profile/ui/widgets/about_info_tile.dart';
import 'package:flutter_coffee/features/profile/ui/widgets/primary_action_btn.dart';
import 'package:flutter_coffee/features/profile/ui/widgets/profile_screen.dart';
import 'package:flutter_coffee/features/profile/ui/widgets/social_media_button.dart';

class LabeledInputField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final String? initialValue;
  final TextInputType keyboardType;
  final bool readOnly;
  final VoidCallback? onTap;
  final String? Function(String?)? validator;

  const LabeledInputField({
    super.key,
    required this.label,
    this.controller,
    this.initialValue,
    this.keyboardType = TextInputType.text,
    this.readOnly = false,
    this.onTap,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.inputLabel),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          initialValue: controller == null ? initialValue : null,
          keyboardType: keyboardType,
          readOnly: readOnly,
          onTap: onTap,
          validator: validator,
          style: AppTextStyles.inputValue,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.inputBackground,
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
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                AppConstants.inputBorderRadius,
              ),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                AppConstants.inputBorderRadius,
              ),
              borderSide: const BorderSide(
                color: AppColors.accentColor,
                width: 1,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
