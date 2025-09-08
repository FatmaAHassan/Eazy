
import 'package:eazy/features/authscreen/widgets/custom_buttom.dart';
import 'package:eazy/features/authscreen/widgets/custom_icon_bar.dart';
import 'package:eazy/features/authscreen/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';
import 'forget_password_screen.dart';


class UpdatePasswordScreen extends StatefulWidget {
  const UpdatePasswordScreen({super.key});
  static const String routeName = 'UpdatePasswordScreen';

  @override
  State<UpdatePasswordScreen> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<UpdatePasswordScreen> {
  GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  String? oldPassword;
  String? newPassword;
  String? confirmNewPassword;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text('تغيير كلمه المرور',style: TextStyle(
          color: Colors.black,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),),
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
                SizedBox(height: 80),

                CustomTextField(
                  isPassword: true,
                  onChanged: (value) {
                    oldPassword = value;
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
                  text: 'كلمه المرور القديمه',
                  iconData: Icons.visibility,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  isPassword: true,
                  onChanged: (value) {
                    newPassword = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'برجاء ادخال كلمه المرور الجديده';
                    } else {
                      return null;
                    }
                  },
                  text: 'كلمه المرور الجديده',
                  iconData: Icons.visibility,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  isPassword: true,
                  onChanged: (value) {
                    confirmNewPassword = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'برجاء إعادة إدخال كلمة المرور';
                    } else if (value != newPassword) {
                      return 'كلمتا المرور غير متطابقتين';
                    } else {
                      return null;
                    }
                  },
                  text: 'أعاده ادخال كلمه المرور الجديده',
                  iconData: Icons.visibility,
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, ForgetPasswordScreen.routeName);
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
                ),
                SizedBox(height: height(context) * 0.40),
                CustomButton(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                    } else {
                      setState(() {
                        autoValidateMode = AutovalidateMode.always;
                      });
                    }
                  },

                  text: 'حفظ التعديلات'
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}