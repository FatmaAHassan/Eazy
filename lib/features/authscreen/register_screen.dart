import 'package:eazy/features/authscreen/widgets/custom_buttom.dart';
import 'package:eazy/features/authscreen/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../helper/show_snack_bar.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static const String routeName = 'RegisterScreen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  String? email;
  String? password;
  int? phone;
  String? confirmPassword;
  String? userName;
  bool isCheck = false;
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
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                autovalidateMode: autoValidateMode,
                child: Column(
                  children: [
                    SizedBox(height: 30),
                    Image.asset(
                      'assets/images/image_logo.png',
                      width: width(context),
                      height: height(context) * 0.3,
                    ),
                    SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
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
                    SizedBox(height: 15),
                    CustomTextField(
                      onChanged: (value) {
                        userName = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'برجاء إدخال اسم المستخدم';
                        } else {
                          return null;
                        }
                      },
                      text: 'اسم المستخدم',
                    ),
                    SizedBox(height: 10),
                    CustomTextField(
                      onChanged: (value) {
                        email = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'برجاء إدخال البريد الإلكتروني أو رقم الهاتف';
                        }
                        final emailRegex = RegExp(
                          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                        );
                        final phoneRegex = RegExp(r'^[0-9]{10,15}$');

                        if (!emailRegex.hasMatch(value) &&
                            !phoneRegex.hasMatch(value)) {
                          return 'برجاء إدخال بريد إلكتروني أو رقم هاتف صحيح';
                        }
                        return null;
                      },
                      text: 'رقم الهاتف / البريد الاليكتروني',
                    ),
                    SizedBox(height: 10),
                    CustomTextField(
                      isPassword: true,
                      onChanged: (value) {
                        password = value;
                      },
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
                      text: 'كلمه المرور',
                      iconData: Icons.visibility,
                    ),
                    SizedBox(height: 10),
                    CustomTextField(
                      isPassword: true,
                      onChanged: (value) {
                        confirmPassword = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'برجاء إعادة إدخال كلمة المرور';
                        } else if (value != password) {
                          return 'كلمتا المرور غير متطابقتين';
                        } else {
                          return null;
                        }
                      },
                      text: 'اعاده ادخال كلمه المرور',
                      iconData: Icons.visibility,
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'الشروط والاحكام للاستمرار',
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            decorationColor: kPrimaryColor,
                          ),
                        ),
                        Text(
                          'أوافق علي',
                          style: TextStyle(
                            color: kSecondaryColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

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
                      ],
                    ),
                    SizedBox(height: 30),
                    CustomButton(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      },
                      text: 'إنشاء حساب',
                    ),

                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ),
                            );
                          },
                          child: Text(
                            'تسجيل الدخول',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        SizedBox(width: 5),
                        Text(
                          'ليس لديك حساب بالفعل؟',
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

  void validateAndSubmit() {
    if (!isCheck) {
      showSnackBar(context, 'يجب الموافقة على الشروط والأحكام للاستمرار');
      return;
    }

    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
    } else {
      setState(() {
        autoValidateMode = AutovalidateMode.always;
      });
    }
  }
}