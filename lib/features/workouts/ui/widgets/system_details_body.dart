import 'package:flutter/material.dart';
import 'package:flutter_coffee/core/widget/custom_text.dart';
import 'package:flutter_coffee/features/workouts/ui/widgets/workout_day_details.dart';

class SystemDetailsBody extends StatefulWidget {
  final int? systemId;
  const SystemDetailsBody({super.key, required this.systemId});

  @override
  State<SystemDetailsBody> createState() => _SystemDetailsBodyState();
}

class _SystemDetailsBodyState extends State<SystemDetailsBody>
    with AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    const Color accentGold = Color.fromRGBO(179, 147, 53, 1);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
          child: Row(
            children: [
              Container(
                width: 4,
                height: 18,
                decoration: BoxDecoration(
                  color: accentGold,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 8),
              const CustomText(
                text: "Training Days",
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ],
          ),
        ),

        // جلب وعرض الأيام بناءً على الـ ID
        widget.systemId != null
            ? Expanded(child: WorkoutDayDetails(systemId: widget.systemId!))
            : const Center(child: CustomText(text: "Invalid System ID")),
      ],
    );
  }
}
