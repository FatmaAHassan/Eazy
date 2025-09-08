// // features/auth/data/datasources/auth_local_datasource.dart
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../models/user_model.dart';
//
// abstract class AuthLocalDataSource {
//   Future<void> cacheUser(UserModel user);
//   Future<UserModel?> getCachedUser();
//   Future<String?> getToken();
//   Future<void> clearCachedUser();
// }
//
// class AuthLocalDataSourceImpl implements AuthLocalDataSource {
//   final SharedPreferences prefs;
//   static const _CACHED_USER = 'CACHED_USER';
//
//   AuthLocalDataSourceImpl(this.prefs);
//
//   @override
//   Future<void> cacheUser(UserModel user) async {
//     final jsonString = jsonEncode(user.toJson());
//     await prefs.setString(_CACHED_USER, jsonString);
//   }
//
//   @override
//   Future<UserModel?> getCachedUser() async {
//     final jsonString = prefs.getString(_CACHED_USER);
//     if (jsonString == null) return null;
//     final Map<String, dynamic> map = jsonDecode(jsonString);
//     return UserModel.fromJson(map);
//   }
//
//   @override
//   Future<String?> getToken() async {
//     final user = await getCachedUser();
//     return user?.token;
//   }
//
//   @override
//   Future<void> clearCachedUser() async {
//     await prefs.remove(_CACHED_USER);
//   }
// }
