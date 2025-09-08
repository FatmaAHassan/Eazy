import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/either.dart';
import '../../../../core/error/failure.dart';
import '../../domain/usecases/update_password_usecase.dart';
import 'update_password_state.dart';

class UpdatePasswordCubit extends Cubit<UpdatePasswordState> {
  final UpdatePasswordUseCase updatePasswordUseCase;

  UpdatePasswordCubit(this.updatePasswordUseCase) : super(UpdatePasswordInitial());

  Future<void> updatePassword(String oldPassword, String newPassword, String passwordConfirmation) async {
    emit(UpdatePasswordLoading());

    final result = await updatePasswordUseCase.call(oldPassword, newPassword, passwordConfirmation);

    result.fold(
          (failure) => emit(UpdatePasswordFailure(failure.message)),
          (message) => emit(UpdatePasswordSuccess(message)),
    );
  }
}
