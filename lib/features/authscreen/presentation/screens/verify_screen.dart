import 'dart:async';
import 'package:dio/dio.dart';
import 'package:eazy/constants.dart';
import 'package:eazy/features/authscreen/data/datasources/auth_local_datasource.dart';
import 'package:eazy/features/authscreen/data/datasources/auth_remote_datasource.dart';
import 'package:eazy/features/authscreen/data/models/user_model.dart';
import 'package:eazy/features/authscreen/data/repositories/auth_repository_impl.dart';
import 'package:eazy/features/authscreen/domain/usecases/verify_usecase.dart';
import 'package:eazy/features/authscreen/domain/usecases/send_otp_usecase.dart';
import 'package:eazy/features/authscreen/presentation/cubit/send_otp_cubit.dart';
import 'package:eazy/features/authscreen/presentation/cubit/send_otp_state.dart';
import 'package:eazy/features/authscreen/presentation/cubit/verify_cubit.dart';
import 'package:eazy/features/authscreen/presentation/cubit/verify_state.dart';
import 'package:eazy/features/authscreen/presentation/screens/login_screen.dart';
import 'package:eazy/features/authscreen/widgets/custom_buttom.dart';
import 'package:eazy/features/authscreen/widgets/custom_icon_bar.dart';
import 'package:eazy/helper/show_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otp_text_field_v2/otp_field_style_v2.dart';
import 'package:otp_text_field_v2/otp_field_v2.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VerifyScreen extends StatefulWidget {
  final String phone;

  const VerifyScreen({super.key, required this.phone});
  static const String routeName = 'VerifyScreen';

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  bool hasError = false;
  String otpValue = '';
  int start = 18;
  Timer? timer;

  AuthRepositoryImpl? repository;
  VerifyOtpUseCase? verifyUseCase;
  SendOtpUseCase? sendOtpUseCase;

  @override
  void initState() {
    super.initState();
    setupRepository();
    startTimer();
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
      verifyUseCase = VerifyOtpUseCase(repo);
      sendOtpUseCase = SendOtpUseCase(repo);
    });
  }

  void startTimer() {
    start = 18;
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (start == 0) {
        timer.cancel();
      } else {
        setState(() {
          start--;
        });
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (repository == null || verifyUseCase == null || sendOtpUseCase == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => VerifyCubit(verifyUseCase!)),
        BlocProvider(create: (_) => SendOtpCubit(sendOtpUseCase!)),
      ],
      child: BlocConsumer<VerifyCubit, VerifyState>(
        listener: (context, state) async {
          if (state is VerifyFailure) {
            showSnackBar(context, state.message,Colors.red);
          } else if (state is VerifySuccess) {
            // حفظ الهاتف أو التوكن بعد التحقق
            final prefs = await SharedPreferences.getInstance();
            await prefs.setString('phone', widget.phone);
            // لو API بيرجع توكن بعد التحقق:
            // await prefs.setString('access_token', state.token);

            showSnackBar(context, "تم التحقق بنجاح",Colors.red);
            Navigator.pushReplacementNamed(context, LoginScreen.routeName);
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
                  icon: CustomIconBar(),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'كود التحقق',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'من فضلك أدخل رمز التحقق الذي أرسل لك',
                            style: TextStyle(color: kSecondaryColor, fontSize: 18),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'على رقم الهاتف: ${widget.phone}',
                            style: TextStyle(color: kSecondaryColor, fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),
                    OTPTextFieldV2(
                      length: 4,
                      width: MediaQuery.of(context).size.width,
                      fieldWidth: 50,
                      style: const TextStyle(fontSize: 20),
                      textFieldAlignment: MainAxisAlignment.spaceEvenly,
                      fieldStyle: FieldStyle.box,
                      otpFieldStyle: OtpFieldStyle(
                        borderColor: hasError ? Colors.red : kPrimaryColor,
                        focusBorderColor: hasError ? Colors.red : kPrimaryColor,
                        backgroundColor: Colors.white,
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          otpValue = value;
                          hasError = false;
                        });
                      },
                      onCompleted: (value) {
                        setState(() {
                          otpValue = value;
                          hasError = false;
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    Visibility(
                      visible: hasError,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Icon(Icons.warning_amber_rounded, color: Colors.red, size: 18),
                          SizedBox(width: 4),
                          Text('هذا الحقل مطلوب', style: TextStyle(color: Colors.red, fontSize: 14)),
                        ],
                      ),
                    ),
                    SizedBox(height: height(context) * 0.35),
                    state is VerifyLoading
                        ? const CircularProgressIndicator()
                        : CustomButton(
                      onTap: () {
                        if (otpValue.isEmpty || otpValue.length < 4) {
                          setState(() {
                            hasError = true;
                          });
                          return;
                        }
                        setState(() {
                          hasError = false;
                        });

                        context.read<VerifyCubit>().verifyOtp(
                          phone: widget.phone,
                          otp: otpValue,
                        );
                      },
                      text: 'تأكيد',
                    ),
                    const SizedBox(height: 20),
                    start > 0
                        ? Text(
                      'حاول مرة أخرى بعد 00:${start.toString().padLeft(2, '0')}',
                      style: TextStyle(color: kSecondaryColor, fontSize: 16),
                    )
                        : BlocConsumer<SendOtpCubit, SendOtpState>(
                      listener: (context, state) {
                        if (state is SendOtpFailure) {
                          showSnackBar(context, state.message,Colors.red);
                        } else if (state is SendOtpSuccess) {
                          showSnackBar(context, 'تم إرسال OTP بنجاح',Colors.red);
                          startTimer();
                        }
                      },
                      builder: (context, state) {
                        return GestureDetector(
                          onTap: () {
                            context.read<SendOtpCubit>().sendOtp(widget.phone);
                          },
                          child: Text(
                            'إعادة إرسال الرمز',
                            style: TextStyle(color: kPrimaryColor, fontSize: 16),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
