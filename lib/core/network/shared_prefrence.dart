import 'package:shared_preferences/shared_preferences.dart';


Future<void> saveToken(String token) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString("access_token", token);
}


Future<String?> getToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString("access_token");
}


Future<void> clearToken() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove("access_token");
}
