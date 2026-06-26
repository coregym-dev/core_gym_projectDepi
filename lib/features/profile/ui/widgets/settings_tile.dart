import 'package:flutter/material.dart';
import 'package:flutter_coffee/core/constans/appConstants.dart';
import 'package:flutter_coffee/core/theme/app_color.dart';
import 'package:flutter_coffee/core/theme/app_text_styles.dart';

class SettingsChevron extends StatelessWidget {
  const SettingsChevron({super.key});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -0.785398,
      child: Container(
        width: 8,
        height: 8,
        decoration: const BoxDecoration(
          border: Border(
            right: BorderSide(color: AppColors.chevronColor, width: 2),
            bottom: BorderSide(color: AppColors.chevronColor, width: 2),
          ),
        ),
      ),
    );
  }
}

class SettingsTile extends StatelessWidget {
  final String title;
  final String? trailingText;
  final Widget? trailing;
  final bool showDivider;
  final VoidCallback? onTap;

  const SettingsTile({
    super.key,
    required this.title,
    this.trailingText,
    this.trailing,
    this.showDivider = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: showDivider
              ? const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: AppColors.dividerColor,
                      width: 0.5,
                    ),
                  ),
                )
              : null,
          child: Row(
            children: [
              Expanded(child: Text(title, style: AppTextStyles.settingsItem)),
              if (trailingText != null) ...[
                Text(trailingText!, style: AppTextStyles.settingsValue),
                const SizedBox(width: 8),
              ],
              trailing ?? const SettingsChevron(),
            ],
          ),
        ),
      ),
    );
  }
}

class SettingsToggle extends StatelessWidget {
  final bool value;

  const SettingsToggle({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 24,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: value ? AppColors.toggleActive : AppColors.textMuted,
        borderRadius: BorderRadius.circular(999),
      ),
      child: AnimatedAlign(
        duration: const Duration(milliseconds: 200),
        alignment: value ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          width: 20,
          height: 20,
          decoration: const BoxDecoration(
            color: AppColors.textPrimary,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
