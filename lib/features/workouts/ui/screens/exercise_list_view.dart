import 'package:flutter/material.dart';
import 'package:flutter_coffee/core/theme/app_color.dart';
import 'package:flutter_coffee/core/widget/custom_text.dart';

class ExerciseListView extends StatefulWidget {
  final String name;
  final String muscle;
  const ExerciseListView({super.key, required this.muscle, required this.name});

  @override
  State<ExerciseListView> createState() => _ExerciseListViewState();
}

class _ExerciseListViewState extends State<ExerciseListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppColors.backgroundColor,
            floating: false,
            pinned: true,
            flexibleSpace: Padding(
              padding: const EdgeInsets.only(top: 40, left: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: widget.name,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  CustomText(text: widget.muscle, color: Colors.grey.shade200),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
