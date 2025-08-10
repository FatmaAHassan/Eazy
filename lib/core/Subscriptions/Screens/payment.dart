import 'package:easy_app/core/Subscriptions/Screens/Subscriptions.dart';
import 'package:flutter/material.dart';
import '../../config/app_padding.dart';
import '../../config/app_palette.dart';
import '../../config/images_manager.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  static const double fieldSpacing = 16.0;
  static const double maxCardWidth = 470;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppPalette.backgroundLight,
        appBar: AppBar(
          backgroundColor: AppPalette.backgroundLight,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            "بوابة الدفع",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppPalette.textBlack,
            ),
          ),
        ),

        body: SingleChildScrollView(
          padding: const EdgeInsets.all(AppPadding.containerPaddingAll),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: maxCardWidth),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // صورة Eazy
                  Image.asset(
                    ImagesManager.eazy,
                    height: 150,
                  ),
                  const SizedBox(height: 8),

                 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Secure payment",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppPalette.textBlack,
                        ),
                      ),

                      const SizedBox(width: 6),
                      Image.asset(
                        ImagesManager.padlock,
                        width: 20,
                        height: 20,
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),


                  _buildInputField(
                      label: "رقم البطاقة", hint: "**** **** **** 1234"),
                  const SizedBox(height: fieldSpacing),


                  Row(
                    children: [
                      Expanded(
                        child: _buildInputField(
                            label: "تاريخ الانتهاء", hint: "MM/YY"),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildInputField(
                            label: "رمز الأمان",
                            hint: "CVV",
                            obscureText: true),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // اسم حامل البطاقة
                  _buildInputField(
                      label: "اسم حامل البطاقة", hint: "كما هو على البطاقة"),
                  const SizedBox(height: fieldSpacing),

                  const SizedBox(height: 10),

                  // جملة تكلفة الاشتراك قبل الصندوق
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "تكلفة الاشتراك",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // صندوق ملخص الدفع
                  _buildPaymentSummary(),

                  const SizedBox(height: 35),

                  // زر الدفع
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppPalette.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {

                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const SizedBox(height: 8),
                                    const Text(
                                      "تم الدفع بنجاح",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 24),
                                    SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AppPalette.primary,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                              builder: (context) => const UpgradeNowScreen(),),
                                          );
                                        },
                                        child: const Text(
                                          "تم",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: AppPalette.textLight,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );


                      },
                      child: const Text(
                        "اذهب للدفع",
                        style: TextStyle(
                            fontSize: 18, color: AppPalette.textLight),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  static Widget _buildInputField(
      {required String label, required String hint, bool obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppPalette.textBlackLight,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: AppPalette.textSubtitleLight),
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
              const BorderSide(color: AppPalette.textFiledEnabledBorder),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppPalette.primary),
            ),
          ),
        ),
      ],
    );
  }

  // صندوق ملخص الدفع
  static Widget _buildPaymentSummary() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppPalette.textFiledFocusedBorder,
        borderRadius: BorderRadius.circular(12),

      ),
      child: Column(
        children: [
          _buildSummaryRow("تكلفة الاشتراك", "70 ج.م"),
          const SizedBox(height: 6),
          _buildSummaryRow("الضريبة", "10 ج.م"),
          const Divider(color: AppPalette.borderColor),
          _buildSummaryRow("المجموع", "80 ج.م", isBold: true),
        ],
      ),
    );
  }

  // صف ملخص الدفع
  static Widget _buildSummaryRow(String title, String value,
      {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            fontSize: 16,
            color: AppPalette.textBlack,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            fontSize: 16,
            color: AppPalette.textBlack,
          ),
        ),
      ],
    );
  }
}
