import 'package:flutter/material.dart';
import 'package:flutter_coffee/core/theme/app_color.dart';
import 'package:flutter_coffee/features/workouts/ui/widgets/Preset_Programs.dart';
import 'package:flutter_coffee/features/workouts/ui/widgets/my_program.dart';

class SystemTabsFilter extends StatefulWidget {
  const SystemTabsFilter({super.key});

  @override
  State<SystemTabsFilter> createState() => _SystemTabsFilterState();
}

class _SystemTabsFilterState extends State<SystemTabsFilter>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor, // الخلفية السوداء للتطبيق
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xff1C1C1E),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(4),
                  child: TabBar(
                    physics: const ClampingScrollPhysics(),

                    indicator: BoxDecoration(
                      color: AppColors.accentColor, // نفس لون الخلفية أو شفاف
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: const Color(
                          0xffE2A812,
                        ), // اللون الأصفر الدهبي اللي في الصورة
                        width: 1.5,
                      ),
                    ),

                    labelColor: const Color.fromRGBO(255, 255, 255, 1),
                    unselectedLabelColor: Colors.grey[400],
                    labelStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Inter',
                    ),
                    unselectedLabelStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),

                    dividerColor: Colors.transparent,
                    indicatorSize: TabBarIndicatorSize.tab,

                    tabs: const [
                      Tab(text: "Present Program"),
                      Tab(text: "My Programs"),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                Expanded(
                  child: TabBarView(children: [PresetPrograms(), MyProgram()]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
