import 'package:flutter/material.dart';
import 'package:flutter_coffee/core/theme/app_color.dart';
import 'package:flutter_coffee/core/widget/custom_image.dart';
import 'package:flutter_coffee/core/widget/custom_text.dart';
import 'package:flutter_coffee/core/widget/moreOption_btn.dart';
import 'package:flutter_coffee/features/workouts/data/models/exercise_model.dart';

class ExerciseCard extends StatelessWidget {
  final String name;
  final String image;
  final String desc;
  final String sets;
  final String reps;

  final VoidCallback? onTap;
  final void Function()? onDoubleTap;
  const ExerciseCard({
    super.key,
    required this.desc,
    required this.image,
    required this.name,
    required this.sets,
    required this.reps,
    this.onDoubleTap,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 3.0),
      decoration: BoxDecoration(
        color: AppColors.cardColor, // لون الخلفية الغامق مطابق للتصميم
        borderRadius: BorderRadius.circular(
          16.0,
        ), // الزوايا الدائرية للكارد الكبير
      ),
      child: InkWell(
        onDoubleTap: onDoubleTap,
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.0),
        child: Padding(
          padding: const EdgeInsets.only(right: 5), // المسافات الداخلية
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              image != null && image.isNotEmpty
                  ? CustomImage(
                      image: image,
                      width: 100,
                      height: 120,
                      radious: 10,
                    )
                  : Icon(Icons.error),
              const SizedBox(width: 16.0), // مسافة بين الصورة والكلام

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomText(
                      text: name,
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,

                      maxLines: 1,
                      overflow: TextOverflow
                          .ellipsis, // لو الاسم طويل يقطع بنقط عشان الـ Overflow
                    ),
                    const SizedBox(height: 4.0),

                    CustomText(
                      text:
                          desc, // أو تقدر تعرض الـ muscleGroup هنا مباشرة حسب الرغبة
                      color: Colors.grey.shade400,
                      fontSize: 14.0,
                    ),
                    const SizedBox(height: 12.0),

                    CustomText(
                      text: '${sets} Sets  •  ${reps} Reps',

                      color: AppColors.accentColor,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w500,
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
