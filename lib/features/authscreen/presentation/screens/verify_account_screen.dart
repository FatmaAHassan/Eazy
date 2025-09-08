import 'package:dio/dio.dart';
import 'package:eazy/features/authscreen/data/datasources/auth_remote_datasource.dart';
import 'package:eazy/features/authscreen/data/datasources/auth_local_datasource.dart';
import 'package:eazy/features/authscreen/data/repositories/auth_repository_impl.dart';
import 'package:eazy/features/authscreen/domain/usecases/send_otp_usecase.dart';
import 'package:eazy/features/authscreen/presentation/screens/verify_screen.dart';
import 'package:eazy/features/authscreen/widgets/custom_buttom.dart';
import 'package:eazy/features/authscreen/widgets/custom_icon_bar.dart';
import 'package:eazy/features/authscreen/widgets/custom_text_field.dart';
import 'package:eazy/helper/show_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../cubit/send_otp_cubit.dart';
import '../cubit/send_otp_state.dart';
import '../../../../constants.dart';

class VerifyAccountScreen extends StatefulWidget {
  const VerifyAccountScreen({super.key});
  static const String routeName = 'VerifyAccountScreen';

  @override
  State<VerifyAccountScreen> createState() => _VerifyAccountScreenState();
}

class _VerifyAccountScreenState extends State<VerifyAccountScreen> {
  final GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  String? phone;

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

    final sendOtpUseCase = SendOtpUseCase(authRepository!);

    return BlocProvider(
      create: (_) => SendOtpCubit(sendOtpUseCase),
      child: BlocConsumer<SendOtpCubit, SendOtpState>(
        listener: (context, state) async {
          if (state is SendOtpFailure) {
            showSnackBar(context, state.message,Colors.red);
          } else if (state is SendOtpSuccess) {
            // 🔹 حفظ الهاتف مباشرة في SharedPreferences
            final prefs = await SharedPreferences.getInstance();
            await prefs.setString('phone', phone!);

            showSnackBar(context, 'تم إرسال OTP بنجاح',Colors.red);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => VerifyScreen(phone: phone!),
              ),
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
                  icon: CustomIconBar(),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  autovalidateMode: autoValidateMode,
                  child: Column(
                    children: [
                      const SizedBox(height: 50),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'تاكيد البريد الالكتروني',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Column(
                        children: const [
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'أدخل رقم الهاتف ',
                              style: TextStyle(
                                  color: kSecondaryColor, fontSize: 18),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              ' لتاكيد البريد الالكتروني',
                              style: TextStyle(
                                  color: kSecondaryColor, fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 50),
                      CustomTextField(
                        text: ' أدخل رقم هاتف ',
                        onChanged: (value) => phone = value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'برجاء ادخال رقم الهاتف';
                          }
                          final phoneRegex = RegExp(r'^[0-9]{10,15}$');
                          if (!phoneRegex.hasMatch(value)) {
                            return 'برجاء إدخال رقم هاتف صحيح';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.4),
                      state is SendOtpLoading
                          ? const CircularProgressIndicator()
                          : CustomButton(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            if (phone != null && phone!.isNotEmpty) {
                              context
                                  .read<SendOtpCubit>()
                                  .sendOtp(phone!);
                            }
                          } else {
                            setState(() {
                              autoValidateMode = AutovalidateMode.always;
                            });
                          }
                        },
                        text: 'تأكيد',
                      ),
                      const SizedBox(height: 50),
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
