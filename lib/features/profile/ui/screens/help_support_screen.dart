import 'package:flutter/material.dart';
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

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  static const _faqs = [
    (
      'How do I start a workout?',
      'Open the Workouts tab, choose a program, select a training day, then complete the exercise list.',
    ),
    (
      'Can I create my own program?',
      'Yes. Go to Workouts → My Programs → Create Program and fill in the details.',
    ),
    (
      'How is progress tracked?',
      'Completed workout sessions appear on the Progress tab automatically.',
    ),
  ];

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ProfileScreenHeader(title: 'Help & Support'),
              const SizedBox(height: 24),
              Text('FAQ', style: AppTextStyles.sectionHeader),
              const SizedBox(height: 12),
              ..._faqs.map(
                (faq) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: ExpansionTile(
                    tilePadding: EdgeInsets.zero,
                    collapsedBackgroundColor: AppColors.cardColor,
                    backgroundColor: AppColors.cardColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    collapsedShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    title: Text(faq.$1, style: AppTextStyles.settingsItem),
                    iconColor: AppColors.accentColor,
                    collapsedIconColor: AppColors.textSecondary,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            faq.$2,
                            style: AppTextStyles.aboutDescription,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              PrimaryActionButton(
                label: 'Contact Support',
                onPressed: () {
                  AppSnackbars.showInfo(
                    context,
                    'Support request saved locally. Email: support@gymapp.com',
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
