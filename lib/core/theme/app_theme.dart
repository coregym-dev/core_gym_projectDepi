import 'package:flutter/material.dart';
import 'package:flutter_coffee/core/theme/app_color.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData get dark => _buildTheme(
        brightness: Brightness.dark,
        scaffold: AppColors.backgroundColor,
        card: AppColors.cardColor,
      );

  static ThemeData get light => _buildTheme(
        brightness: Brightness.light,
        scaffold: const Color(0xFFF3F4F6),
        card: Colors.white,
      );

  static ThemeData _buildTheme({
    required Brightness brightness,
    required Color scaffold,
    required Color card,
  }) {
    final isDark = brightness == Brightness.dark;
    final primaryText = isDark ? AppColors.textPrimary : Colors.black87;
    final secondaryText = isDark ? AppColors.textSecondary : Colors.black54;

    return ThemeData(
      brightness: brightness,
      scaffoldBackgroundColor: scaffold,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.accentColor,
        brightness: brightness,
        primary: AppColors.accentColor,
        surface: card,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: scaffold,
        foregroundColor: primaryText,
        elevation: 0,
        centerTitle: false,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: isDark ? AppColors.cardColorAlt : Colors.black87,
        contentTextStyle: TextStyle(color: primaryText),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: isDark ? AppColors.cardColor : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        titleTextStyle: TextStyle(
          color: primaryText,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
        contentTextStyle: TextStyle(color: secondaryText, fontSize: 14),
      ),
      dividerColor: isDark ? AppColors.dividerColor : Colors.grey.shade300,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark ? AppColors.inputBackground : Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
