import 'package:flutter/material.dart';
import 'package:flutter_coffee/core/constans/appConstants.dart';
import 'package:flutter_coffee/core/theme/app_color.dart';
import 'package:flutter_coffee/core/theme/app_text_styles.dart';
import 'package:flutter_coffee/core/widget/app_state.dart';
import 'package:flutter_coffee/features/profile/ui/widgets/edit_profile_screen.dart';
import 'package:flutter_coffee/features/profile/ui/widgets/primary_action_btn.dart';
import 'package:flutter_coffee/features/profile/ui/widgets/profile_screen.dart';

class BodyStatsScreen extends StatelessWidget {
  const BodyStatsScreen({super.key});

  double? _parseNumber(String value) {
    final match = RegExp(r'(\d+(?:\.\d+)?)').firstMatch(value);
    return match == null ? null : double.tryParse(match.group(1)!);
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: AppState.instance,
      builder: (context, _) {
        final profile = AppState.instance.profile;
        final heightCm = _parseNumber(profile.height);
        final weightKg = _parseNumber(profile.weight);
        final bmi = heightCm != null && weightKg != null && heightCm > 0
            ? (weightKg / ((heightCm / 100) * (heightCm / 100)))
                  .toStringAsFixed(1)
            : '--';

        return Scaffold(
          backgroundColor: AppColors.backgroundColor,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.screenHorizontalPadding,
                vertical: 16,
              ),
              child: Column(
                children: [
                  const ProfileScreenHeader(title: 'Body Stats'),
                  const SizedBox(height: 32),
                  _StatCard(label: 'Height', value: profile.height),
                  const SizedBox(height: 12),
                  _StatCard(label: 'Weight', value: profile.weight),
                  const SizedBox(height: 12),
                  _StatCard(label: 'BMI', value: bmi),
                  const SizedBox(height: 12),
                  _StatCard(label: 'Gender', value: profile.gender),
                  const SizedBox(height: 12),
                  const SizedBox(height: 220),
                  PrimaryActionButton(
                    label: 'Edit Body Stats',
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const EditProfileScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;

  const _StatCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
      ),
      child: Row(
        children: [
          Expanded(child: Text(label, style: AppTextStyles.settingsItem)),
          Text(value, style: AppTextStyles.settingsValue),
        ],
      ),
    );
  }
}
