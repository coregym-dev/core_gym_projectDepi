import 'package:flutter/material.dart';
import 'package:flutter_coffee/core/theme/app_color.dart';
import 'package:flutter_coffee/features/exercises/ui/screens/exercise_view.dart';
import 'package:flutter_coffee/features/home/ui/screens/home_view.dart';
import 'package:flutter_coffee/features/profile/ui/screens/profile_view.dart';
import 'package:flutter_coffee/features/progress/ui/screens/progress_view.dart';
import 'package:flutter_coffee/features/workouts/ui/screens/workouts_view.dart';

class RootView extends StatefulWidget {
  const RootView({super.key});

  @override
  State<RootView> createState() => _RootViewState();
}

class _RootViewState extends State<RootView> {
  final PageController controller = PageController();
  int indexScreen = 0;

  // الخمس شاشات الخاصة بالتطبيق
  final List<Widget> screens = [
    const HomeView(),
    const WorkoutsView(),
    const ExerciseView(),
    const ProgressView(),
    const ProfileView(),
  ];

  void _onItemTapped(int index) {
    setState(() => indexScreen = index);
    controller.animateToPage(
      indexScreen,
      duration: const Duration(
        milliseconds: 200,
      ), // تعديل الوقت ليكون التنقل أنعم
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    controller.dispose(); // تنظيف الـ Controller من الذاكرة
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        physics:
            const NeverScrollableScrollPhysics(), // منع السحب باليد لتجنب تداخل الشاشات مع ألعاب الجيم
        onPageChanged: (value) => setState(() => indexScreen = value),
        children: screens,
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
        ), // مسافة رأسية مريحة للأزرار
        decoration: const BoxDecoration(
          color: AppColors.cardColor,
          border: Border(
            top: BorderSide(
              color: Color(0xff2C2C2E),
              width: 0.5,
            ), // خط علوي خفيف جداً للفصل
          ),
        ),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home_outlined, 0), // الشاشة الرئيسية
              _buildNavItem(
                Icons.fitness_center,
                1,
              ), // التمارين والأنظمة (Workouts)
              _buildNavItem(
                Icons.format_list_bulleted,
                2,
              ), // مكتبة التمارين (Exercise Library)
              _buildNavItem(
                Icons.bar_chart_outlined,
                3,
              ), // شاشة التقدم (Progress)
              _buildNavItem(Icons.person_outline, 4), // الحساب الشخصي (Profile)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    final bool isSelected = indexScreen == index;
    return IconButton(
      icon: Icon(
        icon,
        color: isSelected ? AppColors.accentColor : AppColors.textSecondary,
        size: isSelected ? 33 : 26, // حركة تكبير خفيفة واحترافية عند الاختيار
      ),
      onPressed: () => _onItemTapped(index),
    );
  }
}
