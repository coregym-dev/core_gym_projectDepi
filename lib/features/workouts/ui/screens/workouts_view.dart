import 'package:flutter/material.dart';
import 'package:flutter_coffee/core/theme/app_color.dart';
import 'package:flutter_coffee/core/widget/custom_text.dart';
import 'package:flutter_coffee/features/workouts/ui/widgets/system_tabs_filter.dart';

class WorkoutsView extends StatefulWidget {
  const WorkoutsView({super.key});

  @override
  State<WorkoutsView> createState() => _WorkoutsViewState();
}

class _WorkoutsViewState extends State<WorkoutsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: CustomText(
          text: "WorkOut Systems",
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: const SystemTabsFilter(),
    );
  }
}
