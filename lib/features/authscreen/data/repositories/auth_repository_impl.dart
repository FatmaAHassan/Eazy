import 'package:dio/dio.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../../../core/utils/either.dart';
import '../../../../core/error/failure.dart';
import '../datasources/auth_remote_datasource.dart';
import '../datasources/auth_local_datasource.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  // final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    // required this.localDataSource,
  });

  /// ============================= LOGIN =============================
  @override
  Future<Either<Failure, User>> login(String email_phone, String password) async {
    try {
      final userModel = await remoteDataSource.login(email_phone, password);
      // await localDataSource.cacheUser(userModel);
      return Either.right(userModel);
    } on DioError catch (e) {
      final msg = e.response?.data?["message"] ?? e.message;
      return Either.left(Failure(msg.toString()));
    } catch (e) {
      return Either.left(Failure(e.toString()));
    }
  }

  /// ============================= REGISTER =============================
  @override
  Future<Either<Failure, String>> register(
      String name, String email, String password, String phone) async {
    try {
      final message = await remoteDataSource.register(name, email, password, phone);
      return Either.right(message);
    } catch (e) {
      return Either.left(Failure(e.toString()));
    }
  }

  /// ============================= SEND OTP =============================
  @override
  Future<Either<Failure, String>> sendOtp(String phone) async {
    try {
      final message = await remoteDataSource.sendOtp(phone);
      return Either.right(message);
    } catch (e) {
      return Either.left(Failure(e.toString()));
    }
  }

  /// ============================= VERIFY OTP =============================
  @override
  Future<Either<Failure, String>> verifyOtp(String phone, String otp) async {
    try {
      final message = await remoteDataSource.verifyOtp(phone, otp);
      return Either.right(message);
    } catch (e) {
      return Either.left(Failure(e.toString()));
    }
  }

  /// ============================= FORGET PASSWORD =============================
  @override
  Future<Either<Failure, String>> forgetPassword({
    required String phone,
    required String otp,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      final message = await remoteDataSource.forgetPassword(
        phone: phone,
        otp: otp,
        password: password,
        passwordConfirmation: passwordConfirmation,
      );
      return Either.right(message);
    } catch (e) {
      return Either.left(Failure(e.toString()));
    }
  }

  /// ============================= RESET PASSWORD =============================
  @override
  Future<Either<Failure, String>> resetPassword({
    required String phone,
    required String otp,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      final message = await remoteDataSource.resetPassword(
        phone: phone,
        otp: otp,
        password: password,
        passwordConfirmation: passwordConfirmation,
      );
      return Either.right(message);
    } catch (e) {
      return Either.left(Failure(e.toString()));
    }
  }

  /// ============================= UPDATE PASSWORD =============================
  @override
  Future<Either<Failure, String>> updatePassword(String oldPassword, String newPassword , String passwordConfirmation) async {
    try {
      final message = await remoteDataSource.updatePassword(oldPassword, newPassword , passwordConfirmation);
      return Either.right(message);
    } catch (e) {
      return Either.left(Failure(e.toString()));
    }
  }

  /// ============================= LOCAL HELPERS =============================
  // @override
  // Future<String?> getToken() async => await localDataSource.getToken();
  //
  // @override
  // Future<UserModel?> getCachedUser() async => await localDataSource.getCachedUser();
  //
  // @override
  // Future<void> logout() async {
  //   await localDataSource.clearCachedUser();
  // }
}
