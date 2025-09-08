import '../repositories/auth_repository.dart';
import '../../../../core/utils/either.dart';
import '../../../../core/error/failure.dart';
import '../entities/user.dart';

class LoginUseCase {
  final AuthRepository repository;
  LoginUseCase(this.repository);

  Future<Either<Failure, User>> call({
    required String email_phone,
    required String password,
  }) {
    return repository.login(email_phone, password);
  }
}
