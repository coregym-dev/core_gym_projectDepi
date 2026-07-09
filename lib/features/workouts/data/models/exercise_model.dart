class ExerciseModel {
  final int id;
  final String name;
  final String? description;
  final String? muscleGroup;
  final String? imageUrl;
  final String? videoUrl;
  final String? category;
  final int? defaultSets;
  final String? defaultReps;
  final String? defaultRest;

  ExerciseModel({
    required this.id,
    required this.name,
    this.description,
    this.muscleGroup,
    this.imageUrl,
    this.videoUrl,
    this.category,
    this.defaultSets,
    this.defaultReps,
    this.defaultRest,
  });

  factory ExerciseModel.fromJson(Map<String, dynamic> json) {
    return ExerciseModel(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String?,
      muscleGroup: json['muscle_group'] as String?,
      imageUrl: json['image_url'] as String?,
      videoUrl: json['video_url'] as String?,
      category: json['category'] as String?,
      defaultSets: json['default_sets'] as int?,
      defaultReps: json['default_reps'] as String?,
      defaultRest: json['default_rest'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'muscle_group': muscleGroup,
      'image_url': imageUrl,
      'video_url': videoUrl,
      'category': category,
      'default_sets': defaultSets,
      'default_reps': defaultReps,
      'default_rest': defaultRest,
    };
  }
}
