import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_coffee/core/theme/app_color.dart';
import 'package:flutter_coffee/core/widget/custom_text.dart';
import 'package:flutter_coffee/features/profile/ui/cubit/profile_cubit.dart';

class BuildHeader extends StatelessWidget {
  const BuildHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        final profile = context.read<ProfileCubit>().profile;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomText(
                    text: 'Good Morning',
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                  CustomText(
                    text: profile?.fullName ?? 'Guest',
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ],
              ),
            ),
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.accentColor, width: 2),
              ),
              child: ClipOval(
                child: profile?.imageUrl != null
                    ? Image.file(File(profile!.imageUrl!), fit: BoxFit.cover)
                    : const Icon(Icons.person),
              ),
            ),
          ],
        );
      },
    );
  }
}
