import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_coffee/core/widget/custom_text.dart';
import 'package:flutter_coffee/core/theme/app_color.dart';

class ExerciseDetails extends StatelessWidget {
  final String sets;
  final String reps;
  final String restSeconds;
  final String desc;

  const ExerciseDetails({
    super.key,
    required this.reps,
    required this.restSeconds,
    required this.sets,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 🔥 Stats Cards
        Row(
          children: [
            _buildStatCard("Sets", sets)
                .animate(delay: 100.ms)
                .fade(duration: 400.ms)
                .slideY(begin: 0.25, curve: Curves.easeOutCubic),
            const SizedBox(width: 10),
            _buildStatCard("Reps", reps)
                .animate(delay: 200.ms)
                .fade(duration: 400.ms)
                .slideY(begin: 0.25, curve: Curves.easeOutCubic),
            const SizedBox(width: 10),
            _buildStatCard("Rest", "$restSeconds")
                .animate(delay: 300.ms)
                .fade(duration: 400.ms)
                .slideY(begin: 0.25, curve: Curves.easeOutCubic),
          ],
        ),

        const SizedBox(height: 20),

        // 🔥 Description Section
        Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.cardColor,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Description",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    desc,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            )
            .animate(delay: 400.ms)
            .fade()
            .slideY(begin: 0.2, curve: Curves.easeOutCubic),
      ],
    );
  }

  Widget _buildStatCard(String title, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.withOpacity(0.1)),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: const TextStyle(
                color: Colors.amber,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
