import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_coffee/features/workouts/ui/cubit/my_program_cubit.dart';
import 'package:flutter_coffee/features/workouts/ui/screens/workouts_view.dart';
import 'package:flutter_coffee/features/workouts/ui/widgets/display_my_program.dart';
import 'package:flutter_coffee/features/workouts/ui/widgets/my_program_header.dart';
import 'package:flutter_coffee/features/workouts/ui/widgets/save_my_program.dart';

class CreateMyProgramScreen extends StatefulWidget {
  const CreateMyProgramScreen({super.key});

  @override
  State<CreateMyProgramScreen> createState() => _CreateMyProgramScreenState();
}

class _CreateMyProgramScreenState extends State<CreateMyProgramScreen> {
  final _programNameController = TextEditingController();
  final List<Map<String, dynamic>> _exercises = [];

  void _addNewExercise() {
    setState(() {
      _exercises.add({
        'name': TextEditingController(),
        'sets': TextEditingController(),
        'reps': TextEditingController(),
        'rest': TextEditingController(),
        'image_url': null,
      });
    });
  }

  void deleteNewExercise(int index) {
    setState(() {
      _exercises[index]['name'].dispose();
      _exercises[index]['sets'].dispose();
      _exercises[index]['reps'].dispose();
      _exercises[index]['rest'].dispose();

      _exercises.removeAt(index);
    });
  }

  @override
  void dispose() {
    _programNameController.dispose();
    for (var ex in _exercises) {
      ex['name'].dispose();
      ex['sets'].dispose();
      ex['reps'].dispose();
      ex['rest'].dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color(0xFF121212);
    const surfaceColor = Color(0xFF1E1E1E);
    const accentColor = Color(0xFFFFCC00);
    const textColor = Colors.white;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          MyProgramHeader(),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Program Name",
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _programNameController,
                    style: const TextStyle(color: textColor),
                    decoration: InputDecoration(
                      hintText: "e.g., Push Day",
                      filled: true,
                      fillColor: surfaceColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Exercises",
                        style: TextStyle(
                          color: textColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton.icon(
                        onPressed: _addNewExercise,
                        icon: const Icon(
                          Icons.add,
                          color: accentColor,
                          size: 18,
                        ),
                        label: const Text(
                          "Add Exercise",
                          style: TextStyle(
                            color: accentColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: accentColor.withOpacity(0.1),
                        ),
                      ),
                    ],
                  ),
                  if (_exercises.isEmpty)
                    Container(
                      margin: const EdgeInsets.only(top: 15),
                      width: double.infinity,
                      padding: const EdgeInsets.all(30),
                      child: const Text(
                        "No exercises added yet.",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                ],
              ),
            ),
          ),

          DisplayMyProgram(
            exercise: _exercises,
            onDelete: (index) => deleteNewExercise(index),
          ), // save card
          if (_exercises.isNotEmpty)
            SaveMyProgram(
              onPressed: () async {
                final cubit = context.read<MyProgramCubit>();

                final exercises = _exercises.map((e) {
                  return {
                    "name": e['name'].text,
                    "sets": int.tryParse(e['sets'].text) ?? 0,
                    "reps": int.tryParse(e['reps'].text) ?? 0,
                    "rest": int.tryParse(e['rest'].text) ?? 0,
                    "image_url": cubit.imageExercise?.path ?? "",
                  };
                }).toList();

                final id = await cubit.createProgramWithExercises(
                  name: _programNameController.text,
                  imageUrl: cubit.imageHeader?.path ?? "",
                  exercises: exercises,
                );

                Future.delayed(const Duration(milliseconds: 800), () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => WorkoutsView()),
                  );
                });

                if (cubit.state is MyProgramCreate) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) {
                      return Dialog(
                        backgroundColor: const Color(0xFF1E1E1E),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              CircleAvatar(
                                radius: 35,
                                backgroundColor: Color(0xFFFFCC00),
                                child: Icon(
                                  Icons.check,
                                  size: 40,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                "Program Created",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Your workout program has been saved successfully.",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
        ],
      ),
    );
  }
}
