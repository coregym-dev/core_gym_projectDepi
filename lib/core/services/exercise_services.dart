import 'package:flutter_coffee/features/workouts/data/models/my_program_exercise_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_coffee/features/workouts/data/models/day_exercise_model.dart';

class ExerciseServices {
  final SupabaseClient _supabase = Supabase.instance.client;

  /// 📌 Get all exercises for a specific day
  Future<List<DayExerciseModel>> fetchAllDayExercises(int dayId) async {
    try {
      final response = await _supabase
          .from('day_exercises')
          .select('*, exercises:exercise_id(*)')
          .eq('day_id', dayId);

      return (response as List)
          .map((e) => DayExerciseModel.fromJson(e))
          .toList();
    } catch (e) {
      print('fetchAllDayExercises Error: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> insertProgram(
    Map<String, dynamic> program,
  ) async {
    try {
      final response = await _supabase
          .from('my_programs')
          .insert(program)
          .select()
          .single();

      return response;
    } catch (e) {
      print('insertProgram Error: $e');
      rethrow;
    }
  }

  /// 📌 Insert exercises for a program
  Future<void> insertExerciseProgram(
    List<Map<String, dynamic>> exercises,
  ) async {
    try {
      await _supabase.from('my_programs_exercises').insert(exercises);
    } catch (e) {
      print('insertExerciseProgram Error: $e');
      rethrow;
    }
  }

  /// 📌 Get all exercises for a specific day
  Future<List<MyProgramExerciseModel>> fetchMyProgramExercises() async {
    try {
      final response = await _supabase.from('my_programs_exercises').select();
      return (response as List)
          .map((e) => MyProgramExerciseModel.fromJson(e))
          .toList();
    } catch (e) {
      print('fetchMyProgramExercises Error: $e');
      rethrow;
    }
  }

  /// 📌 Delete Exercise
  Future<void> deleteExercise(String id) async {
    try {
      await _supabase.from("my_programs_exercises").delete().eq("id", id);
      print("**********************************************");
      print(id);
      print("**********************************************");
    } catch (e) {}
  }

  /// 📌 Delete Exercise
  Future<void> deleteAllExercise(String id) async {
    try {
      await _supabase
          .from("my_programs_exercises")
          .delete()
          .eq("program_id", id);
      await _supabase.from("my_programs").delete().eq("id", id);
    } catch (e) {}
  }
}
