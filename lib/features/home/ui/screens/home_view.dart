import 'package:flutter/material.dart';
import 'package:flutter_coffee/core/theme/app_color.dart';
import 'package:flutter_coffee/features/home/ui/widgets/build_header.dart';
import 'package:flutter_coffee/features/home/ui/widgets/quick_start_card.dart';
import 'package:flutter_coffee/features/home/ui/widgets/sectoin_title.dart';
import 'package:flutter_coffee/features/home/ui/widgets/today_workout_card.dart';
import 'package:flutter_coffee/features/progress/ui/widgets/seesion_state_row.dart';

class HomeView extends StatefulWidget {
  PageController controller;
  HomeView({super.key, required this.controller});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BuildHeader(),

              const SizedBox(height: 24),

              // ─── Today's Workout ───
              SectionTitle(title: "Workout"),
              const SizedBox(height: 12),
              TodayWorkoutCard(controller: widget.controller),
              const SizedBox(height: 28),

              // ─── Quick Start ───
              SectionTitle(title: "Quick Start"),
              const SizedBox(height: 12),

              const SizedBox(height: 8),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  QuickStartCard(imageUrl: "images/bench.webp", label: "Push"),
                  QuickStartCard(imageUrl: "images/bench.webp", label: "Push"),
                  QuickStartCard(imageUrl: "images/bench.webp", label: "Push"),
                ],
              ),
              // ─── Progress ───
              const SizedBox(height: 8),
              SectionTitle(title: "Progess"),
              const SizedBox(height: 12),
              SessionStateRow(),
            ],
          ),
        ),
      ),
    );
  }
}
