import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;

  final TextEditingController? controller;

  final TextInputType? keyboardType;

  final bool obscureText;

  final Widget? prefixIcon;

  final Widget? suffixIcon;

  final String? Function(String?)? validator;

  final void Function(String)? onChanged;

  // 1
  final bool enabled;

  // 2
  final int maxLines;

  // 3
  final bool readOnly;

  // 4
  final void Function()? onTap;

  // 5
  final TextInputAction? textInputAction;

  // 6
  final FocusNode? focusNode;

  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onChanged,

    // default values
    this.enabled = true,
    this.maxLines = 1,
    this.readOnly = false,
    this.onTap,
    this.textInputAction,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,

      keyboardType: keyboardType,

      obscureText: obscureText,

      validator: validator,

      onChanged: onChanged,

      enabled: enabled,

      maxLines: maxLines,

      readOnly: readOnly,

      onTap: onTap,

      textInputAction: textInputAction,

      focusNode: focusNode,

      decoration: InputDecoration(
        hintText: hintText,

        prefixIcon: prefixIcon,

        suffixIcon: suffixIcon,

        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
