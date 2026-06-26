import 'package:flutter/material.dart';
import 'package:flutter_coffee/core/theme/app_color.dart';
import 'package:flutter_coffee/core/widget/custom_image.dart';
import 'package:intl/intl.dart'; // 🔥 مهم جداً لتنسيق التاريخ

class BuildHistoryCard extends StatelessWidget {
  final DateTime data;
  final int durationInSeconds;
  final int exercisesCount;
  final String title;
  final String? imageUrl;

  const BuildHistoryCard({
    super.key, // أضفنا الـ key هنا كأفضل ممارسة لـ Flutter
    required this.data,
    required this.durationInSeconds,
    required this.exercisesCount,
    required this.title,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final int minutes = durationInSeconds ~/ 60;

    final String formattedDate = DateFormat('MMM dd, yyyy').format(data);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: IntrinsicHeight(
          child: Row(
            children: [
              // الـ Indicator الجانبي الملون بيدي لمسة بريميم
              Container(width: 5, color: Colors.amber),

              // الصورة (لو مفيش صورة بنحط شكل افتراضي شيك)
              Container(
                width: 70,
                height: 70,
                margin: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors
                      .white12, // قللت الـ opacity هنا عشان الايقونة تبان أحسن لو مفيش صورة
                  borderRadius: BorderRadius.circular(12),
                ),
                child: imageUrl != null && imageUrl!.isNotEmpty
                    ? CustomImage(
                        image: imageUrl!,
                        height: 70, // خليتها متناسقة مع حجم الـ Container
                        width: 70,
                        radious: 12,
                      )
                    : const Icon(
                        Icons.fitness_center,
                        color: Colors.amber,
                        size: 30,
                      ),
              ),

              // تفاصيل التمرينة
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 4,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_month,
                            size: 14,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            formattedDate, // ✅ عرض التاريخ الحقيقي هنا
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // الأرقام والعدادات على اليمين
              Padding(
                padding: const EdgeInsets.only(
                  right: 16.0,
                  top: 12,
                  bottom: 12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "$minutes min", // ✅ عرض الدقائق المحسوبة ديناميكياً
                      style: const TextStyle(
                        color: Colors.amber,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      "$exercisesCount Exercises", // وعرض عدد التمارين الحقيقي هنا
                      style: const TextStyle(color: Colors.grey, fontSize: 11),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
