import 'package:flutter_coffee/core/services/workout_services.dart';
import 'package:flutter_coffee/features/workouts/data/models/workout_day_model.dart';
import 'package:flutter_coffee/features/workouts/data/models/workout_model.dart';

abstract class WorkoutRepository {
  Future<List<WorkoutSystemModel>> fetchWorkoutSystems();
  Future<List<WorkoutDayModel>> fetchWorkoutDays(int systemId);
}

class WorkoutRepositoryImpl implements WorkoutRepository {
  final WorkoutServices _workoutServices;
  WorkoutRepositoryImpl(this._workoutServices);
  @override
  Future<List<WorkoutSystemModel>> fetchWorkoutSystems() async {
    try {
      final response = await _workoutServices.fetchWorkoutSystems();
      return response ?? [];
    } catch (e) {
      print("Error : ${e.toString()}");

      rethrow;
    }
  }

  @override
  Future<List<WorkoutDayModel>> fetchWorkoutDays(int systemId) async {
    try {
      final response = await _workoutServices.fetchWorkoutDay(
        systemId: systemId,
      );
      return response ?? [];
    } catch (e) {
      print("Error  ${e.toString()}");

      rethrow;
    }
  }
}
