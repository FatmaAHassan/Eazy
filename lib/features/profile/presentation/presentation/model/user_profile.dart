class UserProfile {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String? image;

  UserProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.image,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      phone: json["phone"],
      image: json["image"],
    );
  }
}
