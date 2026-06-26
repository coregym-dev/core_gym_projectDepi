import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_coffee/features/progress/ui/cubit/get_seesions/cubit/get_sessions_cubit.dart';
import 'package:flutter_coffee/features/progress/ui/widgets/build_history_card.dart';

class SliverWorkoutHistoryList extends StatelessWidget {
  const SliverWorkoutHistoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetSessionsCubit, GetSessionsState>(
      builder: (context, state) {
        if (state is GetSessionsLoading) {
          return const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 40),
              child: Center(
                child: CupertinoActivityIndicator(color: Colors.amber),
              ),
            ),
          );
        }

        if (state is GetSessionsError) {
          return SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
              child: Center(
                child: Text(
                  "❌ عفواً، تعذر جلب البيانات:\n${state.errorMessage}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.redAccent, fontSize: 14),
                ),
              ),
            ),
          );
        }

        if (state is GetSessionsSuccess) {
          if (state.sessions.isEmpty) {
            return const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 50),
                child: Center(
                  child: Text(
                    "No history found. Start your first workout!",
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ),
              ),
            );
          }

          return SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final session = state.sessions[index];

                final sessionDate =
                    DateTime.tryParse(session.workoutDate.toString()) ??
                    DateTime.now();

                return BuildHistoryCard(
                      title: session.workoutName,
                      data: sessionDate,
                      durationInSeconds: session.duration,
                      exercisesCount: session.exercisesCount,
                      imageUrl: session.workoutImage,
                    )
                    .animate(delay: 120.ms)
                    .fade(duration: 400.ms)
                    .slideY(begin: 0.25, curve: Curves.easeOutCubic);
              }, childCount: state.sessions.length),
            ),
          );
        }

        return const SliverToBoxAdapter(child: SizedBox.shrink());
      },
    );
  }
}
