part of 'exercise_category_cubit.dart';

@immutable
sealed class ExerciseCategoryState {}

final class ExerciseCategoryInitial extends ExerciseCategoryState {}

final class ExerciseLoading extends ExerciseCategoryState {}

final class ExerciseSuccess extends ExerciseCategoryState {
  final List<ExerciseModel> exercises;
  ExerciseSuccess(this.exercises);
}

final class ExerciseError extends ExerciseCategoryState {
  final String message;

  ExerciseError(this.message);
}
