import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_coffee/features/workouts/ui/cubit/my_program_cubit.dart';
import 'package:image_picker/image_picker.dart';
import 'mini_input_field.dart'; // استدعاء الملف الأول

class MyProgramCard extends StatefulWidget {
  final Map<String, dynamic> exercise;
  final void Function()? onDelete;
  const MyProgramCard({
    super.key,
    required this.exercise,
    required this.onDelete,
  });

  @override
  State<MyProgramCard> createState() => _MyProgramCardState();
}

class _MyProgramCardState extends State<MyProgramCard> {
  XFile? imagePath;
  Future addImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      setState(() {
        if (image != null) {
          imagePath = image;
          context.read<MyProgramCubit>().setImageExercise(image);
        }
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    const surfaceColor = Color(0xFF1E1E1E);
    const backgroundColor = Color(0xFF121212);
    const textColor = Colors.white;

    return TweenAnimationBuilder(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 500 + (0 * 100)),
      builder: (BuildContext context, double value, Widget? child) {
        return Transform.translate(
          offset: Offset(0, -50 * (1 - value)), // الإزاحة من أسفل لأعلى
          child: Opacity(
            opacity: value, // تدرج الشفافية
            child: child,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // صورة التمرين المصغرة
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: backgroundColor,
                  ),
                  child: InkWell(
                    onTap: () => addImage(),
                    child: Center(
                      child: imagePath == null
                          ? Icon(Icons.add_photo_alternate, color: Colors.white)
                          : ClipOval(
                              child: SizedBox(
                                width: double.infinity,
                                height: double.infinity,
                                child: Image.file(
                                  File(imagePath!.path),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // اسم التمرين
                Expanded(
                  child: TextField(
                    controller: widget.exercise['name'],
                    style: const TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      hintText: "Exercise Name",
                      hintStyle: TextStyle(
                        color: Colors.grey.withOpacity(0.5),
                        fontSize: 15,
                      ),
                      border: InputBorder.none,
                      isDense: true,
                    ),
                  ),
                ),
                // زر الحذف
                IconButton(
                  icon: const Icon(
                    Icons.delete_outline,
                    color: Colors.redAccent,
                    size: 22,
                  ),
                  onPressed: widget.onDelete,
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Divider(color: Colors.white10, height: 1),
            ),
            // صف الإدخالات الثلاثة باستخدام الـ Widget المنفصلة
            Row(
              children: [
                Expanded(
                  child: MiniInputField(
                    controller: widget.exercise['sets'],
                    label: "Sets",
                    hint: "4",
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: MiniInputField(
                    controller: widget.exercise['reps'],
                    label: "Reps",
                    hint: "12",
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: MiniInputField(
                    controller: widget.exercise['rest'],
                    label: "Rest (s)",
                    hint: "60s",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
