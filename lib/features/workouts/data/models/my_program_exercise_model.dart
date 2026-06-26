class MyProgramExerciseModel {
  String id;
  String name;
  int sets;
  int reps;
  int rest;
  String? imageUrl;
  String programId;

  MyProgramExerciseModel({
    required this.id,
    required this.name,
    required this.sets,
    required this.reps,
    required this.rest,
    this.imageUrl,
    required this.programId,
  });

  factory MyProgramExerciseModel.fromJson(Map<String, dynamic> map) {
    return MyProgramExerciseModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      sets: map['sets'] ?? 0,
      reps: map['reps'] ?? 0,
      rest: map['rest'] ?? 0,
      imageUrl: map['image_url'],
      programId: map['program_id'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'sets': sets,
      'reps': reps,
      'rest': rest,
      'image_url': imageUrl,
      'program_id': programId,
    };
  }
}
