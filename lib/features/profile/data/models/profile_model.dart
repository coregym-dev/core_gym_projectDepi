class ProfileUser {
  final String? id;
  final double? weight;
  final double? height;
  final String? imageUrl;
  final String? currentSystemId;
  final String? fullName;
  final String? phone;
  final String? email;

  ProfileUser({
    this.weight,
    this.height,
    this.id,
    this.imageUrl,
    this.currentSystemId,
    this.fullName,
    this.phone,

    this.email,
  });

  // تحويل البيانات القادمة من Supabase (Map) إلى Object
  factory ProfileUser.fromJson(Map<String, dynamic> json) {
    return ProfileUser(
      id: json["id"],
      weight: json['weight'] != null
          ? (json['weight'] as num).toDouble()
          : null,
      height: json['height'] != null
          ? (json['height'] as num).toDouble()
          : null,
      imageUrl: json['image_url'] as String?,
      currentSystemId: json['current_system_id'] as String?,
      fullName: json['full_name'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
    );
  }

  // تحويل الـ Object إلى Map لإرساله إلى Supabase
  Map<String, dynamic> toJson() {
    return {
      'weight': weight,
      'height': height,
      'image_url': imageUrl,
      'current_system_id': currentSystemId,
      'full_name': fullName,
      'phone': phone,
      'email': email,
    };
  }
}
