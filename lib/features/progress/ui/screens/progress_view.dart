import 'package:flutter/material.dart';
import 'package:flutter_coffee/core/theme/app_color.dart';
import 'package:flutter_coffee/core/widget/moreOption_btn.dart';
import 'package:flutter_coffee/features/progress/ui/widgets/seesion_state_row.dart';
import 'package:flutter_coffee/features/progress/ui/widgets/session_history_data.dart';

class ProgressView extends StatefulWidget {
  const ProgressView({super.key});

  @override
  State<ProgressView> createState() => _ProgressViewState();
}

class _ProgressViewState extends State<ProgressView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            floating: true,
            pinned: true,
            expandedHeight: 70,
            actions: [MoreOptionsButton(firstTitle: "Clear History")],
            backgroundColor: AppColors.backgroundColor,
            title: const Text(
              "Workout History",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 10,
              ),
              child: SessionStateRow(),
            ),
          ),

          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(left: 16.0, top: 20, bottom: 10),
              child: Text(
                "Recent Sessions",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          SliverWorkoutHistoryList(),
        ],
      ),
    );
  }
}
