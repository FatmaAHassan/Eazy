import 'package:dio/dio.dart';

class ApiService {
  final Dio dio;

  ApiService(this.dio) {
    dio.options.baseUrl = "https://easy.syntecheg.com/api"; // غيره باللينك الأساسي
    dio.options.connectTimeout = const Duration(seconds: 30);
    dio.options.receiveTimeout = const Duration(seconds: 30);

    dio.options.headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
    };
  }

  Future<Response> get(String endPoint, {Map<String, dynamic>? query}) async {
    return await dio.get(endPoint, queryParameters: query);
  }

  Future<Response> post(String endPoint, {Map<String, dynamic>? data}) async {
    return await dio.post(endPoint, data: data);
  }

  Future<Response> put(String endPoint, {Map<String, dynamic>? data}) async {
    return await dio.put(endPoint, data: data);
  }

  Future<Response> delete(String endPoint, {Map<String, dynamic>? data}) async {
    return await dio.delete(endPoint, data: data);
  }
}
