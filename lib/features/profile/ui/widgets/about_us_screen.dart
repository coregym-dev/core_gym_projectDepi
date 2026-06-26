import 'package:flutter/material.dart';
import 'package:flutter_coffee/core/constans/appConstants.dart';
import 'package:flutter_coffee/core/theme/app_color.dart';
import 'package:flutter_coffee/core/theme/app_text_styles.dart';
import 'package:flutter_coffee/features/profile/ui/widgets/about_info_tile.dart';
import 'package:flutter_coffee/features/profile/ui/widgets/social_media_button.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  // static void _openSocial(BuildContext context, String platform) {
  //   AppSnackbars.showInfo(
  //     context,
  //     'Opening $platform profile for ${AppConstants.appName}',
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back,
                      color: AppColors.textPrimary,
                      size: 24,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'About Us',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.aboutTitle,
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: AppConstants.screenHorizontalPadding,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    Container(
                      width: 96,
                      height: 96,
                      decoration: BoxDecoration(
                        color: AppColors.logoContainer,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: AppColors.borderGray600),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.fitness_center,
                        size: 40,
                        color: AppColors.accentColor,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      AppConstants.appName,
                      style: AppTextStyles.aboutAppName,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('👑', style: TextStyle(fontSize: 14)),
                        const SizedBox(width: 6),
                        Text(
                          AppConstants.appSlogan.toUpperCase(),
                          style: AppTextStyles.aboutSlogan,
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        AppConstants.appDescription,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.aboutDescription,
                      ),
                    ),
                    const SizedBox(height: 40),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.cardColor,
                        borderRadius: BorderRadius.circular(
                          AppConstants.cardBorderRadius,
                        ),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        children: [
                          AboutInfoTile(
                            label: 'App Version',
                            value: AppConstants.appVersion,
                          ),
                          AboutInfoTile(
                            label: 'Developer',
                            value: AppConstants.appDeveloper,
                          ),
                          AboutInfoTile(
                            label: 'Website',
                            value: AppConstants.appWebsite,
                            showDivider: false,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Follow Us',
                        style: AppTextStyles.followUsTitle,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        SocialMediaButton.instagram(
                          //     onTap: () => _openSocial(context, 'Instagram'),
                        ),
                        const SizedBox(width: 16),
                        SocialMediaButton.facebook(
                          //     onTap: () => _openSocial(context, 'Facebook'),
                        ),
                        const SizedBox(width: 16),
                        SocialMediaButton.twitter(
                          //    onTap: () => _openSocial(context, 'Twitter'),
                        ),
                        const SizedBox(width: 16),
                        SocialMediaButton.youtube(
                          //    onTap: () => _openSocial(context, 'YouTube'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
