part of 'workout_system_cubit.dart';

@immutable
sealed class WorkoutSystemState {}

final class WorkoutSystemInitial extends WorkoutSystemState {}

final class WorkoutSystemLoad extends WorkoutSystemState {}

final class WorkoutSystemSuccess extends WorkoutSystemState {
  List<WorkoutSystemModel> WorkoutModel;
  WorkoutSystemSuccess({required this.WorkoutModel});
}

final class WorkoutSystemFail extends WorkoutSystemState {
  String errorMess;
  WorkoutSystemFail({required this.errorMess});
}
