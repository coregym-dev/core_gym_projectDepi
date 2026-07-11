import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_coffee/core/constans/appConstants.dart';
import 'package:flutter_coffee/core/theme/app_color.dart';
import 'package:flutter_coffee/core/theme/app_text_styles.dart';

class PrimaryActionButton extends StatelessWidget {
  final String label;
 final void Function()? onTap;
  final bool isLoading;

  const PrimaryActionButton({
    super.key,
    required this.label,
    this.onTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Material(
        color: const Color.fromRGBO(223, 186, 38, 1),
        borderRadius: BorderRadius.circular(AppConstants.buttonBorderRadius),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppConstants.buttonBorderRadius),
          splashColor: AppColors.accentPressed.withValues(alpha: 0.3),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: isLoading
                ? const SizedBox(
                    height: 22,
                    width: 22,
                    child: CupertinoActivityIndicator(color: AppColors.accentColor),
                  )
                : Text(
                    label,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.primaryButton,
                  ),
          ),
        ),
      ),
    );
  }
}
