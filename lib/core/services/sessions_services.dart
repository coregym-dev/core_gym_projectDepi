import 'package:flutter_coffee/features/progress/data/models/seesion_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SessionsServices {
  final supabase = Supabase.instance.client;

  Future<void> createSession(List<Map<String, dynamic>> sessions) async {
    try {
      await supabase.from("workout_sessions").insert(sessions).select();
    } catch (e) {
      print("${e.toString()}");
    }
  }

  Future<List<SessionModel>> getSessionsHistory() async {
    try {
      final response = await supabase
          .from("workout_sessions")
          .select()
          .order("workout_date", ascending: false)
          .select();

      return response.map((e) => SessionModel.fromJson(e)).toList();
    } catch (e) {
      print(e.toString());
      // بنعمل rethrow عشان الـ Cubit يلقط الـ Error ويعرض صفحة الخطأ لو حصلت مشكلة
      rethrow;
    }
  }
}
