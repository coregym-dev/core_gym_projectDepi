import 'package:flutter/material.dart';
import 'package:flutter_coffee/core/theme/app_color.dart';
import 'package:flutter_coffee/core/widget/custom_text.dart';

class MoreOptionsButton extends StatelessWidget {
  final String firstTitle;
  final VoidCallback? onFirstTap;

  const MoreOptionsButton({
    super.key,
    required this.firstTitle,

    this.onFirstTap,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      tooltip: '',
      splashRadius: 20,
      popUpAnimationStyle: AnimationStyle(
        duration: Duration(milliseconds: 500),
        curve: Curves.decelerate,
      ),
      color: AppColors.dividerColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      elevation: 8,
      offset: const Offset(0, 10),
      icon: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(.05),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Icon(
          Icons.more_vert_rounded,
          color: Colors.white70,
          size: 20,
        ),
      ),
      onSelected: (value) {
        if (value == 1) {
          onFirstTap?.call();
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          child: Row(
            children: [
              const Icon(Icons.delete_outline, size: 20, color: Colors.white),
              const SizedBox(width: 12),
              CustomText(
                text: "delete",
                color: Colors.red,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
