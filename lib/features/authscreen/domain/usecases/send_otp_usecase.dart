import '../../domain/repositories/auth_repository.dart';
import '../../../../core/utils/either.dart';
import '../../../../core/error/failure.dart';

class SendOtpUseCase {
  final AuthRepository repository;

  SendOtpUseCase(this.repository);

  Future<Either<Failure, String>> call(String phone) async {
    return await repository.sendOtp(phone);
  }
}
