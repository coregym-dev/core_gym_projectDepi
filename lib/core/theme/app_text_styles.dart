import 'package:flutter/material.dart';
import 'package:flutter_coffee/core/theme/app_color.dart';

class AppTextStyles {
  static const String fontFamily = 'Inter';

  static TextStyle get statusBar => const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      );

  static TextStyle get screenTitle => const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      );

  static TextStyle get screenTitleLarge => const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      );

  static TextStyle get profileName => const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      );

  static TextStyle get sectionHeader => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.textZinc400,
      );

  static TextStyle get inputLabel => const TextStyle(
        fontSize: 12,
        color: AppColors.textSecondary,
      );

  static TextStyle get inputValue => const TextStyle(
        fontSize: 14,
        color: AppColors.textPrimary,
      );

  static TextStyle get menuItem => const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
      );

  static TextStyle get settingsItem => const TextStyle(
        fontSize: 16,
        color: AppColors.textPrimary,
      );

  static TextStyle get settingsValue => const TextStyle(
        fontSize: 14,
        color: AppColors.textZinc400,
      );

  static TextStyle get primaryButton => const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      );

  static TextStyle get logoutButton => const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: AppColors.logoutRed,
      );

  static TextStyle get logoutButtonProfile => const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.logoutRed,
        letterSpacing: 0.5,
      );

  static TextStyle get membershipBadge => const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: AppColors.gold,
        letterSpacing: 1.2,
      );

  static TextStyle get aboutTitle => const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.textSecondary,
        letterSpacing: 0.5,
      );

  static TextStyle get aboutAppName => const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      );

  static TextStyle get aboutSlogan => const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.gold,
        letterSpacing: -0.2,
      );

  static TextStyle get aboutDescription => const TextStyle(
        fontSize: 14,
        height: 1.6,
        color: AppColors.textSecondary,
      );

  static TextStyle get aboutInfoLabel => const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
      );

  static TextStyle get aboutInfoValue => const TextStyle(
        fontSize: 14,
        color: AppColors.textGray500,
      );

  static TextStyle get followUsTitle => const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      );
}
