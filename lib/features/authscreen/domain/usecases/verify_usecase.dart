import '../../../../core/utils/either.dart';
import '../../../../core/error/failure.dart';
import '../repositories/auth_repository.dart';

class VerifyOtpUseCase {
  final AuthRepository repository;

  VerifyOtpUseCase(this.repository);

  Future<Either<Failure, String>> call({
    required String phone,
    required String otp,
  }) async {
    return await repository.verifyOtp(phone, otp);
  }
}
