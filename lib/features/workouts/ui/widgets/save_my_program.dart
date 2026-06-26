import 'package:flutter/material.dart';
import 'package:flutter_coffee/core/theme/app_color.dart';

class SaveMyProgram extends StatelessWidget {
  const SaveMyProgram({super.key, this.onPressed});
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          width: double.infinity,
          height: 55,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.accentColor, Color(0xFFFFB300)],
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
            ),
            child: const Text(
              "SAVE PROGRAM",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
