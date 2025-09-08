import 'package:dio/dio.dart';
import 'package:eazy/features/authscreen/data/datasources/auth_remote_datasource.dart';
import 'package:eazy/features/authscreen/data/datasources/auth_local_datasource.dart';
import 'package:eazy/features/authscreen/data/repositories/auth_repository_impl.dart';
import 'package:eazy/features/authscreen/domain/usecases/register_usecase.dart';
import 'package:eazy/features/authscreen/presentation/cubit/register_cubit.dart';
import 'package:eazy/features/authscreen/presentation/cubit/register_state.dart';
import 'package:eazy/features/authscreen/presentation/screens/login_screen.dart';
import 'package:eazy/features/authscreen/presentation/screens/verify_account_screen.dart';
import 'package:eazy/features/authscreen/widgets/custom_buttom.dart';
import 'package:eazy/features/authscreen/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../constants.dart';
import '../../../../helper/show_snack_bar.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static const String routeName = 'RegisterScreen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  String? email;
  String? password;
  String? confirmPassword;
  String? name;
  String? phone;
  bool isCheck = false;

  AuthRepositoryImpl? authRepository;

  @override
  void initState() {
    super.initState();
    _initRepository();
  }

  Future<void> _initRepository() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      authRepository = AuthRepositoryImpl(
        remoteDataSource: AuthRemoteDataSourceImpl(Dio()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    if (authRepository == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return BlocProvider(
      create: (_) => RegisterCubit(
        RegisterUseCase(authRepository!),
      ),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterFailure) {
            showSnackBar(context, state.message,Colors.red);
          }
          if (state is RegisterSuccess) {
            showSnackBar(context, 'تم التسجيل بنجاح',Colors.green);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const VerifyAccountScreen()),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/splash.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      autovalidateMode: autoValidateMode,
                      child: Column(
                        children: [
                          const SizedBox(height: 30),
                          Image.asset(
                            'assets/images/image_logo.png',
                            width: width(context),
                            height: height(context) * 0.3,
                          ),
                          const SizedBox(height: 50),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              Text(
                                'تسجيل حساب جديد',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          CustomTextField(
                            onChanged: (value) => name = value,
                            validator: (value) =>
                            value!.isEmpty ? 'برجاء إدخال اسم المستخدم' : null,
                            text: 'اسم المستخدم',
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            onChanged: (value) => email = value,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'برجاء إدخال البريد الإلكتروني';
                              }
                              final emailRegex = RegExp(
                                r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                              );
                              if (!emailRegex.hasMatch(value)) {
                                return 'برجاء إدخال بريد إلكتروني صحيح';
                              }
                              return null;
                            },
                            text: 'البريد الإلكتروني',
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            onChanged: (value) => phone = value,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'برجاء إدخال رقم الهاتف';
                              }
                              final phoneRegex = RegExp(r'^[0-9]{10,15}$');
                              if (!phoneRegex.hasMatch(value)) {
                                return 'برجاء إدخال رقم هاتف صحيح';
                              }
                              return null;
                            },
                            text: 'رقم الهاتف',
                          ),
                          const SizedBox(height: 10),
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
                            text: 'كلمة المرور',
                            iconData: Icons.visibility,
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            isPassword: true,
                            onChanged: (value) => confirmPassword = value,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'برجاء إعادة إدخال كلمة المرور';
                              } else if (value != password) {
                                return 'كلمتا المرور غير متطابقتين';
                              }
                              return null;
                            },
                            text: 'إعادة إدخال كلمة المرور',
                            iconData: Icons.visibility,
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Checkbox(
                                fillColor: MaterialStateProperty.all(Colors.white),
                                activeColor: kPrimaryColor,
                                checkColor: kPrimaryColor,
                                value: isCheck,
                                onChanged: (value) {
                                  setState(() {
                                    isCheck = value!;
                                  });
                                },
                              ),
                              const Text(
                                'أوافق على',
                                style: TextStyle(
                                  color: kSecondaryColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                'الشروط والأحكام للاستمرار',
                                style: TextStyle(
                                  color: kPrimaryColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                  decorationColor: kPrimaryColor,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          state is RegisterLoading
                              ? const CircularProgressIndicator()
                              : CustomButton(
                            onTap: () => validateAndSubmit(context),
                            text: 'إنشاء حساب',
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(width: 5),
                              const Text(
                                'ليس لديك حساب بالفعل؟',
                                style: TextStyle(
                                  color: kSecondaryColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const LoginScreen(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'تسجيل الدخول',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void validateAndSubmit(BuildContext context) {
    if (!isCheck) {
      showSnackBar(context, 'يجب الموافقة على الشروط والأحكام للاستمرار',Colors.red);
      return;
    }

    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      context.read<RegisterCubit>().register(
        name: name!,
        email: email!,
        password: password!,
        confirmPassword: confirmPassword!,
        phone: phone!,
      );
    } else {
      setState(() {
        autoValidateMode = AutovalidateMode.always;
      });
    }
  }
}
