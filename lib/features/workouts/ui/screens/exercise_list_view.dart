import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_coffee/core/theme/app_color.dart';
import 'package:flutter_coffee/features/progress/ui/cubit/create_sessions/workout_session_cubit.dart';
import 'package:flutter_coffee/features/workouts/ui/widgets/custom_backBtn.dart';
import 'package:flutter_coffee/features/workouts/ui/widgets/day_exercise_list_content.dart';
import 'package:flutter_coffee/features/workouts/ui/widgets/gym_btn.dart';
import 'package:flutter_coffee/features/workouts/ui/widgets/head_exercise_list.dart';

class ExerciseListView extends StatelessWidget {
  final int dayId;
  final String name;
  final String muscle;
  final String image;

  const ExerciseListView({
    super.key,
    required this.muscle,
    required this.name,
    required this.dayId,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          HeadExerciseList(muscle: muscle, name: name),

          DayExercisesListContent(dayId: dayId),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: GymButton(
                text: "Finish ",
                onTap: () {
                  final cubit = context.read<WorkoutSessionCubit>();
                  context.read<WorkoutSessionCubit>().finishWorkOut([
                    {
                      "workout_name": name,
                      "workout_image": image,
                      "exercises_count": cubit.countExrcise,
                      "workout_date": DateTime.now().toIso8601String(),
                      "duration": cubit.totalTime.inSeconds,
                    },
                  ]);
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
