import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_coffee/core/theme/app_color.dart';
import 'package:flutter_coffee/features/exercises/ui/cubit/exercise_category_cubit.dart';
import 'package:flutter_coffee/features/workouts/ui/screens/exercise_intro_video_view.dart';
import 'package:flutter_coffee/features/workouts/ui/widgets/exercise_card.dart';

class GetDataTabbar extends StatefulWidget {
  const GetDataTabbar({super.key, required this.category});

  final String category;

  @override
  State<GetDataTabbar> createState() => _GetDataTabbarState();
}

class _GetDataTabbarState extends State<GetDataTabbar> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ExerciseCategoryCubit>().getExercisesByCategory(
        category: widget.category,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExerciseCategoryCubit, ExerciseCategoryState>(
      builder: (context, state) {
        if (state is ExerciseLoading) {
          return const Center(
            child: CupertinoActivityIndicator(color: AppColors.accentPressed),
          );
        }

        if (state is ExerciseError) {
          return Center(child: Text(state.message));
        }

        if (state is ExerciseSuccess) {
          return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 10),
            itemCount: state.exercises.length,
            itemBuilder: (context, index) {
              final exercise = state.exercises[index];

              return ExerciseCard(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExerciseIntroVideoView(
                      exerciseName: exercise.name,
                      videoUrl: exercise.videoUrl ?? "",
                      reps: exercise.defaultReps ?? "",
                      restSeconds: exercise.default_rest.toString(),
                      sets: exercise.defaultSets.toString(),
                      desc: exercise.description ?? "",
                      image: exercise.imageUrl ?? "",
                    ),
                  ),
                ),
                desc: exercise.description ?? '',
                image: exercise.imageUrl ?? '',
                name: exercise.name,
                sets: exercise.defaultSets?.toString() ?? '',
                reps: exercise.defaultReps ?? '',
              );
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
