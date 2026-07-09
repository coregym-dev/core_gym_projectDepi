import 'dart:io'; // تم إضافتها للتعامل مع ملف الصورة
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // تم إضافة المكتبة هنا
import 'package:flutter_coffee/core/constans/appConstants.dart';
import 'package:flutter_coffee/core/theme/app_color.dart';
import 'package:flutter_coffee/core/theme/app_text_styles.dart';
import 'package:flutter_coffee/core/utils/AppValidators.dart';
import 'package:flutter_coffee/core/utils/app_snackbars.dart';
import 'package:flutter_coffee/core/widget/app_state.dart';
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

  // متغيرات الـ ImagePicker
  final ImagePicker _picker = ImagePicker();
  File? _imageFile; // لتخزين الصورة المختارة محلياً قبل الحفظ

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

  // دالة لالتقاط الصورة من الكاميرا أو المعرض
  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 500, // تحديد أبعاد الصورة لتقليل المساحة
        maxHeight: 500,
        imageQuality: 85, // تقليل الجودة قليلاً للحفاظ على الأداء
      );

      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });
        if (!mounted) return;
        AppSnackbars.showSuccess(context, 'تم اختيار الصورة بنجاح');
      }
    } catch (e) {
      AppSnackbars.showError(context, 'حدث خطأ أثناء اختيار الصورة');
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
                _pickImage(ImageSource.camera); // استدعاء الكاميرا
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: const Text('Choose from Gallery'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery); // استدعاء المعرض
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
        imageUrl: _imageFile != null
            ? _imageFile!.path
            : AppState.instance.profile.imageUrl,
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

                // تعديل هنا: إذا كانت هناك صورة جديدة مختارة، نعرضها، وإلا نعرض الافتراضية
                ProfileAvatar(
                  imageUrl: _imageFile != null
                      ? _imageFile!.path
                      : profile.imageUrl,
                  size: AppConstants.editProfileAvatarSize,
                  showCameraBadge: true,
                  onCameraTap: _showPhotoOptions,
                  // تنبيه: تأكد أن ويدجت ProfileAvatar لديك تدعم التعامل مع مسار ملف محلي (File Path)
                  // إذا كانت الصورة تبدأ بـ 'assets/' أو رابط ويب، فقد تحتاج لتعديل الـ ProfileAvatar من الداخل لتستقبل File أيضاً.
                ),

                const SizedBox(height: 32),
                LabeledInputField(
                  label: 'Full Name',
                  controller: _fullNameController,
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
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: LabeledInputField(
                        label: 'Weight',
                        controller: _weightController,
                      ),
                    ),
                  ],
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
