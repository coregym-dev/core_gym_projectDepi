import 'package:flutter_coffee/features/workouts/data/models/workout_day_model.dart';
import 'package:flutter_coffee/features/workouts/data/models/workout_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class WorkoutServices {
  final _supabase = Supabase.instance.client;

  Future<List<WorkoutSystemModel>?> fetchWorkoutSystems() async {
    try {
      final response = await _supabase
          .from("workout_systems")
          .select('id, name, image_url, description');

      print("========================================");
      print(response);
      print("========================================");

      return response.map((e) => WorkoutSystemModel.fromJson(e)).toList();
    } catch (e) {
      print("Error:${e.toString()}");
    }
    return [];
  }

  Future<List<WorkoutDayModel>?> fetchWorkoutDay({
    required int systemId,
  }) async {
    try {
      final response = await _supabase
          .from("workout_days")
          .select('id, system_id, day_name, muscle')
          .eq('system_id', systemId);

      print("========================================");
      print(response);
      print("========================================");

      return response.map((e) => WorkoutDayModel.fromJson(e)).toList();
    } catch (e) {
      print("Error:${e.toString()}");
    }
    return [];
  }
}
