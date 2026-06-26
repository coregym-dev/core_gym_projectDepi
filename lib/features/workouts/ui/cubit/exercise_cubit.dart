import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_coffee/core/services/exercise_services.dart';
import 'package:flutter_coffee/features/workouts/data/models/day_exercise_model.dart';
import 'package:flutter_coffee/features/workouts/data/repositories/exercise_repo.dart';
import 'package:flutter_coffee/features/workouts/ui/cubit/exercise_state.dart';
// مسار الموديل

class DayExercisesCubit extends Cubit<DayExercisesState> {
  ExerciseRepository exerciseRepository;

  DayExercisesCubit(this.exerciseRepository) : super(DayExercisesInitial());

  final Map<int, List<DayExerciseModel>> cache = {};
  Future<void> fetchDayExercises(int dayId) async {
    if (cache.containsKey(dayId)) {
      emit(DayExercisesSuccess(cache[dayId]!));
      return;
    }

    emit(DayExercisesLoading());

    try {
      final exercises = await exerciseRepository.fetchDayExercise(dayId);

      cache[dayId] = exercises;

      emit(DayExercisesSuccess(exercises));
    } catch (e) {
      emit(DayExercisesError(e.toString()));
    }
  }
}
