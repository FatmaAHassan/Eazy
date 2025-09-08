import 'package:eazy/constants.dart';
import 'package:eazy/features/authscreen/widgets/custom_buttom.dart';
import 'package:eazy/features/authscreen/widgets/custom_icon_bar.dart';
import 'package:eazy/features/authscreen/widgets/custom_text_field.dart';
import 'package:eazy/helper/show_dialog.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});
  static const String routeName = 'ResetPassword';

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  String? password;
  String? confirmPassword;
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            autovalidateMode: autoValidateMode,
            child: Column(
              children: [
                SizedBox(height: 50),
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
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'كلمه المرور',
                    style: TextStyle(color: kSecondaryColor, fontSize: 16),
                  ),
                ),
                const SizedBox(height: 50),
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
                  text: 'كلمه المرور الجديده',
                  iconData: Icons.visibility,
                ),
                const SizedBox(height: 10),
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
                  text: 'أعاده ادخال كلمه المرور الجديده',
                  iconData: Icons.visibility,
                ),
                SizedBox(height: height(context) * 0.35),
                CustomButton(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      showSuccessDialog(
                        context,
                        'تم حفظ التغيرات بنجاح',
                        'انتقل الي الصفحه الرئيسيه',
                        () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        },
                      );
                      // Navigator.pushNamed(context, LoginScreen.routeName);
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
  }
}
