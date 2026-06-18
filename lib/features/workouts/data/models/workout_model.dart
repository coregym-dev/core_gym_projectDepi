class WorkoutSystemModel {
  final int? id;
  final String? name;
  final String? description;
  final String? imageUrl;

  WorkoutSystemModel({this.id, this.name, this.description, this.imageUrl});

  // تحويل البيانات القادمة من Supabase / JSON إلى Object
  factory WorkoutSystemModel.fromJson(Map<String, dynamic> json) {
    return WorkoutSystemModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      imageUrl:
          json['image_url']
              as String?, // لاحظ التحويل من image_url إلى imageUrl
    );
  }

  // تحويل الـ Object إلى Map في حال أردت رفع بيانات أو تحديثها
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'description': description,
      'image_url': imageUrl,
    };
  }
}
