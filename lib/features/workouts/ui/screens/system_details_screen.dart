import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // حماية للـ Status Bar
import 'package:flutter_coffee/core/theme/app_color.dart';
import 'package:flutter_coffee/core/widget/custom_image.dart';
import 'package:flutter_coffee/core/widget/custom_text.dart';
import 'package:flutter_coffee/features/workouts/ui/widgets/custom_backBtn.dart';
import 'package:flutter_coffee/features/workouts/ui/widgets/system_details_body.dart';

class SystemDetailsScreen extends StatefulWidget {
  final String image;
  final double width;
  final double height;
  final String? name;

  final String? description;
  final int? systemId;
  const SystemDetailsScreen({
    super.key,
    required this.image,
    required this.height,
    required this.width,
    required this.description,
    required this.name,
    required this.systemId,
  });

  @override
  State<SystemDetailsScreen> createState() => _SystemDetailsScreenState();
}

class _SystemDetailsScreenState extends State<SystemDetailsScreen>
    with AutomaticKeepAliveClientMixin {
  // ✅ تعريف لون ذهبي مميز للثيم عندك
  static const Color accentGold = Color.fromRGBO(179, 147, 53, 1);
  static const Color subGold = Color.fromRGBO(109, 87, 18, 1);
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    // 💡 حماية وتوحيد لون الـ Status Bar ليكون شفاف فوق الصورة
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent),
    );

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      // ✅ استخدمنا NestedScrollView لتحقيق تأثير الـ Sliver/Collapsing
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: widget.height - 40,
              floating: false,
              pinned: true,
              backgroundColor: AppColors.backgroundColor,
              elevation: 0,
              automaticallyImplyLeading: false, // سنصمم زر الرجوع بأنفسنا
              // ✅ الجزء السحري: تصميم الصورة والنصوص المدمجة
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: [
                    CustomImage(
                      image: widget.image,
                      height: double.infinity,
                      width: double.infinity,
                      radious: 0,
                    ),
                    // ✅ تدرج أسود خفي في الأسفل لجعل النصوص واضحة
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              AppColors.backgroundColor.withOpacity(0.9),
                              AppColors.backgroundColor,
                            ],
                          ),
                        ),
                      ),
                    ),
                    // ✅ النصوص (اسم النظام والوصف) فوق التدرج
                    Positioned(
                      left: 16,
                      bottom: 24,
                      right: 16,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: widget.name ?? "Workout System",
                            fontSize: 28, // خط كبير وواضح
                            fontWeight: FontWeight.bold,
                            color: accentGold,
                          ),
                          const SizedBox(height: 8),
                          CustomText(
                            text: widget.description ?? "",
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.white70, // لون أبيض خافت للوصف
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // ✅ تصميم زر الرجوع العائم باحترافية
              title: CustomBackButton(onTap: () => Navigator.pop(context)),
            ),
          ];
        },

        body: SystemDetailsBody(systemId: widget.systemId, image: widget.image),
      ),
    );
  }
}
