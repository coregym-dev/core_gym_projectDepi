import 'package:flutter/material.dart';

class GymButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const GymButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        width: double.infinity,
        height: 55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),

          // 🔥 gradient أصفر احترافي
          gradient: const LinearGradient(
            colors: [Color(0xFFFFD54F), Color(0xFFFFB300)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),

          // 🔥 shadow زي التطبيقات الكبيرة
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 10,
              offset: const Offset(0, 6),
            ),
          ],
        ),

        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.3,
            ),
          ),
        ),
      ),
    );
  }
}
