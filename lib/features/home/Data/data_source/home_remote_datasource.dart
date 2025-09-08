import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:eazy/core/Api/api_service.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart' show rootBundle;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/home_model.dart';

class HomeRemoteDataSource {
  final ApiService apiService;

  HomeRemoteDataSource(this.apiService);

  Future<HomeData> fetchHomeData() async {
    if (kIsWeb) {
      // 🔹 لو Web → نقرأ JSON محلي
      final jsonString = await rootBundle.loadString("assets/mock/home.json");
      final jsonMap = json.decode(jsonString);
      return HomeData.fromJson(jsonMap);
    } else {
      // 🔹 لو موبايل → نجيب التوكين من SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("access_token");

      if (token == null) {
        throw Exception("Token not found in SharedPreferences");
      }

      final response = await apiService.dio.get(
        "https://easy.syntecheg.com/api/home",
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      return HomeData.fromJson(response.data);
    }
  }
}
