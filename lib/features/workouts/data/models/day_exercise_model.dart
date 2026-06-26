import 'package:flutter_coffee/features/workouts/data/models/exercise_model.dart';

class DayExerciseModel {
  final int id;
  final int dayId;
  final int exerciseId;
  final int setsCount;
  final String repsCount;
  final int orderIndex;
  final String restTime;

  final ExerciseModel? exerciseDetails;

  DayExerciseModel({
    required this.id,
    required this.dayId,
    required this.exerciseId,
    required this.setsCount,
    required this.repsCount,
    required this.orderIndex,
    required this.restTime,

    this.exerciseDetails,
  });

  factory DayExerciseModel.fromJson(Map<String, dynamic> json) {
    return DayExerciseModel(
      id: json['id'] as int,
      dayId: json['day_id'] as int,
      exerciseId: json['exercise_id'] as int,
      setsCount: json['sets_count'] as int,
      repsCount: json['reps_count'] as String,
      orderIndex: json['order_index'] as int,
      restTime: json['rest_time'] as String,

      // عمل Mapping لبيانات التمرين لو راجعة من الـ query
      exerciseDetails: json['exercises'] != null
          ? ExerciseModel.fromJson(json['exercises'] as Map<String, dynamic>)
          : null,
    );
  }
}
