import '../repositories/auth_repository.dart';
import '../../../../core/utils/either.dart';
import '../../../../core/error/failure.dart';

class UpdatePasswordUseCase {
  final AuthRepository repository;
  UpdatePasswordUseCase(this.repository);

  Future<Either<Failure, String>> call(String oldPassword, String newPassword , String passwordConfirmation) {
    return repository.updatePassword(oldPassword, newPassword , passwordConfirmation);
  }
}
