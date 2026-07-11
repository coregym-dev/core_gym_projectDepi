import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_coffee/core/constans/appConstants.dart';
import 'package:flutter_coffee/core/theme/app_color.dart';
import 'package:flutter_coffee/core/widget/app_state.dart';
import 'package:flutter_coffee/features/profile/ui/widgets/about_us_screen.dart';
import 'package:flutter_coffee/features/profile/ui/widgets/help_support_screen.dart';
import 'package:flutter_coffee/features/profile/ui/widgets/logout_button.dart';
import 'package:flutter_coffee/features/profile/ui/widgets/membership_badge.dart';
import 'package:flutter_coffee/features/profile/ui/widgets/profile_header.dart';
import 'package:flutter_coffee/features/profile/ui/widgets/profile_menu_tile.dart';
import 'package:flutter_coffee/features/profile/ui/widgets/settings_screen.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: AppState.instance,
      builder: (context, _) {
        return Scaffold(
          backgroundColor: AppColors.backgroundAlt,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.screenHorizontalPadding,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 24),

                  ////  profile head ////
                  ProfileHeader(),
                  /////////////////
                  const SizedBox(height: 4),
                  const MembershipBadge(),
                  const SizedBox(height: 32),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.cardColorAlt,
                      borderRadius: BorderRadius.circular(
                        AppConstants.cardBorderRadius,
                      ),
                    ),

                    child: Column(
                      children: [
                        const Divider(height: 1, color: AppColors.dividerColor),
                        ProfileMenuTile(
                          icon: Icons.settings_outlined,
                          title: 'Settings',
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const SettingsScreen(),
                            ),
                          ),
                        ),
                        const Divider(height: 1, color: AppColors.dividerColor),
                        ProfileMenuTile(
                          icon: Icons.help_outline,
                          title: 'Help & Support',
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const HelpSupportScreen(),
                            ),
                          ),
                        ),

                        const Divider(height: 1, color: AppColors.dividerColor),
                        ProfileMenuTile(
                          icon: Icons.info_outline,
                          title: 'About Us',
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const AboutUsScreen(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 60),

                  /// logout ///
                  LogoutButton(
                    isProfileStyle: true,
                    onPressed: () {
                      // code
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
