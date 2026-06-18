import 'package:flutter/material.dart';
import 'package:flutter_coffee/core/theme/app_color.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final TextAlign textAlign;
  final TextOverflow overflow;
  final int? maxLines;

  const CustomText({
    super.key,
    required this.text,
    this.fontSize = 14.0, // الحجم الافتراضي للنصوص العادية
    this.fontWeight = FontWeight.normal, // الوزن الافتراضي
    this.color = AppColors.textPrimary, // اللون الافتراضي (الأبيض)
    this.textAlign = TextAlign.start,
    this.overflow = TextOverflow.clip,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        // يمكنك هنا تحديد الـ FontFamily لو عندك خط مخصص للـ جيم
      ),
    );
  }
}
