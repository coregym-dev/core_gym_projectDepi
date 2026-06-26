import 'package:flutter/material.dart';
import 'package:flutter_coffee/core/constans/appConstants.dart';
import 'package:flutter_coffee/core/theme/app_color.dart';
import 'package:flutter_coffee/core/theme/app_text_styles.dart';
import 'package:flutter_coffee/core/utils/AppValidators.dart';
import 'package:flutter_coffee/core/utils/app_snackbars.dart';
import 'package:flutter_coffee/core/widget/app_state.dart';
import 'package:flutter_coffee/features/profile/ui/widgets/about_info_tile.dart';
import 'package:flutter_coffee/features/profile/ui/widgets/edit_profile_screen.dart';
import 'package:flutter_coffee/features/profile/ui/widgets/gender_dropdown_field.dart';
import 'package:flutter_coffee/features/profile/ui/widgets/labeled_input_field.dart';
import 'package:flutter_coffee/features/profile/ui/widgets/primary_action_btn.dart';
import 'package:flutter_coffee/features/profile/ui/widgets/profile_avatar.dart';
import 'package:flutter_coffee/features/profile/ui/widgets/profile_screen.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _fullNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _heightController;
  late final TextEditingController _weightController;
  late final TextEditingController _dobController;
  late String _selectedGender;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    final profile = AppState.instance.profile;
    _fullNameController = TextEditingController(text: profile.fullName);
    _emailController = TextEditingController(text: profile.email);
    _heightController = TextEditingController(text: profile.height);
    _weightController = TextEditingController(text: profile.weight);
    _dobController = TextEditingController(text: profile.dateOfBirth);
    _selectedGender = profile.gender;
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  Future<void> _pickDateOfBirth() async {
    final initialDate = DateTime(1995, 5, 15);
    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
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

    if (picked != null) {
      const months = [
        'January',
        'February',
        'March',
        'April',
        'May',
        'June',
        'July',
        'August',
        'September',
        'October',
        'November',
        'December',
      ];
      _dobController.text =
          '${months[picked.month - 1]} ${picked.day}, ${picked.year}';
    }
  }

  void _showPhotoOptions() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_camera_outlined),
              title: const Text('Take Photo'),
              onTap: () {
                Navigator.pop(context);
                AppSnackbars.showInfo(
                  context,
                  'Camera access would open here on a device',
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: const Text('Choose from Gallery'),
              onTap: () {
                Navigator.pop(context);
                AppSnackbars.showSuccess(
                  context,
                  'Profile photo updated locally',
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onSave() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);
    await Future<void>.delayed(const Duration(milliseconds: 700));

    AppState.instance.updateProfile(
      AppState.instance.profile.copyWith(
        fullName: _fullNameController.text.trim(),
        email: _emailController.text.trim(),
        height: _heightController.text.trim(),
        weight: _weightController.text.trim(),
        dateOfBirth: _dobController.text.trim(),
        gender: _selectedGender,
      ),
    );

    if (!mounted) return;
    setState(() => _isSaving = false);
    AppSnackbars.showSuccess(context, 'Profile updated successfully');
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final profile = AppState.instance.profile;

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
                const ProfileScreenHeader(title: 'Edit Profile'),
                const SizedBox(height: 32),
                ProfileAvatar(
                  imageUrl: profile.imageUrl,
                  size: AppConstants.editProfileAvatarSize,
                  showCameraBadge: true,
                  onCameraTap: _showPhotoOptions,
                ),
                const SizedBox(height: 32),
                LabeledInputField(
                  label: 'Full Name',
                  controller: _fullNameController,
                  //    validator: AppValidators.fullName,
                ),
                const SizedBox(height: 16),
                LabeledInputField(
                  label: 'Email',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: AppValidators.email,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: LabeledInputField(
                        label: 'Height',
                        controller: _heightController,
                        //   validator: AppValidators.height,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: LabeledInputField(
                        label: 'Weight',
                        controller: _weightController,
                        ////   validator: AppValidators.weight,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                LabeledInputField(
                  label: 'Date of Birth',
                  controller: _dobController,
                  readOnly: true,
                  onTap: _pickDateOfBirth,
                  //  validator: AppValidators.dateOfBirth,
                ),
                const SizedBox(height: 16),
                GenderDropdownField(
                  value: _selectedGender,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => _selectedGender = value);
                    }
                  },
                ),
                const SizedBox(height: 24),
                PrimaryActionButton(
                  label: 'Save Changes',
                  isLoading: _isSaving,
                  onPressed: _onSave,
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
