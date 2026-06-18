import 'package:flutter/material.dart';
import 'package:flutter_coffee/core/widget/custom_image.dart';
import 'package:flutter_coffee/core/widget/custom_text.dart';
import 'package:flutter_coffee/features/workouts/ui/screens/system_details_screen.dart';

class WorkoutCard extends StatelessWidget {
  final String? image;
  final String? name;
  final String? description;
  final void Function()? onTap;

  const WorkoutCard({
    super.key,
    this.image,
    this.name,
    this.description,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 100,
        margin: EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(0),
        decoration: BoxDecoration(
          color: const Color(0xff1A1F29),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            CustomImage(
              image: image ?? "",
              height: double.infinity,
              width: 110,
              radious: 14,
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: name ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,

                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),

                  const SizedBox(height: 8),

                  CustomText(
                    text: description ?? "",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,

                    color: Colors.white.withOpacity(.7),
                    fontSize: 15,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
