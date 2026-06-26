import 'package:flutter_coffee/core/services/exercise_services.dart';
import 'package:flutter_coffee/features/workouts/data/models/day_exercise_model.dart';
import 'package:flutter_coffee/features/workouts/data/models/exercise_model.dart';
import 'package:flutter_coffee/features/workouts/data/models/my_program_exercise_model.dart';

abstract class ExerciseRepository {
  Future<List<DayExerciseModel>> fetchDayExercise(int dayId);
  Future<Map<String, dynamic>> createProgram(Map<String, dynamic> program);
  Future<void> createProgramExercises(List<Map<String, dynamic>> exercises);
  Future<List<MyProgramExerciseModel>> fetchMyProgramExercise();
  Future<void> deleteExercise(String id);
  Future<void> deleteAllExercise(String id);
}

class ExerciseRepositoryImpl implements ExerciseRepository {
  ExerciseServices services;
  ExerciseRepositoryImpl(this.services);
  @override
  Future<List<DayExerciseModel>> fetchDayExercise(int dayId) {
    try {
      final response = services.fetchAllDayExercises(dayId);

      return response;
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> createProgram(
    Map<String, dynamic> program,
  ) async {
    return await services.insertProgram(program);
  }

  @override
  Future<void> createProgramExercises(
    List<Map<String, dynamic>> exercises,
  ) async {
    return await services.insertExerciseProgram(exercises);
  }

  @override
  Future<List<MyProgramExerciseModel>> fetchMyProgramExercise() async {
    return await services.fetchMyProgramExercises();
  }

  @override
  Future<void> deleteAllExercise(String id) async {
    await services.deleteExercise(id);
  }

  @override
  Future<void> deleteExercise(String id) async {
    await services.deleteExercise(id);
  }
}
