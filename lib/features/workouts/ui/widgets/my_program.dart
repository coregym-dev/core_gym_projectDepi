import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_coffee/core/theme/app_color.dart';
import 'package:flutter_coffee/features/workouts/ui/cubit/my_program_cubit.dart';
import 'package:flutter_coffee/features/workouts/ui/widgets/create_myprogram.dart';
import 'package:flutter_coffee/features/workouts/ui/widgets/exercise_card.dart';
import 'package:flutter_coffee/features/workouts/ui/widgets/exercise_myProgram_card.dart';
import 'package:flutter_coffee/features/workouts/ui/widgets/gym_btn.dart';

class MyProgram extends StatefulWidget {
  const MyProgram({super.key});

  @override
  State<MyProgram> createState() => _MyProgramState();
}

class _MyProgramState extends State<MyProgram> {
  @override
  void initState() {
    super.initState();
    context.read<MyProgramCubit>().fetchMyProgram();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,

      body: BlocBuilder<MyProgramCubit, MyProgramState>(
        builder: (context, state) {
          if (state is MyProgramLoad) {
            return const Center(
              child: CupertinoActivityIndicator(color: AppColors.accentColor),
            );
          }

          if (state is MyProgramFail) {
            return const Center(child: Text("Error loading data"));
          }

          if (state is MyProgramSuccess) {
            final program = state.myProgram ?? [];

            if (program.isEmpty) {
              return Align(
                alignment: Alignment.bottomCenter,
                child: SafeArea(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      color: Color(0xFF1E1E1E),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                    ),
                    child: GymButton(
                      text: "+ Create Program",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const CreateMyProgramScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            }

            return ListView.builder(
              padding: EdgeInsets.only(bottom: 70),
              itemCount: program.length,
              itemBuilder: (context, index) {
                final data = program[index];

                return TweenAnimationBuilder(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: Duration(milliseconds: 500 + (index * 100)),
                  builder: (BuildContext context, double value, Widget? child) {
                    return Transform.translate(
                      offset: Offset(
                        0,
                        50 * (1 - value),
                      ), // الإزاحة من أسفل لأعلى
                      child: Opacity(
                        opacity: value, // تدرج الشفافية
                        child: child,
                      ),
                    );
                  },
                  child: ExerciseMyprogramCard(
                    nameExercise: data.name,
                    imagePath: data.imageUrl ?? "",
                    sets: data.sets.toString(),
                    reps: data.reps.toString(),
                    id: data.id,
                  ),
                );
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: BlocSelector<MyProgramCubit, MyProgramState, bool>(
        selector: (state) {
          return state is MyProgramSuccess &&
              state.myProgram != null &&
              state.myProgram!.isNotEmpty;
        },
        builder: (context, hasProgram) {
          if (!hasProgram) return const SizedBox.shrink();

          return Align(
            alignment: Alignment.bottomCenter,
            child: FloatingActionButton(
              backgroundColor: AppColors.accentColor,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const CreateMyProgramScreen(),
                  ),
                );
              },
              child: const Icon(Icons.add, color: Colors.white),
              elevation: 10,
            ),
          );
        },
      ),
    );
  }
}
