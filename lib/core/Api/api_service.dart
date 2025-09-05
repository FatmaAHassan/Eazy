import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiService {
  late Dio _dio;

  ApiService() {
    final isWeb = kIsWeb;
    final baseUrl = isWeb
        ? "https://jsonkeeper.com/b/DE3J5" // لينك الـ dummy json للويب
        : "https://easy.nour-projects.com/api"; // لينك الـ API الحقيقي

    BaseOptions options = BaseOptions(
      baseUrl: "https://easy.syntecheg.com/api",
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
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
  Dio get dio => _dio;
// Future<Lesson> fetchLesson(int id) async {
//   final response = await _dio.get("/lessons/$id");
//   return Lesson.fromJson(response.data['data']);
// }
//   Future<List<Category>> fetchCategories() async {
//     final response = await _dio.get("/categories");
//     return (response.data['data'] as List)
//         .map((e) => Category.fromJson(e))
//         .toList();
//   }

//   Future<Category> fetchCategory(int id) async {
//     final response = await _dio.get("/categories/$id");
//     return Category.fromJson(response.data['data']);
//   }

//   Future<LessonDetails> fetchLesson(int id) async {
//     final response = await _dio.get("/lessons/$id");
//     return LessonDetails.fromJson(response.data['data']);
//   }
}
