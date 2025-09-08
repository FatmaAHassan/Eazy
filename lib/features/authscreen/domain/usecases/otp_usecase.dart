import '../../../../core/utils/either.dart';
import '../../../../core/error/failure.dart';
import '../repositories/auth_repository.dart';

class OtpUseCase {
  final AuthRepository repository;

  OtpUseCase(this.repository);

  Future<Either<Failure, String>> call({
    required String phone,
    required String otp,
  }) async {
    return await repository.verifyOtp(phone, otp);
  }
}
