import 'package:flutter_coffee/core/services/sessions_services.dart';
import 'package:flutter_coffee/features/progress/data/models/seesion_model.dart';

abstract class SessionRepo {
  Future<void> createSession(List<Map<String, dynamic>> sessions);

  Future<List<SessionModel>> getWorkoutHistory();
}

class SessionRepoImpl extends SessionRepo {
  SessionsServices services;
  SessionRepoImpl(this.services);
  @override
  Future<void> createSession(List<Map<String, dynamic>> sessions) async {
    await services.createSession(sessions);
  }

  Future<List<SessionModel>> getWorkoutHistory() async {
    try {
      final historyData = await services.getSessionsHistory();
      return historyData;
    } catch (e) {
      // لو حابب تحول الـ Error لـ Failure مخصص هنا، أو تمرره علطول للـ Cubit
      rethrow;
    }
  }
}
