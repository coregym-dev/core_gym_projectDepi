import 'package:flutter_coffee/core/services/exercise_services.dart';
import 'package:flutter_coffee/features/workouts/data/models/exercise_model.dart';

abstract class ExerciseCategoryRepository {
  Future<List<ExerciseModel>> getExercisesByCategory(String category);
}

class ExerciseCategoryRepositoryImpl implements ExerciseCategoryRepository {
  final ExerciseServices _service;

  ExerciseCategoryRepositoryImpl(this._service);

  @override
  Future<List<ExerciseModel>> getExercisesByCategory(String category) async {
    return await _service.getExercisesByCategory(category);
  }
}
