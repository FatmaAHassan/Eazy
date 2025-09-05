import 'dart:convert';
import 'package:http/http.dart' as http;
import 'ModelMyLesson.dart';


class LessonRepository {
  final String baseUrl = "https://eazy.syntecheg.com/api";

  Future<List<myLesson>> fetchLessons(String token) async {
    final url = Uri.parse("$baseUrl/lessons");

    try {
      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        },
      );

      print("🔎 Status Code: ${response.statusCode}");
      print("🔎 Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // لو السيرفر بيرجع {"data": [...]}
        if (data['data'] != null && data['data'] is List) {
          return (data['data'] as List)
              .map((e) => myLesson.fromJson(e))
              .toList();
        }

        // fallback لو بيرجع ليست مباشرة
        if (data is List) {
          return data.map((e) => myLesson.fromJson(e)).toList();
        }

        throw Exception("البيانات غير متوقعة: ${response.body}");
      } else if (response.statusCode == 401) {
        throw Exception("غير مصرح لك: تحقق من التوكن");
      } else {
        throw Exception("فشل تحميل الدروس: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("❌ خطأ أثناء الاتصال: $e");
    }
  }
}
