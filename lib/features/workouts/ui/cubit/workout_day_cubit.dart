import 'package:bloc/bloc.dart';
import 'package:flutter_coffee/features/workouts/data/models/workout_day_model.dart';
import 'package:flutter_coffee/features/workouts/data/repositories/workout_repo.dart';
import 'package:meta/meta.dart';

part 'workout_day_state.dart';

class WorkoutDayCubit extends Cubit<WorkoutDayState> {
  WorkoutRepository workoutRepository;

  WorkoutDayCubit(this.workoutRepository) : super(WorkoutDayInitial());

  List<WorkoutDayModel> cachedDays = [];

  Future fetchWorkoutDay(int systemId) async {
    try {
      if (cachedDays.isNotEmpty) {
        emit(WorkoutDaySuccess(workoutDay: cachedDays));
        return;
      }
      emit(WorkoutDayLoad());
      final response = await workoutRepository.fetchWorkoutDays(systemId);
      cachedDays = response;
      emit(WorkoutDaySuccess(workoutDay: cachedDays));
    } catch (e) {
      print(e.toString());
    }
  }
}
