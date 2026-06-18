import 'package:flutter/material.dart';

class AppValidators {
  const AppValidators._();

  /// Email Validator
  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Email is required";
    }

    final cleanValue = value.trim();

    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegExp.hasMatch(cleanValue)) {
      return "Invalid email address";
    }

    return null;
  }

  /// Password Validator
  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }

    if (value.length < 8) {
      return "Password must be at least 8 characters";
    }

    final passwordRegExp = RegExp(r'^(?=.*[A-Z])(?=.*[0-9])');
    if (!passwordRegExp.hasMatch(value)) {
      return "Password Very Weak";
    }

    return null;
  }

  static String? confirmPassword(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return "Confirm password is required";
    }
    if (value != password) {
      return "Passwords do not match";
    }
    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Phone number is required";
    }
    String phone = value.trim();
    if (phone.length != 11) {
      return "Invalid phone number";
    }
    return null;
  }
}
