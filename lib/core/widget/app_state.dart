import 'package:flutter/foundation.dart';
import 'package:flutter_coffee/core/constans/appConstants.dart';

class UserProfile {
  String fullName;
  String email;
  String height;
  String weight;
  String dateOfBirth;
  String gender;
  String imageUrl;

  UserProfile({
    required this.fullName,
    required this.email,
    required this.height,
    required this.weight,
    required this.dateOfBirth,
    required this.gender,
    required this.imageUrl,
  });

  factory UserProfile.defaults() => UserProfile(
    fullName: AppConstants.userFullName,
    email: AppConstants.userEmail,
    height: AppConstants.userHeight,
    weight: AppConstants.userWeight,
    dateOfBirth: AppConstants.userDateOfBirth,
    gender: AppConstants.userGender,
    imageUrl: AppConstants.profileImageUrl,
  );

  UserProfile copyWith({
    String? fullName,
    String? email,
    String? height,
    String? weight,
    String? dateOfBirth,
    String? gender,
    String? imageUrl,
  }) {
    return UserProfile(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}

class AppSettings {
  String units;
  bool workoutRemindersEnabled;
  String workoutReminderTime;
  int restTimerSeconds;
  bool darkModeEnabled;

  AppSettings({
    required this.units,
    required this.workoutRemindersEnabled,
    required this.workoutReminderTime,
    required this.restTimerSeconds,
    required this.darkModeEnabled,
  });

  factory AppSettings.defaults() => AppSettings(
    units: AppConstants.unitsValue,
    workoutRemindersEnabled: true,
    workoutReminderTime: '07:00 AM',
    restTimerSeconds: 45,
    darkModeEnabled: true,
  );

  String get restTimerLabel => '$restTimerSeconds sec';

  String get workoutRemindersLabel =>
      workoutRemindersEnabled ? 'On · $workoutReminderTime' : 'Off';
}

class CustomProgram {
  final String id;
  final String name;
  final String description;
  final int daysPerWeek;
  final DateTime createdAt;

  const CustomProgram({
    required this.id,
    required this.name,
    required this.description,
    required this.daysPerWeek,
    required this.createdAt,
  });
}

class WorkoutSessionRecord {
  final String dayName;
  final String muscleGroup;
  final int exerciseCount;
  final DateTime completedAt;

  const WorkoutSessionRecord({
    required this.dayName,
    required this.muscleGroup,
    required this.exerciseCount,
    required this.completedAt,
  });
}

class AppState extends ChangeNotifier {
  AppState._();

  static final AppState instance = AppState._();

  UserProfile profile = UserProfile.defaults();
  AppSettings settings = AppSettings.defaults();
  int rootTabIndex = 0;
  bool isLoggedIn = true;

  final Set<String> favoriteExerciseIds = {};
  final Map<String, bool> fitnessGoals = {
    'Lose Weight': false,
    'Build Muscle': true,
    'Improve Endurance': false,
    'Increase Flexibility': false,
    'Stay Active': true,
  };

  final List<CustomProgram> customPrograms = [];
  final List<WorkoutSessionRecord> workoutHistory = [];

  void switchTab(int index) {
    if (rootTabIndex == index) return;
    rootTabIndex = index;
    notifyListeners();
  }

  void updateProfile(UserProfile updated) {
    profile = updated;
    notifyListeners();
  }

  void updateSettings(AppSettings updated) {
    settings = updated;
    notifyListeners();
  }

  void toggleDarkMode(bool enabled) {
    settings = AppSettings(
      units: settings.units,
      workoutRemindersEnabled: settings.workoutRemindersEnabled,
      workoutReminderTime: settings.workoutReminderTime,
      restTimerSeconds: settings.restTimerSeconds,
      darkModeEnabled: enabled,
    );
    notifyListeners();
  }

  void toggleFavorite(String exerciseId) {
    if (favoriteExerciseIds.contains(exerciseId)) {
      favoriteExerciseIds.remove(exerciseId);
    } else {
      favoriteExerciseIds.add(exerciseId);
    }
    notifyListeners();
  }

  bool isFavorite(String exerciseId) =>
      favoriteExerciseIds.contains(exerciseId);

  void updateGoal(String goal, bool enabled) {
    fitnessGoals[goal] = enabled;
    notifyListeners();
  }

  void addCustomProgram(CustomProgram program) {
    customPrograms.insert(0, program);
    notifyListeners();
  }

  void removeCustomProgram(String id) {
    customPrograms.removeWhere((program) => program.id == id);
    notifyListeners();
  }

  void recordWorkoutSession({
    required String dayName,
    required String muscleGroup,
    required int exerciseCount,
  }) {
    workoutHistory.insert(
      0,
      WorkoutSessionRecord(
        dayName: dayName,
        muscleGroup: muscleGroup,
        exerciseCount: exerciseCount,
        completedAt: DateTime.now(),
      ),
    );
    notifyListeners();
  }

  int get weeklyWorkoutCount {
    final weekStart = DateTime.now().subtract(const Duration(days: 7));
    return workoutHistory
        .where((session) => session.completedAt.isAfter(weekStart))
        .length;
  }

  int get totalWorkouts => workoutHistory.length;

  void logout() {
    profile = UserProfile.defaults();
    settings = AppSettings.defaults();
    favoriteExerciseIds.clear();
    fitnessGoals.updateAll((key, _) {
      if (key == 'Build Muscle' || key == 'Stay Active') return true;
      return false;
    });
    customPrograms.clear();
    workoutHistory.clear();
    rootTabIndex = 0;
    isLoggedIn = false;
    notifyListeners();
  }

  void restoreSession() {
    isLoggedIn = true;
    notifyListeners();
  }
}
