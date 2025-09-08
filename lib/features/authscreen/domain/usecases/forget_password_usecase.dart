import '../repositories/auth_repository.dart';
import '../../../../core/utils/either.dart';
import '../../../../core/error/failure.dart';

class ForgetPasswordUseCase {
  final AuthRepository repository;
  ForgetPasswordUseCase(this.repository);

  Future<Either<Failure, String>> call(String phone) {
    return repository.forgetPassword( phone: phone, otp: '', password: '', passwordConfirmation: '', );
  }
}
