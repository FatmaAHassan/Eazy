import 'dart:async';
import 'package:eazy/constants.dart';
import 'package:eazy/features/authscreen/reset_password.dart';
import 'package:eazy/features/authscreen/widgets/custom_buttom.dart';
import 'package:eazy/features/authscreen/widgets/custom_icon_bar.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field_v2/otp_field_style_v2.dart';
import 'package:otp_text_field_v2/otp_field_v2.dart';




class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});
  static const String routeName = 'OtpScreen';

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  bool hasError = false;
  String otpValue = '';
  int start = 20;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    start = 30;
    timer?.cancel();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
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
    final emailOrPhone = ModalRoute.of(context)!.settings.arguments as String?;
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
          child: Column(
            children: [
              SizedBox(height: 50),
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
              SizedBox(height: 10),
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
                      ' في رسالة علي رقم/ بريد ${emailOrPhone ?? 'رقم غير معروف'} ',

                      style: TextStyle(color: kSecondaryColor, fontSize: 18),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 50),

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

                  SizedBox(height: 10),
              Visibility(
                visible: hasError,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Icon(
                      Icons.warning_amber_rounded,
                      color: Colors.red,
                      size: 18,
                    ),
                    SizedBox(width: 4),
                    Text(
                      'هذا الحقل مطلوب',
                      style: TextStyle(color: Colors.red, fontSize: 14),
                    ),
                  ],
                ),
              ),
              SizedBox(height: height(context) * 0.35),
              CustomButton(
                onTap: start > 0
                    ? null
                    : () {
                        if (otpValue.isEmpty || otpValue.length < 4) {
                          setState(() {
                            hasError = true;
                          });
                          return;
                        }
                        setState(() {
                          hasError = false;
                        });
                        Navigator.pushNamed(context, ResetPassword.routeName);
                      },
                text: 'تأكيد',
              ),

              SizedBox(height: 20),

              start > 0
                  ? Text(
                      'حاول مرة أخرى بعد 00:${start.toString().padLeft(2, '0')}',
                      style: TextStyle(color: kSecondaryColor, fontSize: 16),
                    )
                  : GestureDetector(
                      onTap: () {
                        startTimer();
                      },
                      child: Text(
                        'إعادة إرسال الرمز',
                        style: TextStyle(color: kPrimaryColor, fontSize: 16),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}