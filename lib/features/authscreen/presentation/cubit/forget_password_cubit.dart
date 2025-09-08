import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/either.dart';
import '../../../../core/error/failure.dart';
import '../../domain/usecases/forget_password_usecase.dart';
import 'forget_password_state.dart';



/// ============================= CUBIT =============================
class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final ForgetPasswordUseCase forgetPasswordUseCase;

  ForgetPasswordCubit(this.forgetPasswordUseCase) : super(ForgetPasswordInitial());

  Future<void> sendForgetPassword(String phone) async {
    emit(ForgetPasswordLoading());

    final Either<Failure, String> result = await forgetPasswordUseCase.call(phone);

    result.fold(
          (failure) => emit(ForgetPasswordError(failure.message)),
          (message) => emit(ForgetPasswordSuccess(message)),
    );
  }
}
