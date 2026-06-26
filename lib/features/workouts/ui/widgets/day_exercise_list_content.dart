import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_coffee/core/theme/app_color.dart';
import 'package:flutter_coffee/features/workouts/ui/cubit/exercise_cubit.dart';
import 'package:flutter_coffee/features/workouts/ui/cubit/exercise_state.dart';
import 'package:flutter_coffee/features/workouts/ui/screens/exercise_intro_video_view.dart';
import 'package:flutter_coffee/features/workouts/ui/widgets/exercise_card.dart';

class DayExercisesListContent extends StatefulWidget {
  final int dayId;

  const DayExercisesListContent({super.key, required this.dayId});

  @override
  State<DayExercisesListContent> createState() =>
      _DayExercisesListContentState();
}

class _DayExercisesListContentState extends State<DayExercisesListContent> {
  @override
  void initState() {
    super.initState();

    context.read<DayExercisesCubit>().fetchDayExercises(widget.dayId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DayExercisesCubit, DayExercisesState>(
      builder: (context, state) {
        if (state is DayExercisesLoading) {
          return const SliverToBoxAdapter(
            child: SizedBox(
              height: 300,
              child: Center(
                child: CupertinoActivityIndicator(color: AppColors.accentColor),
              ),
            ),
          );
        }

        if (state is DayExercisesSuccess) {
          final exercisesList = state.dayExercises;

          if (exercisesList.isEmpty) {
            return const SliverToBoxAdapter(
              child: SizedBox(
                height: 200,
                child: Center(
                  child: Text(
                    'لا توجد تمارين مضافة لهذا اليوم بعد',
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                ),
              ),
            );
          }

          // 🌟 السحر هنا: سيلفر ليست ناعمة جداً في الريندر
          return SliverPadding(
            padding: const EdgeInsets.only(bottom: 30), // أمان مسافة تحت اللستة
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final exercise = exercisesList[index];
                final data = exercise.exerciseDetails;
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  child: TweenAnimationBuilder(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: Duration(milliseconds: 500 + (index * 100)),
                    builder:
                        (BuildContext context, double value, Widget? child) {
                          return Transform.translate(
                            offset: Offset(
                              0,
                              50 * (1 - value),
                            ), // الإزاحة من أسفل لأعلى
                            child: Opacity(
                              opacity: value, // تدرج الشفافية
                              child: child,
                            ),
                          );
                        },
                    child: ExerciseCard(
                      desc: data?.description ?? "",
                      image: data?.imageUrl ?? "",
                      name: data?.name ?? "",
                      reps: exercise.repsCount,
                      sets: "${exercise.setsCount} Sets",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ExerciseIntroVideoView(
                              desc: data?.description ?? "",
                              reps: exercise.repsCount,
                              restSeconds: exercise.restTime,
                              sets: exercise.setsCount.toString(),
                              exerciseName: data?.name ?? "",
                              videoUrl: data?.videoUrl ?? "",
                              image: data?.imageUrl ?? "",
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              }, childCount: exercisesList.length),
            ),
          );
        }

        if (state is DayExercisesError) {
          return SliverToBoxAdapter(
            child: SizedBox(
              height: 200,
              child: Center(
                child: Text(
                  'Load fail: ${state.message}',
                  style: const TextStyle(color: Colors.redAccent),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        }

        return const SliverToBoxAdapter(child: SizedBox());
      },
    );
  }
}
