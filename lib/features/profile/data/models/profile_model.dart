class ProfileModel {
  final String id;
  final int? age;
  final double? weight;
  final double? height;
  final String? goal;
  final String? imageUrl;
  final DateTime? createdAt;
  final String? currentSystemId;
  final String? fullName;
  final String? phone;

  ProfileModel({
    required this.id,
    this.age,
    this.weight,
    this.height,
    this.goal,
    this.imageUrl,
    this.createdAt,
    this.currentSystemId,
    this.fullName,
    this.phone,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] as String,
      age: json['age'] as int?,
      weight: (json['weight'] as num?)?.toDouble(),
      height: (json['height'] as num?)?.toDouble(),
      goal: json['goal'] as String?,
      imageUrl: json['image_url'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      currentSystemId: json['current_system_id'] as String?,
      fullName: json['full_name'] as String?,
      phone: json['phone'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'age': age,
      'weight': weight,
      'height': height,
      'goal': goal,
      'image_url': imageUrl,
      'created_at': createdAt?.toIso8601String(),
      'current_system_id': currentSystemId,
      'full_name': fullName,
      'phone': phone,
    };
  }

  ProfileModel copyWith({
    String? id,
    int? age,
    double? weight,
    double? height,
    String? goal,
    String? imageUrl,
    DateTime? createdAt,
    String? currentSystemId,
    String? fullName,
    String? phone,
  }) {
    return ProfileModel(
      id: id ?? this.id,
      age: age ?? this.age,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      goal: goal ?? this.goal,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
      currentSystemId: currentSystemId ?? this.currentSystemId,
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
    );
  }
}
