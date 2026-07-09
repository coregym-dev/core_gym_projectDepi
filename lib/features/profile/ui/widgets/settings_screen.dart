import 'package:flutter/material.dart';
import 'package:flutter_coffee/core/constans/appConstants.dart';
import 'package:flutter_coffee/core/theme/app_color.dart';
import 'package:flutter_coffee/core/utils/app_dialogs.dart';
import 'package:flutter_coffee/core/utils/app_snackbars.dart';
import 'package:flutter_coffee/core/utils/session_actions.dart';
import 'package:flutter_coffee/core/widget/app_state.dart';
import 'package:flutter_coffee/features/profile/ui/widgets/legal_document_screen.dart';
import 'package:flutter_coffee/features/profile/ui/widgets/logout_button.dart';
import 'package:flutter_coffee/features/profile/ui/widgets/profile_screen.dart';
import 'package:flutter_coffee/features/profile/ui/widgets/settings_section.dart';
import 'package:flutter_coffee/features/profile/ui/widgets/settings_tile.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  AppSettings get _settings => AppState.instance.settings;

  Future<void> _pickUnits() async {
    const options = ['Metric (kg, cm)', 'Imperial (lb, ft)'];
    final selected = await AppDialogs.showOptionsSheet(
      context,
      title: 'Units',
      options: options,
      selected: _settings.units,
    );
    if (selected == null || !mounted) return;

    AppState.instance.updateSettings(
      AppSettings(
        units: selected,
        workoutRemindersEnabled: _settings.workoutRemindersEnabled,
        workoutReminderTime: _settings.workoutReminderTime,
        restTimerSeconds: _settings.restTimerSeconds,
        darkModeEnabled: _settings.darkModeEnabled,
      ),
    );
    AppSnackbars.showSuccess(context, 'Units updated');
  }

  Future<void> _configureReminders() async {
    final enabled = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Workout Reminders'),
        content: SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Enable reminders'),
          value: _settings.workoutRemindersEnabled,
          activeThumbColor: AppColors.accentColor,
          onChanged: (value) => Navigator.pop(context, value),
        ),
      ),
    );

    if (enabled == null || !mounted) return;

    var reminderTime = _settings.workoutReminderTime;
    if (enabled) {
      final parts = reminderTime.split(' ');
      final timeParts = parts.first.split(':');
      final initial = TimeOfDay(
        hour: int.tryParse(timeParts.first) ?? 7,
        minute: int.tryParse(timeParts.last) ?? 0,
      );
      final picked = await AppDialogs.pickReminderTime(context, initial);
      if (picked != null) {
        final hour = picked.hourOfPeriod == 0 ? 12 : picked.hourOfPeriod;
        final period = picked.period == DayPeriod.am ? 'AM' : 'PM';
        reminderTime =
            '$hour:${picked.minute.toString().padLeft(2, '0')} $period';
      }
    }

    if (!mounted) return;
    AppState.instance.updateSettings(
      AppSettings(
        units: _settings.units,
        workoutRemindersEnabled: enabled,
        workoutReminderTime: reminderTime,
        restTimerSeconds: _settings.restTimerSeconds,
        darkModeEnabled: _settings.darkModeEnabled,
      ),
    );
    AppSnackbars.showSuccess(context, 'Reminder settings updated');
  }

  Future<void> _pickRestTimer() async {
    const options = ['30 sec', '45 sec', '60 sec', '90 sec'];
    final selected = await AppDialogs.showOptionsSheet(
      context,
      title: 'Rest Timer',
      options: options,
      selected: _settings.restTimerLabel,
    );
    if (selected == null || !mounted) return;

    final seconds = int.parse(selected.split(' ').first);
    AppState.instance.updateSettings(
      AppSettings(
        units: _settings.units,
        workoutRemindersEnabled: _settings.workoutRemindersEnabled,
        workoutReminderTime: _settings.workoutReminderTime,
        restTimerSeconds: seconds,
        darkModeEnabled: _settings.darkModeEnabled,
      ),
    );
    AppSnackbars.showSuccess(context, 'Rest timer updated');
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: AppState.instance,
      builder: (context, _) {
        final settings = AppState.instance.settings;
        return Scaffold(
          backgroundColor: AppColors.backgroundColor,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.screenHorizontalPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),

                  const ProfileScreenHeader(
                    title: 'Settings',
                    useLargeTitle: true,
                  ),

                  const SizedBox(height: 8),

                  SettingsSection(
                    title: 'Preferences',
                    children: [
                      SettingsTile(
                        title: 'Units',
                        trailingText: settings.units,
                        onTap: _pickUnits,
                      ),

                      SettingsTile(
                        title: 'Rest Timer',
                        trailingText: settings.restTimerLabel,
                        onTap: _pickRestTimer,
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  SettingsSection(
                    title: 'Account',
                    children: [
                      SettingsTile(title: 'Change Password'),

                      SettingsTile(
                        title: 'Privacy Policy',
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => LegalDocumentScreen.privacy(),
                          ),
                        ),
                      ),

                      SettingsTile(
                        title: 'Terms of Service',
                        showDivider: false,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => LegalDocumentScreen.terms(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  LogoutButton(onPressed: () => SessionActions.logout(context)),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
