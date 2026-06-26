import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter_coffee/features/workouts/data/models/workout_model.dart';
import 'package:flutter_coffee/features/workouts/data/repositories/workout_repo.dart';
import 'package:meta/meta.dart';

part 'workout_system_state.dart';

class WorkoutSystemCubit extends Cubit<WorkoutSystemState> {
  WorkoutSystemCubit(this.workoutRepository) : super(WorkoutSystemInitial());
  WorkoutRepository workoutRepository;
  bool isFetched = false;
  Future fetchWorkoutSystems() async {
    try {
      if (isFetched) return;
      isFetched = true;
      emit(WorkoutSystemLoad());
      final response = await workoutRepository.fetchWorkoutSystems();
      emit(WorkoutSystemSuccess(WorkoutModel: response));
    } catch (e) {
      print(e.toString());
    }
  }
}
