class WorkoutSessionState {
  final Duration? elapsed;
  int? completedExercises;
  final bool? isRunning;
  final bool? isFinished;

  WorkoutSessionState({
    this.elapsed = Duration.zero,
    this.completedExercises = 0,
    this.isRunning = false,
    this.isFinished = false,
  });

  WorkoutSessionState copyWith({
    Duration? elapsed,
    int? completedExercises,
    bool? isRunning,
    bool? isFinished,
  }) {
    return WorkoutSessionState(
      elapsed: elapsed ?? this.elapsed,
      completedExercises: completedExercises ?? this.completedExercises,
      isRunning: isRunning ?? this.isRunning,
      isFinished: isFinished ?? this.isFinished,
    );
  }
}
