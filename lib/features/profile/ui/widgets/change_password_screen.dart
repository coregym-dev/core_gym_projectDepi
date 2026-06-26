import 'package:flutter/material.dart';
import 'package:flutter_coffee/core/constans/appConstants.dart';
import 'package:flutter_coffee/core/theme/app_color.dart';
import 'package:flutter_coffee/core/theme/app_text_styles.dart';
import 'package:flutter_coffee/core/utils/AppValidators.dart';
import 'package:flutter_coffee/core/utils/app_snackbars.dart';
import 'package:flutter_coffee/core/widget/app_state.dart';
import 'package:flutter_coffee/features/auth/ui/widgets/custom_text_form_field..dart';
import 'package:flutter_coffee/features/profile/ui/widgets/edit_profile_screen.dart';
import 'package:flutter_coffee/features/profile/ui/widgets/primary_action_btn.dart';
import 'package:flutter_coffee/features/profile/ui/widgets/profile_screen.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isSaving = false;
  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);
    await Future<void>.delayed(const Duration(milliseconds: 800));
    if (!mounted) return;
    setState(() => _isSaving = false);
    AppSnackbars.showSuccess(context, 'Password updated successfully');
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.screenHorizontalPadding,
            vertical: 16,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const ProfileScreenHeader(title: 'Change Password'),
                const SizedBox(height: 32),
                CustomTextFormField(
                  hintText: 'Current Password',
                  controller: _currentPasswordController,
                  obscureText: _obscureCurrent,
                  validator: AppValidators.password,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureCurrent ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () =>
                        setState(() => _obscureCurrent = !_obscureCurrent),
                  ),
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  hintText: 'New Password',
                  controller: _newPasswordController,
                  obscureText: _obscureNew,
                  validator: AppValidators.password,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureNew ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () => setState(() => _obscureNew = !_obscureNew),
                  ),
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  hintText: 'Confirm New Password',
                  controller: _confirmPasswordController,
                  obscureText: _obscureConfirm,
                  validator: (value) => AppValidators.confirmPassword(
                    value,
                    _newPasswordController.text,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirm ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () =>
                        setState(() => _obscureConfirm = !_obscureConfirm),
                  ),
                ),
                const SizedBox(height: 24),
                PrimaryActionButton(
                  label: 'Update Password',
                  isLoading: _isSaving,
                  onPressed: _submit,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
