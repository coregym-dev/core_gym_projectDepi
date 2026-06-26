part of 'my_program_cubit.dart';

@immutable
sealed class MyProgramState {}

final class MyProgramInitial extends MyProgramState {}

final class MyProgramLoad extends MyProgramState {}

final class MyProgramCreate extends MyProgramState {}

final class MyProgramSuccess extends MyProgramState {
  List<MyProgramExerciseModel>? myProgram;
  MyProgramSuccess({required this.myProgram});
}

final class MyProgramFail extends MyProgramState {
  final String errorMess;
  MyProgramFail({required this.errorMess});
}
