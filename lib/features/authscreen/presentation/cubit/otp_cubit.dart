import 'package:eazy/features/authscreen/domain/usecases/otp_usecase.dart';
import 'package:eazy/features/authscreen/presentation/cubit/otp_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/otp_usecase.dart';
import '../../domain/usecases/verify_usecase.dart';
import 'verify_state.dart';

class OtpCubit extends Cubit<OtpState> {
  final  OtpUseCase;

  OtpCubit(this.OtpUseCase) : super(OtpInitial());

  Future<void> verifyOtp({
    required String phone,
    required String otp,
  }) async {
    emit(OtpLoading());

    final result = await OtpUseCase(phone: phone, otp: otp);

    result.when(
      success: (message) {
        print("🟢 Verify OTP Success: $message");
        emit(OtpSuccess(message));
      },
      failure: (failure) {
        print("❌ Verify OTP Failure: ${failure.message}");
        emit(OtpFailure(failure.message));
      },
    );

  }
}
