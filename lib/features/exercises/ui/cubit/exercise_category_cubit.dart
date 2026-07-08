import 'package:bloc/bloc.dart';
import 'package:flutter_coffee/features/exercises/data/repositories/repoEx.dart';
import 'package:flutter_coffee/features/workouts/data/models/exercise_model.dart';
import 'package:meta/meta.dart';
part 'exercise_category_state.dart';

class ExerciseCategoryCubit extends Cubit<ExerciseCategoryState> {
  ExerciseCategoryCubit(this._repository) : super(ExerciseCategoryInitial());

  final ExerciseCategoryRepository _repository;

  final Map<String, List<ExerciseModel>> _cache = {};

  Future<void> getExercisesByCategory({
    required String category,
    String? query = "",
  }) async {
    if (_cache.containsKey(category) && query == "") {
      emit(ExerciseSuccess(_cache[category]!));
      return;
    }
    if (_cache.containsKey(category) && query != null && query != "") {
      final q = query.toLowerCase();

      final data = _cache[category]!
          .where((e) => e.name.toLowerCase().contains(q))
          .toList();

      emit(ExerciseSuccess(data));
      return;
    }

    emit(ExerciseLoading());

    try {
      final exercises = await _repository.getExercisesByCategory(category);
      _cache[category] = exercises;
      print("==================================");
      print(exercises);
      print("==================================");
      if (isClosed) return;
      emit(ExerciseSuccess(exercises));
    } catch (e) {
      emit(ExerciseError(e.toString()));
    }
  }
}
