
import 'package:dio/dio.dart';

class ApiService {
  late Dio _dio;

  ApiService() {
    BaseOptions options = BaseOptions(
      baseUrl: "https://easy.syntecheg.com/api", // حطي نفس baseUrl هنا
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        "Content-Type": "application/json",
      },
    );
    _dio = Dio(options);
  }

  Future<Response> get(String url) async {
    try {
      final response = await _dio.get(url);
      return response;
    } on DioException catch (e) {
      throw Exception("GET request error: ${e.message}");
    }
  }
}
