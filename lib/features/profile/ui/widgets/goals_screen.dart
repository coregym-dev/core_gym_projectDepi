import 'package:flutter/material.dart';
import 'package:flutter_coffee/core/constans/appConstants.dart';
import 'package:flutter_coffee/core/theme/app_color.dart';
import 'package:flutter_coffee/core/theme/app_text_styles.dart';
import 'package:flutter_coffee/core/utils/app_snackbars.dart';
import 'package:flutter_coffee/core/widget/app_state.dart';
import 'package:flutter_coffee/features/profile/ui/widgets/about_info_tile.dart';
import 'package:flutter_coffee/features/profile/ui/widgets/primary_action_btn.dart';
import 'package:flutter_coffee/features/profile/ui/widgets/profile_screen.dart';
import 'package:flutter_coffee/features/profile/ui/widgets/social_media_button.dart';

class GoalsScreen extends StatefulWidget {
  const GoalsScreen({super.key});

  @override
  State<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {
  late Map<String, bool> _selectedGoals;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _selectedGoals = Map<String, bool>.from(AppState.instance.fitnessGoals);
  }

  Future<void> _saveGoals() async {
    setState(() => _isSaving = true);
    await Future<void>.delayed(const Duration(milliseconds: 600));
    for (final entry in _selectedGoals.entries) {
      AppState.instance.updateGoal(entry.key, entry.value);
    }
    if (!mounted) return;
    setState(() => _isSaving = false);
    AppSnackbars.showSuccess(context, 'Goals updated successfully');
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ProfileScreenHeader(title: 'Goals'),
              const SizedBox(height: 8),
              Text(
                'Select the goals you want to focus on.',
                style: AppTextStyles.aboutDescription,
              ),
              const SizedBox(height: 24),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.cardColor,
                  borderRadius: BorderRadius.circular(
                    AppConstants.cardBorderRadius,
                  ),
                ),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: _selectedGoals.keys.map((goal) {
                    return SwitchListTile(
                      title: Text(goal, style: AppTextStyles.settingsItem),
                      value: _selectedGoals[goal] ?? false,
                      activeThumbColor: AppColors.accentColor,
                      onChanged: (value) {
                        setState(() => _selectedGoals[goal] = value);
                      },
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 24),
              PrimaryActionButton(
                label: 'Save Goals',
                isLoading: _isSaving,
                onPressed: _saveGoals,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
