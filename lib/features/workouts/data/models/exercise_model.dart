// موديل التمرين الأساسي (مبني على جدول exercises في image_f0d763.jpg)
class ExerciseModel {
  final int id;
  final String name;
  final String? description;
  final String? muscleGroup;
  final String? imageUrl;
  final String? videoUrl;

  ExerciseModel({
    required this.id,
    required this.name,
    this.description,
    this.muscleGroup,
    this.imageUrl,
    this.videoUrl,
  });

  factory ExerciseModel.fromJson(Map<String, dynamic> json) {
    return ExerciseModel(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String?,
      muscleGroup: json['muscle_group'] as String?,
      imageUrl: json['image_url'] as String?,
      videoUrl: json['video_url'] as String?,
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
    };
  }
}
