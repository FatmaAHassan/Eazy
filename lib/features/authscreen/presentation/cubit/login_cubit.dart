import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/usecases/login_usecase.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;

  LoginCubit(this.loginUseCase) : super(LoginInitial());

  Future<void> login(String email_phone, String password) async {
    emit(LoginLoading());

    final result = await loginUseCase(
      email_phone: email_phone,
      password: password,
    );

    result.when(
      success: (user) async {
        // 🟢 تخزين التوكن في SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("access_token", user.token);

        print("✅ تم حفظ التوكن: ${user.token}");

        emit(LoginSuccess(user));
      },
      failure: (failure) {
        emit(LoginFailure(failure));
      },
    );
  }
}
