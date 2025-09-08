import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/register_usecase.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUseCase registerUseCase;

  // ✅ نخزن البيانات هنا بعد التسجيل
  String? savedEmail;
  String? savedPhone;
  String? savedPassword;

  RegisterCubit(this.registerUseCase) : super(RegisterInitial());

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String phone,
  }) async {
    if (password != confirmPassword) {
      print("❌ Passwords do not match!");
      emit(RegisterFailure("كلمة المرور غير متطابقة"));
      return;
    }

    emit(RegisterLoading());

    print("🔵 Register Request:");
    print("Name: $name");
    print("Email: $email");
    print("Password: $password");
    print("Phone: $phone");

    final result = await registerUseCase.call(name, email, password, phone);

    result.when(
      failure: (failure) {
        print("❌ Register Error: ${failure.toString()}");
        emit(RegisterFailure(failure.toString()));
      },
      success: (message) {
        print("🟢 Register Response: $message");

        // ✅ نخزن البيانات بعد التسجيل الناجح
        savedEmail = email;
        savedPhone = phone;
        savedPassword = password;

        emit(RegisterSuccess());
      },
    );
  }
}
