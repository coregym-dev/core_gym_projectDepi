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
        final duration = cubit.Time;

        return Row(
          children: [
            BuildStateCard(
              title: "Total Work",
              value: "${cubit.totalexercise}",
              icon: Icons.fitness_center,
              color: AppColors.accentColor,
            ),

            const SizedBox(width: 6),

            BuildStateCard(
              title: "Total Time",
              value:
                  "${duration.inHours}h ${duration.inMinutes.remainder(60)}m ${duration.inSeconds.remainder(60)}s",
              icon: Icons.timer,
              color: Colors.green,
            ),
          ],
        );
      },
    );
  }
}
