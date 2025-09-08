import 'dart:async';
import 'package:flutter/material.dart';
import 'package:eazy/constants.dart';
import 'package:eazy/features/authscreen/presentation/screens/reset_password.dart';
import 'package:eazy/features/authscreen/widgets/custom_buttom.dart';
import 'package:eazy/features/authscreen/widgets/custom_icon_bar.dart';
import 'package:otp_text_field_v2/otp_field_style_v2.dart';
import 'package:otp_text_field_v2/otp_field_v2.dart';

class OtpScreen extends StatefulWidget {
  final String phone;

  const OtpScreen({super.key, required this.phone});
  static const String routeName = 'OtpScreen';

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  bool hasError = false;
  String otpValue = '';
  int start = 18;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startTimer();
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const CustomIconBar(),
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
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'من فضلك أدخل رمز التحقق الذي أرسل لك على رقم الهاتف: ${widget.phone}',
                  style: TextStyle(color: kSecondaryColor, fontSize: 18),
                ),
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
              CustomButton(
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

                  // الانتقال مباشرةً للـ ResetPasswordScreen مع تمرير OTP
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ResetPasswordScreen(
                        phone: widget.phone,
                        otp: otpValue,
                      ),
                    ),
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
                  : Text(
                'يمكنك إعادة إرسال الرمز الآن',
                style: TextStyle(color: kPrimaryColor, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
