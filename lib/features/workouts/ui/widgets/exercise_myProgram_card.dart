import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_coffee/core/theme/app_color.dart';
import 'package:flutter_coffee/core/widget/custom_text.dart';
import 'package:flutter_coffee/core/widget/moreOption_btn.dart';
import 'package:flutter_coffee/features/workouts/ui/cubit/my_program_cubit.dart';

class ExerciseMyprogramCard extends StatelessWidget {
  final String imagePath;
  final String nameExercise;
  final String sets;
  final String reps;
  final String id;
  final VoidCallback? onTap;
  final VoidCallback? onDoubleTap;

  const ExerciseMyprogramCard({
    super.key,

    required this.imagePath,
    required this.nameExercise,
    required this.sets,
    required this.reps,
    required this.id,
    this.onTap,
    this.onDoubleTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        onDoubleTap: onDoubleTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: Image.file(
                    File(imagePath),

                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) {
                      return Container(
                        width: 95,
                        height: 95,
                        alignment: Alignment.center,
                        color: Colors.black12,
                        child: const Icon(Icons.image_not_supported),
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: nameExercise,
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      maxLines: 1,

                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 6),

                    CustomText(
                      text: '$sets Sets • $reps Reps',
                      color: AppColors.accentColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ),

              MoreOptionsButton(
                firstTitle: "delete",
                onFirstTap: () {
                  context.read<MyProgramCubit>().deleteExercise(id);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
