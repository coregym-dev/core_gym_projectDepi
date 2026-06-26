import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_coffee/core/theme/app_color.dart';
import 'package:flutter_coffee/features/progress/ui/cubit/create_sessions/workout_session_cubit.dart';
import 'package:flutter_coffee/features/workouts/ui/widgets/gym_btn.dart';
import 'package:flutter_coffee/features/workouts/ui/widgets/timer_exercise.dart';
import 'package:flutter_coffee/features/workouts/ui/widgets/video_play.dart';
import 'package:gap/gap.dart';

class ExerciseVideoView extends StatelessWidget {
  final String videoUrl;

  const ExerciseVideoView({super.key, required this.videoUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: const Text(
          "Exercise Video",
          style: TextStyle(
            fontSize: 20,
            color: AppColors.accentColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            VideoPlayHeader(videoUrl: videoUrl),
            Gap(10),
            TimerExercise(),
            Gap(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: GymButton(
                text: "Finish",
                onTap: () {
                  context.read<WorkoutSessionCubit>().finishExercise();
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
