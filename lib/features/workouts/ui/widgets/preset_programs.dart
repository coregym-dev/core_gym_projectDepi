import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_coffee/core/theme/app_color.dart';
import 'package:flutter_coffee/core/widget/custom_text.dart';

import 'package:flutter_coffee/features/workouts/ui/cubit/workout_system_cubit.dart';
import 'package:flutter_coffee/features/workouts/ui/screens/system_details_screen.dart';
import 'package:flutter_coffee/features/workouts/ui/widgets/workout_card.dart';

class PresetPrograms extends StatefulWidget {
  const PresetPrograms({super.key});

  @override
  State<PresetPrograms> createState() => _PresetProgramsState();
}

class _PresetProgramsState extends State<PresetPrograms> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkoutSystemCubit, WorkoutSystemState>(
      builder: (context, state) {
        if (state is WorkoutSystemLoad) {
          return const Center(
            child: CupertinoActivityIndicator(color: AppColors.accentColor),
          );
        }
        if (state is WorkoutSystemFail) {
          return Center(child: CustomText(text: "${state.errorMess}"));
        }
        if (state is WorkoutSystemSuccess) {
          final data = state.WorkoutModel;
          return ListView.builder(
            addAutomaticKeepAlives: true,
            itemCount: data.length,
            itemBuilder: (context, index) => TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: Duration(milliseconds: 500 + (index * 100)),
              builder: (BuildContext context, double value, Widget? child) {
                return Transform.translate(
                  offset: Offset(0, 50 * (1 - value)), // الإزاحة من أسفل لأعلى
                  child: Opacity(
                    opacity: value, // تدرج الشفافية
                    child: child,
                  ),
                );
              },
              child: WorkoutCard(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SystemDetailsScreen(
                      image: data[index].imageUrl ?? "",
                      height: 250,
                      width: double.infinity,
                      systemId: data[index].id,
                      description: data[index].description,
                      name: data[index].name,
                    ),
                  ),
                ),
                image: data[index].imageUrl,
                name: data[index].name,
                description: data[index].description,
              ),
            ),
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
