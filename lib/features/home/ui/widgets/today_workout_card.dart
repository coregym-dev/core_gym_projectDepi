import 'package:flutter/material.dart';
import 'package:flutter_coffee/core/theme/app_color.dart';
import 'package:flutter_coffee/core/widget/custom_text.dart';

class TodayWorkoutCard extends StatelessWidget {
  const TodayWorkoutCard({super.key , required this.controller});
  final PageController controller;
  void _onItemTapped() {
    controller.animateToPage(
      1,
      duration: const Duration(
        milliseconds: 200,
      ), // تعديل الوقت ليكون التنقل أنعم
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 175,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: AppColors.cardColor,
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'images/home.webp',
            fit: BoxFit.cover,
            errorBuilder: (_, _, _) => Container(color: AppColors.cardColor),
          ),
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0xDD121212),
                  Color(0x88121212),
                  Colors.transparent,
                ],
                stops: [0.0, 0.55, 1.0],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CustomText(
                  text: 'Push / Upper / Arnold',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
                const SizedBox(height: 4),
                const CustomText(
                  text: 'Chest • Shoulders • back • legs ',
                  fontSize: 13,
                  color: AppColors.textSecondary,
                ),
                const CustomText(
                  text: 'Triceps',
                  fontSize: 13,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: _onItemTapped,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.accentColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'Start Workout',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
