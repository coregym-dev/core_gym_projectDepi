import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_coffee/core/theme/app_color.dart';
import 'package:flutter_coffee/features/workouts/ui/cubit/my_program_cubit.dart';
import 'package:image_picker/image_picker.dart';

class MyProgramHeader extends StatefulWidget {
  const MyProgramHeader({super.key});

  @override
  State<MyProgramHeader> createState() => _MyProgramHeaderState();
}

class _MyProgramHeaderState extends State<MyProgramHeader> {
  XFile? imagePath;

  Future addImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      setState(() {
        if (image != null) {
          imagePath = image;
          context.read<MyProgramCubit>().setImageHeader(image);
        }
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return // الـ AppBar الاحترافي
    SliverAppBar(
      expandedHeight: 220.0,
      pinned: true,
      backgroundColor: AppColors.cardColor,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.white,
          size: 20,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.only(bottom: 16),
        title: const Text(
          "CREATE PROGRAM",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
            letterSpacing: 1.5,
          ),
        ),
        background: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF2A2A2A), AppColors.backgroundColor],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            Center(
              child: Container(
                margin: const EdgeInsets.only(bottom: 30),
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  color: AppColors.cardColor,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.accentColor.withOpacity(0.5),
                    width: 2,
                  ),
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
            ),
          ],
        ),
      ),
    );

    //
  }
}
