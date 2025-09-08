import 'dart:convert';
import 'package:eazy/features/Subscriptions/Screens/Api%20UpgradeNow/upgradeNow_Model.dart';
import 'package:http/http.dart' as http;

import '../../../../core/network/shared_prefrence.dart'; // هنا ملف shared preferences بتاعك

class SubscriptionRepository {
  final String baseUrl = "https://easy.syntecheg.com/api"; // عدل حسب الـ API

  Future<subscription?> getSubscription() async {
    try {
      // 1- هات التوكن من shared preferences
      final token = await getToken();

      if (token == null) {
        throw Exception("مفيش توكن محفوظ، المستخدم مش عامل تسجيل دخول");
      }

      // 2- نطلب البيانات من السيرفر
      final response = await http.get(
        Uri.parse("$baseUrl/package"),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token", // مهم
        },
      );

      print("Status: ${response.statusCode}");
      print("Body: ${response.body}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return subscription.fromJson(data);
      } else {
        throw Exception("فشل في تحميل البيانات: ${response.statusCode}\n${response.body}");
      }
    } catch (e) {
      throw Exception("خطأ: $e");
    }
  }
}
