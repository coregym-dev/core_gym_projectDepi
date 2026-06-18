import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WorkoutDayCard extends StatelessWidget {
  final String name;
  final String muscleGroup;
  final void Function()? onTap;
  const WorkoutDayCard({
    super.key,
    required this.name,
    required this.muscleGroup,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E), // نفس درجة الخلفية الغامقة عندك
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.white.withOpacity(0.05),
          ), // خط حواف خفيف جداً
        ),
        child: Row(
          children: [
            // بدل الدائرة.. هنعمل كارت صغير جواه أيقونة أو رقم اليوم
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.amber.withOpacity(0.1), // لون الثيم الأصفر بتاعك
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.fitness_center,
                color: Colors.amber,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            // النصوص
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name, // مثلاً Push Day
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    muscleGroup, // العضلات المستهدفة
                    style: TextStyle(color: Colors.grey[400], fontSize: 14),
                  ),
                ],
              ),
            ),
            // سهم الانتقال بشكل شيك وأصغر
            Icon(Icons.arrow_forward_ios, color: Colors.grey[600], size: 16),
          ],
        ),
      ),
    );
  }
}
