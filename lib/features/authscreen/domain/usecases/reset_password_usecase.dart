import '../repositories/auth_repository.dart';
import '../../../../core/utils/either.dart';
import '../../../../core/error/failure.dart';

class ResetPasswordUseCase {
  final AuthRepository repository;
  ResetPasswordUseCase(this.repository);

  Future<Either<Failure, String>> call(String phone, String otp, String password, String passwordConfirmation) {
    return repository.resetPassword( phone: phone, otp: otp, password: password, passwordConfirmation: passwordConfirmation);
  }
}
