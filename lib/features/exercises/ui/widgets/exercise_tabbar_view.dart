import 'package:flutter/material.dart';

import 'package:flutter_coffee/features/exercises/ui/widgets/exercise_catrogory.dart';

class ExerciseTabbarView extends StatefulWidget {
  const ExerciseTabbarView({super.key, required this.tabController});

  final TabController tabController;

  @override
  State<ExerciseTabbarView> createState() => _ExerciseDisplayState();
}

class _ExerciseDisplayState extends State<ExerciseTabbarView>
    with AutomaticKeepAliveClientMixin {
  final List<String> _muscleGroups = [
    'chest',
    'back',
    'legs',
    'shoulder',
    'arms',
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return TabBarView(
      controller: widget.tabController,
      children: List.generate(
        _muscleGroups.length,
        (index) => ExerciseCategoryPage(category: _muscleGroups[index]),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
