import '../entities/user.dart';
import '../../../../core/utils/either.dart';
import '../../../../core/error/failure.dart';
import '../../data/models/user_model.dart'; // for cachedUser

abstract class AuthRepository {
  // ==================== Remote ====================
  Future<Either<Failure, User>> login(String email_phone, String password);
  Future<Either<Failure, String>> register(
      String name, String email, String password, String phone);
  Future<Either<Failure, String>> sendOtp(String phone, );
  Future<Either<Failure, String>> verifyOtp(String phone, String otp);

  Future<Either<Failure, String>> forgetPassword({
    required String phone,
    required String otp,
    required String password,
    required String passwordConfirmation,
  });

  Future<Either<Failure, String>> resetPassword({
    required String phone,
    required String otp,
    required String password,
    required String passwordConfirmation,
  });

  Future<Either<Failure, String>> updatePassword(
      String oldPassword, String newPassword, String passwordConfirmation);

  // // ==================== Local ====================
  // Future<String?> getToken();
  // Future<UserModel?> getCachedUser();
  // Future<void> logout();
}
