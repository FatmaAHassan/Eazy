import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eazy/constants.dart';
import 'package:eazy/features/authscreen/widgets/custom_buttom.dart';
import 'package:eazy/features/authscreen/widgets/custom_icon_bar.dart';
import 'package:eazy/features/authscreen/widgets/custom_text_field.dart';
import 'package:eazy/helper/show_dialog.dart';
import 'login_screen.dart';
import '../cubit/reset_password_cubit.dart';
import '../cubit/reset_password_state.dart';
import '../../domain/usecases/reset_password_usecase.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/datasources/auth_remote_datasource.dart';
import '../../data/datasources/auth_local_datasource.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String phone;
  final String otp;

  const ResetPasswordScreen({super.key, required this.phone, required this.otp});
  static const String routeName = 'ResetPasswordScreen';

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  String? password;
  String? passwordConfirmation;

  AuthRepositoryImpl? repository;
  ResetPasswordUseCase? resetPasswordUseCase;

  @override
  void initState() {
    super.initState();
    setupRepository();
  }

  Future<void> setupRepository() async {
    final dio = Dio();
    final prefs = await SharedPreferences.getInstance();
    final remoteDataSource = AuthRemoteDataSourceImpl(dio);

    final repo = AuthRepositoryImpl(
      remoteDataSource: remoteDataSource,
    );

    setState(() {
      repository = repo;
      resetPasswordUseCase = ResetPasswordUseCase(repo);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (repository == null || resetPasswordUseCase == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return BlocProvider(
      create: (_) => ResetPasswordCubit(resetPasswordUseCase!),
      child: BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
        listener: (context, state) {
          if (state is ResetPasswordFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          } else if (state is ResetPasswordSuccess) {
            showSuccessDialog(
              context,
              state.message,
              'انتقل الي الصفحه الرئيسيه',
                  () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                );
              },
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              elevation: 0,
              actions: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const CustomIconBar(),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: formKey,
                  autovalidateMode: autoValidateMode,
                  child: Column(
                    children: [
                      const SizedBox(height: 50),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'أعاده تعين كلمه المرور',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'من فضلك أدخل كلمة المرور الجديدة وقم بتأكيد',
                          style: TextStyle(color: kSecondaryColor, fontSize: 16),
                        ),
                      ),
                      const SizedBox(height: 50),
                      CustomTextField(
                        isPassword: true,
                        onChanged: (value) => password = value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'برجاء إدخال كلمة المرور';
                          } else if (value.length < 6) {
                            return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
                          } else if (!RegExp(
                            r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$',
                          ).hasMatch(value)) {
                            return 'كلمة المرور يجب أن تحتوي على حروف وأرقام';
                          }
                          return null;
                        },
                        text: 'كلمه المرور الجديده',
                        iconData: Icons.visibility,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        isPassword: true,
                        onChanged: (value) => passwordConfirmation = value,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'برجاء إعادة إدخال كلمة المرور';
                          } else if (value != password) {
                            return 'كلمتا المرور غير متطابقتين';
                          }
                          return null;
                        },
                        text: 'أعاده ادخال كلمه المرور الجديده',
                        iconData: Icons.visibility,
                      ),
                      SizedBox(height: height(context) * 0.35),
                      state is ResetPasswordLoading
                          ? const CircularProgressIndicator()
                          : CustomButton(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            context.read<ResetPasswordCubit>().resetPassword(
                              phone: widget.phone,
                              otp: widget.otp,
                              password: password!,
                              passwordConfirmation: passwordConfirmation!
                            );
                          } else {
                            setState(() {
                              autoValidateMode = AutovalidateMode.always;
                            });
                          }
                        },
                        text: 'تحديث كلمه المرور',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
