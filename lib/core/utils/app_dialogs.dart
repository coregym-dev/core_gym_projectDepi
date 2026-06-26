import 'package:flutter/material.dart';
import 'package:flutter_coffee/core/theme/app_color.dart';
import 'package:flutter_coffee/core/theme/app_text_styles.dart';


class AppDialogs {
  const AppDialogs._();

  static Future<bool> confirm(
    BuildContext context, {
    required String title,
    required String message,
    String confirmLabel = 'Confirm',
    String cancelLabel = 'Cancel',
    bool isDestructive = false,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(cancelLabel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(
              confirmLabel,
              style: TextStyle(
                color: isDestructive ? AppColors.logoutRed : AppColors.accentColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  static Future<String?> showOptionsSheet(
    BuildContext context, {
    required String title,
    required List<String> options,
    String? selected,
  }) {
    return showModalBottomSheet<String>(
      context: context,
      backgroundColor: AppColors.cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(title, style: AppTextStyles.screenTitle),
            ),
            ...options.map(
              (option) => ListTile(
                title: Text(option, style: AppTextStyles.settingsItem),
                trailing: selected == option
                    ? const Icon(Icons.check, color: AppColors.accentColor)
                    : null,
                onTap: () => Navigator.pop(context, option),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  static Future<TimeOfDay?> pickReminderTime(
    BuildContext context,
    TimeOfDay initial,
  ) {
    return showTimePicker(
      context: context,
      initialTime: initial,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: AppColors.accentColor,
              onPrimary: Colors.black,
              surface: AppColors.cardColor,
              onSurface: AppColors.textPrimary,
            ),
          ),
          child: child!,
        );
      },
    );
  }
}
