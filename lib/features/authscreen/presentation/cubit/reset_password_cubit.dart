import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/reset_password_usecase.dart';
import 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final ResetPasswordUseCase resetPasswordUseCase;

  ResetPasswordCubit(this.resetPasswordUseCase) : super(ResetPasswordInitial());

  Future<void> resetPassword({
    required String phone,
    required String otp,
    required String password,
    required String passwordConfirmation,
  }) async {
    emit(ResetPasswordLoading());

    final result = await resetPasswordUseCase.call(phone, otp, password,passwordConfirmation);

    result.fold(
          (failure) {
        print("❌ Reset Password Error: ${failure.message}");
        emit(ResetPasswordFailure(failure.message));
      },
          (message) {
        print("🟢 Reset Password Success: $message");
        emit(ResetPasswordSuccess(message));
      },
    );

  }
}
