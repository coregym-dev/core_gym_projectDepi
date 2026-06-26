import 'package:flutter/material.dart';
import 'package:flutter_coffee/core/theme/app_color.dart';


class AppSnackbars {
  const AppSnackbars._();

  static void showSuccess(BuildContext context, String message) {
    _show(context, message, AppColors.accentColor, Icons.check_circle_outline);
  }

  static void showError(BuildContext context, String message) {
    _show(context, message, AppColors.logoutRed, Icons.error_outline);
  }

  static void showInfo(BuildContext context, String message) {
    _show(context, message, AppColors.cardColorAlt, Icons.info_outline);
  }

  static void _show(
    BuildContext context,
    String message,
    Color background,
    IconData icon,
  ) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(icon, color: Colors.white, size: 20),
              const SizedBox(width: 12),
              Expanded(child: Text(message)),
            ],
          ),
          backgroundColor: background,
        ),
      );
  }
}
