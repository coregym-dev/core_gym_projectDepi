import 'package:flutter/material.dart';
import 'package:flutter_coffee/features/workouts/ui/widgets/my_program_card.dart';

class DisplayMyProgram extends StatelessWidget {
  const DisplayMyProgram({
    super.key,
    required this.exercise,
    required this.onDelete,
  });

  final List<Map<String, dynamic>> exercise;
  final Function(int index) onDelete;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        return MyProgramCard(
          exercise: exercise[index],
          onDelete: () => onDelete(index),
        );
      }, childCount: exercise.length),
    );
  }
}
