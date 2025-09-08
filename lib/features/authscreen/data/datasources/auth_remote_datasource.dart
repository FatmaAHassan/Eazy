import 'package:dio/dio.dart';
import '../../../../core/network/shared_prefrence.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String emailPhone, String password);
  Future<String> register(String name, String email, String password, String phone);
  Future<String> sendOtp(String phone);
  Future<String> verifyOtp(String phone, String otp);
  Future<String> forgetPassword({
    required String phone,
    required String otp,
    required String password,
    required String passwordConfirmation,
  });
  Future<String> resetPassword({
    required String phone,
    required String otp,
    required String password,
    required String passwordConfirmation,
  });



  Future<String> updatePassword(String oldPassword, String newPassword, String PasswordConfirmation);
  Future<void> logout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl(this.dio);

  /// ============================= LOGIN =============================
  @override
  Future<UserModel> login(String emailPhone, String password) async {
    try {
      final response = await dio.post(
        "https://easy.syntecheg.com/api/login",
        data: {"email_phone": emailPhone, "password": password},
      );

      final user = UserModel.fromJson(response.data);

      // ✨ حفظ التوكن في SharedPreferences
      if (user.token != null) {
        await saveToken(user.token!);
      }

      return user;
    } catch (e) {
      throw Exception(_handleError(e, "فشل تسجيل الدخول"));
    }
  }

  /// ============================= REGISTER =============================
  @override
  Future<String> register(String name, String email, String password, String phone) async {
    try {
      final response = await dio.post(
        "https://easy.syntecheg.com/api/register",
        data: {
          "name": name,
          "email": email,
          "password": password,
          "phone": phone,
        },
      );

      return response.data["message"] ?? "تم التسجيل بنجاح";
    } catch (e) {
      throw Exception(_handleError(e, "فشل التسجيل"));
    }
  }

  /// ============================= SEND OTP =============================
  @override
  Future<String> sendOtp(String phone) async {
    try {
      final response = await dio.post(
        "https://easy.syntecheg.com/api/otp",
        data: {"phone": phone},
      );
      return response.data["message"] ?? "تم إرسال OTP";
    } catch (e) {
      throw Exception(_handleError(e, "فشل إرسال OTP"));
    }
  }

  /// ============================= VERIFY OTP =============================
  @override
  Future<String> verifyOtp(String phone, String otp) async {
    try {
      final response = await dio.post(
        "https://easy.syntecheg.com/api/verify",
        data: {"phone": phone, "otp": otp},
      );

      if (response.data["success"] == true) {
        return response.data["message"] ?? "تم التحقق بنجاح";
      } else {
        throw Exception(response.data["message"] ?? "فشل التحقق");
      }
    } catch (e) {
      throw Exception(_handleError(e, "فشل التحقق من OTP"));
    }
  }

  /// ============================= FORGET PASSWORD =============================
  @override
  Future<String> resetPassword({
    required String phone,
    required String otp,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      final token = await getToken();
      final response = await dio.post(
        "https://easy.syntecheg.com/api/updatepassword",
        data: {
          "otp": otp,
          "phone": phone,
          "password": password,
          "password_confirmation": passwordConfirmation,
        },
        options: Options(headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        }),
      );

      if (response.data["success"] == true) {
        return response.data["message"] ?? "تم التحديث بنجاح";
      } else {
        throw Exception(response.data["message"] ?? "فشل التحديث");
      }
    } catch (e) {
      throw Exception(_handleError(e, "فشل إعادة تعيين كلمة المرور"));
    }
  }
  /// ============================= RESET PASSWORD =============================
  @override
  Future<String> forgetPassword({
    required String phone,
    required String otp,
    required String password,
    required String passwordConfirmation,
  }) async {
    // نفس المنطق لـ forgetPassword
    return forgetPassword(
      phone: phone,
      otp: otp,
      password: password,
      passwordConfirmation: passwordConfirmation,
    );
  }

  /// ============================= UPDATE PASSWORD =============================
  @override
  Future<String> updatePassword(String oldPassword, String newPassword,String passwordConfirmation) async {
    try {
      final token = await getToken();
      final response = await dio.post(
        "https://easy.syntecheg.com/api/password",
        data: {"old_password": oldPassword, "password": newPassword , "password_confirmation":passwordConfirmation},
        options: Options(headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        }),
      );

      return response.data["message"] ?? "تم تحديث كلمة المرور بنجاح";
    } catch (e) {
      throw Exception(_handleError(e, "فشل تحديث كلمة المرور"));
    }
  }

  /// ============================= LOGOUT =============================
  @override
  Future<void> logout() async {
    await clearToken();
  }

  /// ============================= ERROR HANDLER =============================
  String _handleError(Object e, String defaultMessage) {
    if (e is DioError && e.response != null) {
      return e.response?.data["message"] ?? defaultMessage;
    }
    return defaultMessage;
  }
}
