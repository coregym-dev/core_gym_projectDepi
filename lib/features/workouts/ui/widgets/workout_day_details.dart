import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_coffee/core/services/workout_services.dart';
import 'package:flutter_coffee/core/theme/app_color.dart';
import 'package:flutter_coffee/core/widget/custom_text.dart';
import 'package:flutter_coffee/features/workouts/data/repositories/workout_repo.dart';
import 'package:flutter_coffee/features/workouts/ui/cubit/workout_day_cubit.dart';
import 'package:flutter_coffee/features/workouts/ui/screens/exercise_list_view.dart';
import 'package:flutter_coffee/features/workouts/ui/widgets/workout_day_card.dart';

class WorkoutDayDetails extends StatefulWidget {
  final int systemId;
  const WorkoutDayDetails({super.key, required this.systemId});

  @override
  State<WorkoutDayDetails> createState() => _WorkoutDayDetailsState();
}

class _WorkoutDayDetailsState extends State<WorkoutDayDetails> {
  @override
  void initState() {
    super.initState();
    context.read<WorkoutDayCubit>().fetchWorkoutDay(widget.systemId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkoutDayCubit, WorkoutDayState>(
      builder: (context, state) {
        if (state is WorkoutDayLoad) {
          return const Center(
            child: CupertinoActivityIndicator(color: AppColors.accentColor),
          );
        }

        if (state is WorkoutDayFail) {
          return Center(child: CustomText(text: state.erroMess));
        }

        if (state is WorkoutDaySuccess) {
          final data = state.workoutDay;

          // لو الـ List جاية فاضية من السيرفر عشان نضمن إن شكل الشاشة نظيف
          if (data.isEmpty) {
            return const Center(
              child: CustomText(text: "No days found for this system"),
            );
          }

          return ListView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: data.length,
            itemBuilder: (context, index) => WorkoutDayCard(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ExerciseListView(
                    muscle: data[index].muscle ?? "",
                    name: data[index].dayName,
                  ),
                ),
              ),
              name: data[index].dayName,
              muscleGroup: data[index].muscle ?? "",
            ),
          );
        }

        return SizedBox.shrink();
      },
    );
  }
}
