import '../../domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.token,
     super.tokenType,
     super.expiresIn,
     super.status,
     super.verified,
    super.type,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      token: json["access_token"] ?? "",
      tokenType: json["token_type"] ?? "",
      expiresIn: json["expires_in"] ?? 0,
      status: json["status"] ?? 0,
      verified: json["verified"] ?? 0,
      type: json["type"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "access_token": token,
      "token_type": tokenType,
      "expires_in": expiresIn,
      "status": status,
      "verified": verified,
      "type": type,
    };
  }
}
