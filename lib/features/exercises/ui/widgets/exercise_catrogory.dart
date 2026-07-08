import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_coffee/core/services/exercise_services.dart';
import 'package:flutter_coffee/features/exercises/data/repositories/repoEx.dart';
import 'package:flutter_coffee/features/exercises/ui/cubit/exercise_category_cubit.dart';
import 'package:flutter_coffee/features/exercises/ui/widgets/exercise_search_field.dart';
import 'package:flutter_coffee/features/exercises/ui/widgets/get_data_tabBar.dart';

class ExerciseCategoryPage extends StatefulWidget {
  const ExerciseCategoryPage({super.key, required this.category});

  final String category;

  @override
  State<ExerciseCategoryPage> createState() => _ExerciseCategoryPageState();
}

class _ExerciseCategoryPageState extends State<ExerciseCategoryPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      create: (_) => ExerciseCategoryCubit(
        ExerciseCategoryRepositoryImpl(ExerciseServices()),
      )..getExercisesByCategory(category: widget.category),

      child: Builder(
        builder: (context) {
          return Column(
            children: [
              ExerciseSearchField(
                onChanged: (query) {
                  context.read<ExerciseCategoryCubit>().getExercisesByCategory(
                    category: widget.category,
                    query: query,
                  );
                },
              ),
              SizedBox(height: 10),
              Expanded(child: GetDataTabbar(category: widget.category)),
            ],
          );
        },
      ),
    );
  }
}
