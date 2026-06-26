import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_coffee/features/progress/ui/cubit/create_sessions/workout_session_cubit.dart';
import 'package:flutter_coffee/features/progress/ui/cubit/create_sessions/workout_session_state.dart';
import 'package:gap/gap.dart';

class TimerExercise extends StatefulWidget {
  const TimerExercise({super.key});

  @override
  State<TimerExercise> createState() => _TimerExerciseState();
}

class _TimerExerciseState extends State<TimerExercise> {
  Stopwatch stopwatch = Stopwatch();
  String formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    final seconds = duration.inSeconds % 60;

    return '${hours.toString().padLeft(2, '0')}:'
        '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkoutSessionCubit, WorkoutSessionState>(
      builder: (context, state) {
        final isRunning = state.isRunning;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xff1E1E1E),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.white.withOpacity(.08)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Workout Timer",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Gap(10),
                const Icon(
                  Icons.timer_outlined,
                  color: Color(0xffFFD54F),
                  size: 34,
                ),

                const SizedBox(height: 12),

                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 300),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isRunning! ? 42 : 36,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2,
                  ),
                  child: Text("${formatDuration(state.elapsed!)}"),
                ),

                const SizedBox(height: 20),

                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: 58,
                  decoration: BoxDecoration(
                    color: isRunning
                        ? Colors.green.shade600
                        : const Color(0xffFFD54F),
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color:
                            (isRunning ? Colors.green : const Color(0xffFFD54F))
                                .withOpacity(.35),
                        blurRadius: 20,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(18),
                      onTap: () {
                        isRunning
                            ? context.read<WorkoutSessionCubit>().pauseWorkout()
                            : context
                                  .read<WorkoutSessionCubit>()
                                  .startWorkout();
                      },
                      child: Center(
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 250),
                          transitionBuilder: (child, animation) {
                            return ScaleTransition(
                              scale: animation,
                              child: child,
                            );
                          },
                          child: isRunning
                              ? const Row(
                                  key: ValueKey('pause'),
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.pause, color: Colors.white),
                                    SizedBox(width: 8),
                                    Text(
                                      'PAUSE',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                )
                              : const Row(
                                  key: ValueKey('start'),
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.play_arrow, color: Colors.black),
                                    SizedBox(width: 8),
                                    Text(
                                      'START',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 52),
                    side: BorderSide(color: Colors.white.withOpacity(.15)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  onPressed: () {
                    context.read<WorkoutSessionCubit>().resetWorkout();
                  },
                  icon: const Icon(Icons.refresh, color: Colors.white70),
                  label: const Text(
                    "RESET",
                    style: TextStyle(
                      color: Colors.white70,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
