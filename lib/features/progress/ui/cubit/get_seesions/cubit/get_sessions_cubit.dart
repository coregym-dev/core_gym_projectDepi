import 'package:bloc/bloc.dart';
import 'package:flutter_coffee/features/progress/data/models/seesion_model.dart';
import 'package:flutter_coffee/features/progress/data/repositories/session_repo.dart';
import 'package:meta/meta.dart';

part 'get_sessions_state.dart';

class GetSessionsCubit extends Cubit<GetSessionsState> {
  final SessionRepo sessionRepo;

  GetSessionsCubit(this.sessionRepo) : super(GetSessionsInitial());

  Future<void> fetchWorkoutHistory() async {
    emit(GetSessionsLoading()); // 1. ابدأ التحميل

    try {
      final response = await sessionRepo.getWorkoutHistory();

      emit(GetSessionsSuccess(sessions: response));
    } catch (e) {
      // 5. لو حصل أي خطأ ابعت حالة الـ Error
      emit(GetSessionsError(errorMessage: e.toString()));
    }
  }
}
