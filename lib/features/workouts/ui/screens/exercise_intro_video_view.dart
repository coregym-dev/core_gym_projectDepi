import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_coffee/core/theme/app_color.dart';
import 'package:flutter_coffee/core/widget/custom_image.dart';
import 'package:flutter_coffee/core/widget/custom_text.dart';
import 'package:flutter_coffee/features/workouts/ui/screens/exercise_video_view.dart';
import 'package:flutter_coffee/features/workouts/ui/widgets/custom_backBtn.dart';
import 'package:flutter_coffee/features/workouts/ui/widgets/exercise_details.dart';
import 'package:flutter_coffee/features/workouts/ui/widgets/gym_btn.dart';
import 'package:flutter_coffee/features/workouts/ui/widgets/video_play.dart';

class ExerciseIntroVideoView extends StatefulWidget {
  final String videoUrl;
  final String exerciseName;
  final String sets;
  final String reps;
  final String restSeconds;
  final String desc;
  final String image;
  const ExerciseIntroVideoView({
    super.key,
    required this.exerciseName,
    required this.videoUrl,
    required this.reps,
    required this.restSeconds,
    required this.sets,
    required this.desc,
    required this.image,
  });

  @override
  State<ExerciseIntroVideoView> createState() => _ExerciseVideoViewState();
}

class _ExerciseVideoViewState extends State<ExerciseIntroVideoView> {
  late final String videoUrl;
  @override
  void initState() {
    super.initState();
    videoUrl = widget.videoUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          AppColors.backgroundColor, // اللون الأسود الملوكي للخلفية

      appBar: AppBar(
        leading: CustomBackButton(),
        backgroundColor: AppColors.backgroundColor,
        title: CustomText(
          text: widget.exerciseName,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColors.accentColor,
        ),
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const SizedBox(height: 10),

            Stack(
              children: [
                CustomImage(
                    image: widget.image,
                    height: 200,
                    width: double.infinity,
                    radious: 10,
                  ).animate(delay: 50.ms).fade(duration: 400.ms)
                  ..slideY(begin: 0.25, curve: Curves.easeOutCubic).shimmer(),

                Positioned.fill(
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.4),
                        shape: BoxShape.circle,
                      ),
                      child:
                          const Icon(
                            Icons.play_arrow,
                            size: 60,
                            color: Colors.white,
                          ).animate().scale(
                            duration: 500.ms,
                            curve: Curves.easeOutBack,
                          ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            ExerciseDetails(
              reps: widget.reps,
              restSeconds: widget.restSeconds,
              sets: widget.sets,
              desc: widget.desc,
            ),

            const SizedBox(height: 150),

            GymButton(
              text: "Start Exercise",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExerciseVideoView(videoUrl: videoUrl),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
