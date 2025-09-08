import '../repositories/auth_repository.dart';
import '../../../../core/utils/either.dart';
import '../../../../core/error/failure.dart';

class RegisterUseCase {
  final AuthRepository repository;
  RegisterUseCase(this.repository);

  Future<Either<Failure, String>> call(
      String name,
      String email,
      String password,
      String phone,
      ) {
    return repository.register(name, email, password, phone);
  }
}
