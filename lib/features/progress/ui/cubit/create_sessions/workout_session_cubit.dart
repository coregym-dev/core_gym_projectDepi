import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_coffee/features/progress/data/index.dart';
import 'package:flutter_coffee/features/progress/ui/cubit/create_sessions/workout_session_state.dart';

class WorkoutSessionCubit extends Cubit<WorkoutSessionState> {
  WorkoutSessionCubit(this.sessionRepo) : super(WorkoutSessionState());
  SessionRepo sessionRepo;
  final Stopwatch stopwatch = Stopwatch();

  Timer? timer;
  Duration totalTime = Duration.zero;
  int countExrcise = 0;
  int totalexercise = 0;
  Duration Time = Duration.zero;

  /// Start Workout
  void startWorkout() {
    if (stopwatch.isRunning) return;

    stopwatch.start();

    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      emit(state.copyWith(elapsed: stopwatch.elapsed, isRunning: true));
    });
  }

  /// Pause Workout
  void pauseWorkout() {
    stopwatch.stop();
    timer?.cancel();

    emit(state.copyWith(elapsed: stopwatch.elapsed, isRunning: false));
  }

  /// Resume Workout
  void resumeWorkout() {
    startWorkout();
  }

  /// Finish Workout
  void finishExercise() {
    stopwatch.stop();
    timer?.cancel();
    totalTime += state.elapsed ?? Duration.zero;
    totalexercise++;
    countExrcise++;
    Time += state.elapsed ?? Duration.zero;

    stopwatch.reset();
    emit(
      state.copyWith(
        elapsed: Duration.zero,
        isRunning: false,
        isFinished: true,
      ),
    );
  }

  void finishWorkOut(List<Map<String, dynamic>> sessions) async {
    await sessionRepo.createSession(sessions);
    totalTime = Duration.zero;
    countExrcise = 0;
  }

  void completeExercise() {
    emit(state.copyWith(completedExercises: state.completedExercises! + 1));
  }

  /// New Workout
  void resetWorkout() {
    stopwatch
      ..stop()
      ..reset();

    timer?.cancel();

    emit(WorkoutSessionState());
  }

  @override
  Future<void> close() {
    timer?.cancel();
    stopwatch.stop();
    return super.close();
  }
}
