import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/verify_usecase.dart';
import 'verify_state.dart';

class VerifyCubit extends Cubit<VerifyState> {
  final VerifyOtpUseCase verifyOtpUseCase;

  VerifyCubit(this.verifyOtpUseCase) : super(VerifyInitial());

  Future<void> verifyOtp({
    required String phone,
    required String otp,
  }) async {
    emit(VerifyLoading());

    final result = await verifyOtpUseCase(phone: phone, otp: otp);

    result.when(
      success: (message) {
        print("🟢 Verify OTP Success: $message");
        emit(VerifySuccess(message));
      },
      failure: (failure) {
        print("❌ Verify OTP Failure: ${failure.toString()}");
        emit(VerifyFailure(failure.toString()));
      },
    );
  }
}
