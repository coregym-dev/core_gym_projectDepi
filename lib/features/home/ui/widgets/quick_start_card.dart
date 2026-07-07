import 'package:flutter/material.dart';
import 'package:flutter_coffee/core/theme/app_color.dart';
import 'package:flutter_coffee/core/widget/custom_text.dart';

class QuickStartCard extends StatelessWidget {
  const QuickStartCard({
    super.key,
    required this.label,
    required this.imageUrl,
  });

  final String label;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 115,
        margin: EdgeInsets.only(right: 5),
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: AppColors.cardColor,
        ),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              imageUrl,
              width: 100,
              height: 115,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) =>
                  Container(color: const Color(0xff2A2A2A)),
            ),
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Color(0xCC000000)],
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: Center(
                child: CustomText(
                  text: label,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
