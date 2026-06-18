part of 'workout_day_cubit.dart';

@immutable
sealed class WorkoutDayState {}

final class WorkoutDayInitial extends WorkoutDayState {}

final class WorkoutDayLoad extends WorkoutDayState {}

final class WorkoutDaySuccess extends WorkoutDayState {
  List<WorkoutDayModel> workoutDay;
  WorkoutDaySuccess({required this.workoutDay});
}

final class WorkoutDayFail extends WorkoutDayState {
  String erroMess;
  WorkoutDayFail({required this.erroMess});
}
