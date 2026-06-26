class SessionModel {
  final int? id;
  final String workoutName;
  final String workoutImage;
  final int duration;
  final int exercisesCount;
  final DateTime workoutDate;

  const SessionModel({
    this.id,
    required this.workoutName,
    required this.workoutImage,
    required this.duration,
    required this.exercisesCount,
    required this.workoutDate,
  });

  factory SessionModel.fromJson(Map<String, dynamic> json) {
    return SessionModel(
      id: json['id'],
      workoutName: json['workout_name'],
      workoutImage: json['workout_image'],
      duration: json['duration'],
      exercisesCount: json['exercises_count'],
      workoutDate: DateTime.parse(json['workout_date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'workout_name': workoutName,
      'workout_image': workoutImage,
      'duration': duration,
      'exercises_count': exercisesCount,
      'workout_date': workoutDate.toIso8601String(),
    };
  }
}
