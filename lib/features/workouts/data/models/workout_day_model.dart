class WorkoutDayModel {
  final int? id;
  final int systemId;
  final String dayName;
  final String? muscle;

  WorkoutDayModel({
    this.id,
    required this.systemId,
    required this.dayName,
    this.muscle,
  });

  factory WorkoutDayModel.fromJson(Map<String, dynamic> json) {
    return WorkoutDayModel(
      id: json['id'] as int?,
      systemId: json['system_id'] as int,
      dayName: json['day_name'] as String,
      muscle: json['muscle'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'system_id': systemId,
      'day_name': dayName,
      'muscle': muscle,
    };
    if (id != null) {
      data['id'] = id;
    }
    return data;
  }
}
