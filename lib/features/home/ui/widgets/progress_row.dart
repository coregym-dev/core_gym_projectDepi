import 'package:flutter/material.dart';
import 'package:flutter_coffee/features/home/ui/widgets/progress_start.dart';

class ProgressRow extends StatelessWidget {
  const ProgressRow({super.key, required this.stats});

  final List<Map<String, dynamic>> stats;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(stats.length, (i) {
        final stat = stats[i];

        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: i < stats.length - 1 ? 10 : 0),
            child: ProgressStat(label: stat['label'], value: stat['value']),
          ),
        );
      }),
    );
  }
}
