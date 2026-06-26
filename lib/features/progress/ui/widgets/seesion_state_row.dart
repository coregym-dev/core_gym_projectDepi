import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_coffee/core/theme/app_color.dart';
import 'package:flutter_coffee/features/progress/ui/cubit/create_sessions/workout_session_cubit.dart';
import 'package:flutter_coffee/features/progress/ui/cubit/create_sessions/workout_session_state.dart';
import 'package:flutter_coffee/features/progress/ui/widgets/build_state_card.dart';

class SessionStateRow extends StatelessWidget {
  const SessionStateRow({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkoutSessionCubit, WorkoutSessionState>(
      builder: (context, state) {
        final cubit = context.read<WorkoutSessionCubit>();
        Duration minutes = cubit.Time ~/ 60;
        Duration hours = minutes ~/ 60;

        return Row(
          children: [
            BuildStateCard(
              title: "Total Work",
              value: "${cubit.totalexercise}",
              icon: Icons.fitness_center,
              color: AppColors.accentColor,
            ),

            const SizedBox(width: 12),

            BuildStateCard(
              title: "Total Time",
              value: hours.toString(),
              icon: Icons.timer,
              color: Colors.green,
            ),
          ],
        );
      },
    );
  }
}
