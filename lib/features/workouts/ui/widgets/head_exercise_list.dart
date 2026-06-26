import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_coffee/core/theme/app_color.dart';
import 'package:flutter_coffee/features/workouts/ui/widgets/custom_backBtn.dart';

class HeadExerciseList extends StatelessWidget {
  final String name;
  final String muscle;
  const HeadExerciseList({super.key, required this.muscle, required this.name});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar.large(
      expandedHeight: 150.0,
      floating: false,
      pinned: true, // يثبت فوق لما تسكرول
      backgroundColor: AppColors.backgroundColor,
      elevation: 0,
      leading: CustomBackButton(),
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        centerTitle: false,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              name,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              muscle,
              style: TextStyle(
                color: AppColors.accentColor.withOpacity(
                  0.8,
                ), // ميزة اللون الفرعي المضيء
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
