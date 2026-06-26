import 'package:bloc/bloc.dart';
import 'package:flutter_coffee/features/workouts/data/models/workout_day_model.dart';
import 'package:flutter_coffee/features/workouts/data/repositories/workout_repo.dart';
import 'package:meta/meta.dart';

part 'workout_day_state.dart';

class WorkoutDayCubit extends Cubit<WorkoutDayState> {
  WorkoutRepository workoutRepository;

  WorkoutDayCubit(this.workoutRepository) : super(WorkoutDayInitial());

  final Map<int, List<WorkoutDayModel>> cache = {};
  Future fetchWorkoutDay(int systemId) async {
    try {
      if (cache.containsKey(systemId)) {
        emit(WorkoutDaySuccess(workoutDay: cache[systemId]!));
        return;
      }
      emit(WorkoutDayLoad());
      final response = await workoutRepository.fetchWorkoutDays(systemId);
      cache[systemId] = response;
      emit(WorkoutDaySuccess(workoutDay: response));
    } catch (e) {
      print(e.toString());
    }
  }
}
