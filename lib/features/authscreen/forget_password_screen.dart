import 'package:eazy/constants.dart';
import 'package:eazy/features/authscreen/widgets/custom_buttom.dart';
import 'package:eazy/features/authscreen/widgets/custom_icon_bar.dart';
import 'package:eazy/features/authscreen/widgets/custom_text_field.dart';
import 'package:eazy/helper/show_snack_bar.dart';
import 'package:flutter/material.dart';
import 'otp_screen.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});
  static const String routeName = 'ForgetPasswordScreen';

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  String? emailOrPhone;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
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
                SizedBox(height: 50),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'نسيت كلمه المرور',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Column(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'أدخل رقم الهاتف/البريد الالكتروني ',
                        style: TextStyle(color: kSecondaryColor, fontSize: 18),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'لاستعادة كلمة المرور',
                        style: TextStyle(color: kSecondaryColor, fontSize: 18),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50),

                CustomTextField(
                  text: ' أدخل رقم هاتف / بريد اليكتروني',
                  onChanged: (value) {
                    emailOrPhone = value;
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
                ),
                SizedBox(height: height(context) * 0.4),
                CustomButton(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      showSnackBar(
                        context,
                        'تم إرسال رابط استعادة كلمة المرور',
                      );
                      if (emailOrPhone != null && emailOrPhone!.isNotEmpty) {
                        Navigator.pushNamed(
                          context,
                          OtpScreen.routeName,
                          arguments: emailOrPhone,
                        );
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
  }
}