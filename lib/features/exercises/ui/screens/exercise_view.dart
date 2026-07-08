import 'package:flutter/material.dart';
import 'package:flutter_coffee/core/theme/app_color.dart';
import 'package:flutter_coffee/core/widget/custom_text.dart';
import 'package:flutter_coffee/features/exercises/ui/widgets/exercise_tabbar_view.dart';

class ExerciseView extends StatefulWidget {
  const ExerciseView({super.key});

  @override
  State<ExerciseView> createState() => _ExerciseViewState();
}

class _ExerciseViewState extends State<ExerciseView>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;

  late TabController _tabController;
  final List<String> _muscleGroups = [
    'chest',
    'back',
    'legs',
    'shoulder',
    'arms',
  ];
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              actionsPadding: EdgeInsets.only(top: 10),

              backgroundColor: AppColors.backgroundAlt,
              title: CustomText(
                text: 'Exercise Library',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 16)),

            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                height: 47,
                decoration: BoxDecoration(
                  color: const Color(0xff1C1C1E),
                  borderRadius: BorderRadius.circular(12),
                ),

                child: SizedBox(
                  height: 48,
                  child: TabBar(
                    indicatorColor: Colors.black38,

                    controller: _tabController,
                    isScrollable: true,
                    physics: const BouncingScrollPhysics(),

                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    labelPadding: const EdgeInsets.symmetric(horizontal: 4),

                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorPadding: const EdgeInsets.symmetric(vertical: 4),

                    indicatorAnimation: TabIndicatorAnimation.linear,
                    tabAlignment: TabAlignment.start,
                    indicator: BoxDecoration(
                      color: AppColors.accentColor,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: const Color(0xffE2A812),
                        width: 1.5,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 8,
                          offset: Offset(0, 2),
                          color: Color.fromRGBO(226, 168, 18, .25),
                        ),
                      ],
                    ),

                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,

                    labelStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),

                    unselectedLabelStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),

                    dividerColor: const Color.fromARGB(0, 183, 51, 51),

                    splashFactory: NoSplash.splashFactory,
                    overlayColor: WidgetStatePropertyAll(
                      const Color.fromARGB(0, 23, 176, 173),
                    ),

                    tabs: _muscleGroups.map((e) {
                      return Tab(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          child: Text(e[0].toUpperCase() + e.substring(1)),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),

            SliverFillRemaining(
              fillOverscroll: true,
              child: ExerciseTabbarView(tabController: _tabController),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 16)),
          ],
        ),
      ),
    );
  }
}
