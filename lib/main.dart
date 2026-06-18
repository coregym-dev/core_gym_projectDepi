import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_coffee/core/services/workout_services.dart';
import 'package:flutter_coffee/features/root_view.dart';
import 'package:flutter_coffee/features/workouts/data/repositories/workout_repo.dart';
import 'package:flutter_coffee/features/workouts/ui/cubit/workout_day_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url:
        'https://wzsyiwzytaesllibgdvf.supabase.co', // الـ URL بتاعك من اللينك اللي فوق
    anonKey:
        'sb_publishable_snp99wIVMB_g_Yvf1Rg2UA_paOac786', // الـ anon key اللي بتجيبه من الـ API settings
  );

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              WorkoutDayCubit(WorkoutRepositoryImpl(WorkoutServices())),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: RootView());
  }
}
