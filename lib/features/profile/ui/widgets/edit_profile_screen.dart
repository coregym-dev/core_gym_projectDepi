import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_coffee/core/constans/appConstants.dart';
import 'package:flutter_coffee/core/theme/app_color.dart';
import 'package:flutter_coffee/core/utils/AppValidators.dart';
import 'package:flutter_coffee/features/profile/data/models/profile_model.dart';
import 'package:flutter_coffee/features/profile/ui/cubit/profile_cubit.dart';
import 'package:flutter_coffee/features/profile/ui/widgets/labeled_input_field.dart';
import 'package:flutter_coffee/features/profile/ui/widgets/primary_action_btn.dart';
import 'package:flutter_coffee/features/profile/ui/widgets/profile_avatar.dart';
import 'package:flutter_coffee/features/profile/ui/widgets/profile_screen.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({
    super.key,
    required this.initialImage,
    required this.Weight,
    required this.email,
    required this.height,
    required this.name,
  });

  final File? initialImage;
  final String? Weight;
  final String? height;
  final String? name;
  final String? email;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _fullNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _heightController;
  late final TextEditingController _weightController;

  bool _isSaving = false;
  XFile? imagePath;
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
    );

    if (pickedFile != null) {
      setState(() {
        imagePath = pickedFile;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _fullNameController = TextEditingController(text: widget.name ?? '');

    _emailController = TextEditingController(text: widget.email ?? '');

    _heightController = TextEditingController(text: widget.height ?? '');

    _weightController = TextEditingController(text: widget.Weight ?? '');
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
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
                const ProfileScreenHeader(title: 'Edit Profile'),
                const SizedBox(height: 32),

                ProfileAvatar(
                  localImagePath: imagePath?.path,
                  backendImagePath: widget.initialImage?.path,
                  onTap: _pickImage,
                ),

                const SizedBox(height: 32),

                LabeledInputField(
                  label: 'Full Name',
                  controller: _fullNameController,
                  //  validator: AppValidators.fullName,
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

                const SizedBox(height: 70),

                _isSaving == true
                    ? CupertinoActivityIndicator(color: AppColors.accentColor)
                    : PrimaryActionButton(
                        label: 'Save Changes',
                        isLoading: _isSaving,
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              _isSaving = true;
                            });

                            context.read<ProfileCubit>().saveOrUpdateProfile(
                              ProfileUser(
                                email: _emailController.text,
                                fullName: _fullNameController.text,
                                height: double.parse(_heightController.text),
                                weight: double.parse(_weightController.text),
                                imageUrl: widget.initialImage?.path,
                              ),
                            );
                            if (imagePath != null) {
                              context.read<ProfileCubit>().updateProfileImage(
                                imagePath!.path,
                              );
                            }

                            setState(() {
                              _isSaving = false;
                            });

                            Navigator.pop(context);
                          }
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
