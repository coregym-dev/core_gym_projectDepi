import 'package:flutter/material.dart';
import 'quick_start_card.dart';

class QuickStartRow extends StatelessWidget {
  const QuickStartRow({super.key, required this.items});

  final List<Map<String, dynamic>> items;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(items.length, (i) {
        final item = items[i];

        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: i < items.length - 1 ? 10 : 0),
            child: QuickStartCard(
              label: item['label'],
              imageUrl: item['image'],
            ),
          ),
        );
      }),
    );
  }
}
