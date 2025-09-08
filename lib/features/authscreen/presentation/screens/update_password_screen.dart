import 'package:eazy/core/routing/routes.dart';
import 'package:eazy/features/authscreen/widgets/custom_buttom.dart';
import 'package:eazy/features/authscreen/widgets/custom_icon_bar.dart';
import 'package:eazy/features/authscreen/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../constants.dart';
import 'forget_password_screen.dart';
import '../cubit/update_password_cubit.dart';
import '../cubit/update_password_state.dart';

class UpdatePasswordScreen extends StatefulWidget {
  const UpdatePasswordScreen({super.key});
  static const String routeName = 'UpdatePasswordScreen';

  @override
  State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  final GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  String? oldPassword;
  String? newPassword;
  String? passwordConfirmation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'تغيير كلمة المرور',
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
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
      body: BlocConsumer<UpdatePasswordCubit, UpdatePasswordState>(
        listener: (context, state) {
          if (state is UpdatePasswordSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
            // بعد النجاح، ننتقل لشاشة تسجيل الدخول
            Navigator.pushReplacementNamed(context, Routes.LoginScreen); // ضع route الخاص بالـ Login هنا
          } else if (state is UpdatePasswordFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formKey,
                autovalidateMode: autoValidateMode,
                child: Column(
                  children: [
                    const SizedBox(height: 80),
                    CustomTextField(
                      isPassword: true,
                      onChanged: (value) => oldPassword = value,
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
                      text: 'كلمة المرور القديمة',
                      iconData: Icons.visibility,
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      isPassword: true,
                      onChanged: (value) => newPassword = value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'برجاء إدخال كلمة المرور الجديدة';
                        }
                        return null;
                      },
                      text: 'كلمة المرور الجديدة',
                      iconData: Icons.visibility,
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      isPassword: true,
                      onChanged: (value) => passwordConfirmation = value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'برجاء إعادة إدخال كلمة المرور';
                        } else if (value != newPassword) {
                          return 'كلمتا المرور غير متطابقتين';
                        }
                        return null;
                      },
                      text: 'أعد إدخال كلمة المرور الجديدة',
                      iconData: Icons.visibility,
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
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
                    state is UpdatePasswordLoading
                        ? const CircularProgressIndicator()
                        : CustomButton(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          context.read<UpdatePasswordCubit>().updatePassword(
                            oldPassword!,
                            newPassword!,
                            passwordConfirmation!,
                          );
                        } else {
                          setState(() {
                            autoValidateMode = AutovalidateMode.always;
                          });
                        }
                      },
                      text: 'حفظ التعديلات',
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
