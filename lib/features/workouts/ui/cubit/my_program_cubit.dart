import 'package:bloc/bloc.dart';
import 'package:flutter_coffee/features/workouts/data/models/my_program_exercise_model.dart';
import 'package:flutter_coffee/features/workouts/data/repositories/exercise_repo.dart';
import 'package:flutter_coffee/features/workouts/ui/cubit/exercise_state.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'my_program_state.dart';

class MyProgramCubit extends Cubit<MyProgramState> {
  MyProgramCubit(this.repository) : super(MyProgramInitial());
  ExerciseRepository repository;
  XFile? imageHeader;
  XFile? imageExercise;
  List<MyProgramExerciseModel>? _cachedPrograms;
  String? _cachedId;
  Future createProgramWithExercises({
    required String name,
    required var imageUrl,
    required List<Map<String, dynamic>> exercises,
  }) async {
    try {
      emit(MyProgramLoad());

      // 1. create program
      final program = await repository.createProgram({
        "name": name,
        "image_url": imageUrl,
      });

      final programId = program['id'];

      // 2. attach programId to exercises
      final updatedExercises = exercises.map((e) {
        return {...e, "program_id": programId};
      }).toList();

      // 3. insert exercises
      await repository.createProgramExercises(updatedExercises);

      emit(MyProgramCreate());
      return programId;
    } catch (e) {
      print("================================================");
      emit(MyProgramFail(errorMess: "erro is ${e.toString()}"));
    }
  }

  void setImageHeader(XFile file) {
    imageHeader = file;
    emit(MyProgramCreate());
  }

  void setImageExercise(XFile file) {
    imageExercise = file;
    emit(MyProgramCreate());
  }

  Future<void> fetchMyProgram() async {
    emit(MyProgramLoad());

    try {
      final response = await repository.fetchMyProgramExercise();

      _cachedPrograms = response;

      emit(MyProgramSuccess(myProgram: response));
    } catch (e) {
      emit(MyProgramFail(errorMess: e.toString()));
    }
  }

  void clearCache() {
    _cachedPrograms = null;
    _cachedId = null;
  }

  Future<void> deleteAllExercise(String id) async {
    emit(MyProgramLoad());
    try {
      await repository.deleteAllExercise(id);
      emit(MyProgramCreate());
    } catch (e) {
      emit(MyProgramFail(errorMess: e.toString()));
    }
  }

  Future<void> deleteExercise(String id) async {
    emit(MyProgramLoad());
    try {
      await repository.deleteExercise(id);

      await fetchMyProgram();
    } catch (e) {
      print(e.toString());
      emit(MyProgramFail(errorMess: e.toString()));
    }
  }
}
