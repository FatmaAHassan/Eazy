import 'package:eazy/core/routing/routes.dart';
import 'package:eazy/features/authscreen/widgets/custom_buttom.dart';
import 'package:eazy/features/authscreen/widgets/custom_text_field.dart';
import 'package:eazy/features/home/presentation/Screens/home.dart';
import 'package:eazy/nav_bar.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../helper/show_dialog.dart';
import 'forget_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String routeName = 'LoginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  String? email;
  String? password;

  final RegExp emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
  final RegExp phoneRegex = RegExp(r'^[0-9]{10,15}$');
  final RegExp passwordRegex = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/splash.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: formKey,
              autovalidateMode: autoValidateMode,
              child: SingleChildScrollView(
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
                          'تسجيل الدخول',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),

                    // البريد أو الهاتف
                    CustomTextField(
                      onChanged: (value) => email = value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'برجاء إدخال البريد الإلكتروني أو رقم الهاتف';
                        }
                        if (!emailRegex.hasMatch(value) &&
                            !phoneRegex.hasMatch(value)) {
                          return 'برجاء إدخال بريد إلكتروني أو رقم هاتف صحيح';
                        }
                        return null;
                      },
                      text: 'رقم الهاتف / البريد الإلكتروني',
                    ),
                    const SizedBox(height: 14),

                    // كلمة المرور
                    CustomTextField(
                      isPassword: true,
                      onChanged: (value) => password = value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'برجاء إدخال كلمة المرور';
                        } else if (value.length < 6) {
                          return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
                        } else if (!passwordRegex.hasMatch(value)) {
                          return 'كلمة المرور يجب أن تحتوي على حروف وأرقام';
                        }
                        return null;
                      },
                      text: 'كلمة المرور',
                      iconData: Icons.visibility,
                    ),
                    const SizedBox(height: 14),

                    // نسيت كلمة المرور
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              ForgetPasswordScreen.routeName,
                            );
                          },
                          child: Text(
                            'نسيت كلمة المرور؟',
                            style: TextStyle(
                              color: kSecondaryColor,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 100),

                    // زر تسجيل الدخول
                    CustomButton(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          showSuccessDialog(
                            context,
                            'تم حفظ التعديلات بنجاح',
                            'تم',
                            () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const CustomNavBar(),
                                ),
                              );
                            },
                          );
                        } else {
                          setState(() {
                            autoValidateMode = AutovalidateMode.always;
                          });
                        }
                      },
                      text: 'تسجيل الدخول',
                    ),
                    const SizedBox(height: 10),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, Routes.RegisterScreen);
                          },
                          child: const Text(
                            'سجل الآن',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        const Text(
                          'ليس لديك حساب؟',
                          style: TextStyle(
                            color: kSecondaryColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
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
  }
}
