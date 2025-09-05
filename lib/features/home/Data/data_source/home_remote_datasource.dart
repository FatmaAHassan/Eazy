// import 'package:eazy/core/Api/api_service.dart';
// import 'package:eazy/features/home/Data/model/home_model.dart';

// class HomeRemoteDataSource {
//   final ApiService apiService;

//   HomeRemoteDataSource(this.apiService);

//   Future<HomeData> fetchHomeData() async {
//     final response = await apiService.get("/home");
//     return HomeData.fromJson(response.data);
//   }
// }
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:eazy/core/Api/api_service.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart' show rootBundle;
import '../model/home_model.dart';

// class HomeRemoteDataSource {
//   Future<HomeData> fetchHomeData() async {
//     if (kIsWeb) {
//       // قراءة JSON من ملف assets لو شغالة على web
//       final jsonString = await rootBundle.loadString("assets/mock/home.json");
//       final jsonMap = json.decode(jsonString);
//       return HomeData.fromJson(jsonMap);
//     } else {
//       // API حقيقي لو على موبايل أو emulator
//       final response = await Dio().get("https://easy.nour-projects.com/api/home");
//       return HomeData.fromJson(response.data);
//     }
//   }
// }

class HomeRemoteDataSource {
  final ApiService apiService;

  HomeRemoteDataSource(this.apiService);

  Future<HomeData> fetchHomeData() async {
    if (kIsWeb) {
      final jsonString = await rootBundle.loadString("assets/mock/home.json");
      final jsonMap = json.decode(jsonString);
      return HomeData.fromJson(jsonMap);
    } else {
      final response = await apiService.dio.get(
        "https://easy.nour-projects.com/api/home",
      ); // نستخدم الـ getter
      return HomeData.fromJson(response.data);
    }
  }
}
