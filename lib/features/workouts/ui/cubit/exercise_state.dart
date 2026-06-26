import 'package:flutter_coffee/features/workouts/data/models/day_exercise_model.dart';
import 'package:flutter_coffee/features/workouts/data/models/exercise_model.dart';

abstract class DayExercisesState {}

// الحالة الابتدائية قبل ما نعمل أي حاجة
class DayExercisesInitial extends DayExercisesState {}

// حالة التحميل (لما نكون بنجيب الداتا من Supabase والـ CircularProgressIndicator شغال)
class DayExercisesLoading extends DayExercisesState {}

// حالة النجاح ومعاها لستة التمارين اللي رجعت عشان نعرضها في الـ UI
class DayExercisesSuccess extends DayExercisesState {
  final List<DayExerciseModel> dayExercises;
  DayExercisesSuccess(this.dayExercises);
}

class MyProgramUpdated {}

// حالة الفشل أو الخطأ (لو السيرفر وقع أو مفيش نت مثلاً) ومعاها رسالة الخطأ
class DayExercisesError extends DayExercisesState {
  final String message;
  DayExercisesError(this.message);
}
