import 'package:flutter_bloc/flutter_bloc.dart';
import 'send_otp_state.dart';
import '../../domain/usecases/send_otp_usecase.dart';

class SendOtpCubit extends Cubit<SendOtpState> {
  final SendOtpUseCase sendOtpUseCase;

  SendOtpCubit(this.sendOtpUseCase) : super(SendOtpInitial());

  Future<void> sendOtp(String phone) async {
    emit(SendOtpLoading());

    final result = await sendOtpUseCase.call(phone);

    result.when(
      failure: (failure) {
        print("❌ Send OTP Error: ${failure.toString()}");
        emit(SendOtpFailure(failure.toString()));
      },
      success: (message) {
        print("🟢 Send OTP Success: $message");
        emit(SendOtpSuccess(message));
      },
    );
  }
}
