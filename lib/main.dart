import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_coffee/core/injection_container.dart';
import 'package:flutter_coffee/core/services/exercise_services.dart';
import 'package:flutter_coffee/core/services/sessions_services.dart';
import 'package:flutter_coffee/core/services/workout_services.dart';
import 'package:flutter_coffee/features/auth/data/datasources/datasource.dart';
import 'package:flutter_coffee/features/auth/data/repositories/auth.repository_impl.dart';
import 'package:flutter_coffee/features/auth/domain/repositories/auth.repository.dart';
import 'package:flutter_coffee/features/auth/domain/usecases/index.dart';
import 'package:flutter_coffee/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter_coffee/features/auth/presentation/pages/login.dart';
import 'package:flutter_coffee/features/auth/presentation/pages/signup.dart';
import 'package:flutter_coffee/features/progress/data/index.dart';
import 'package:flutter_coffee/features/progress/ui/cubit/create_sessions/workout_session_cubit.dart';
import 'package:flutter_coffee/features/progress/ui/cubit/get_seesions/cubit/get_sessions_cubit.dart';
import 'package:flutter_coffee/features/root_view.dart';
import 'package:flutter_coffee/features/workouts/data/repositories/exercise_repo.dart';
import 'package:flutter_coffee/features/workouts/data/repositories/workout_repo.dart';
import 'package:flutter_coffee/features/workouts/ui/cubit/exercise_cubit.dart';
import 'package:flutter_coffee/features/workouts/ui/cubit/my_program_cubit.dart';
import 'package:flutter_coffee/features/workouts/ui/cubit/workout_day_cubit.dart';
import 'package:flutter_coffee/features/workouts/ui/cubit/workout_system_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url:
        'https://wzsyiwzytaesllibgdvf.supabase.co', // الـ URL بتاعك من اللينك اللي فوق
    anonKey:
        'sb_publishable_snp99wIVMB_g_Yvf1Rg2UA_paOac786', // الـ anon key اللي بتجيبه من الـ API settings
  );
  initAuthDependencies();
  await Hive.initFlutter();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<AuthCubit>()),
        BlocProvider(
          create: (context) =>
              WorkoutDayCubit(WorkoutRepositoryImpl(WorkoutServices())),
        ),

        BlocProvider(
          create: (context) =>
              DayExercisesCubit(ExerciseRepositoryImpl(ExerciseServices())),
        ),

        BlocProvider(
          create: (context) =>
              WorkoutSystemCubit(WorkoutRepositoryImpl(WorkoutServices()))
                ..fetchWorkoutSystems(),
        ),

        BlocProvider(
          create: (context) =>
              MyProgramCubit(ExerciseRepositoryImpl(ExerciseServices())),
        ),

        BlocProvider(
          create: (context) =>
              WorkoutSessionCubit(SessionRepoImpl(SessionsServices())),
        ),
        BlocProvider(
          create: (context) =>
              GetSessionsCubit(SessionRepoImpl(SessionsServices())),
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
    return ScreenUtilInit(
      designSize: const Size(
        375,
        812,
      ), // دي مقاسات الشاشة في الديزاين، تقدر تغيرها لو الفيجما مقاسها مختلف
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: child, // هنا بيباصي الشاشة اللي إنت محددها تحت
        );
      },
      child: const SignUpPage(), // الشاشة اللي التطبيق بيفتح عليها
    );
  }
}
