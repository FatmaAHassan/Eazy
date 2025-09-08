import 'dart:io';
import 'package:dio/dio.dart';

import '../../../../../core/network/shared_prefrence.dart';

class ProfileService {
  final Dio dio = Dio();

  /// 🟢 Get Profile Data
  Future<Map<String, dynamic>> getProfile() async {
    final token = await getToken();
    if (token == null) throw Exception("No token found, user not logged in.");

    final response = await dio.get(
      "https://easy.syntecheg.com/api/profile",
      options: Options(
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      ),
    );
    print("📌 Service getProfile response: ${response.data}");
    return response.data;
  }

  /// 🟡 Update Profile Data
  Future<Map<String, dynamic>> updateProfile({
    required String name,
    required String email,
    required String phone,
    File? image,
  }) async {
    final token = await getToken();
    if (token == null) throw Exception("No token found, user not logged in.");

    final formData = FormData.fromMap({
      "name": name,
      "email": email,
      "phone": phone,
      if (image != null)
        "image": await MultipartFile.fromFile(
          image.path,
          filename: image.path.split('/').last,
        ),
    });

    final response = await dio.post(
      "https://easy.syntecheg.com/api/profile",
      data: formData,
      options: Options(
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      ),
    );
    print("📌 Service updateProfile response: ${response.data}");
    return response.data;
  }
}
