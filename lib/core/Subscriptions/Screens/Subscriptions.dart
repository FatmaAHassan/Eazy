import 'package:Easy/core/Subscriptions/Screens/payment.dart';
import 'package:flutter/material.dart';
import '../../config/app_palette.dart';
import '../../config/images_manager.dart';

class UpgradeNowScreen extends StatelessWidget {
  const UpgradeNowScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppPalette.textLight,
        appBar: AppBar(
          backgroundColor: AppPalette.backgroundLight,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            "الاشتراكات",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppPalette.textBlack,
            ),
          ),
        ),

        body:SafeArea(
    child: Padding(
    padding: const EdgeInsets.only(top: 40), // تقليل المسافة
    child: Align(
    alignment: Alignment.topCenter,
    child: Container(
              width: 355,
              height: 470,
              decoration: BoxDecoration(
                color: AppPalette.textFiledFocusedBorder,
                borderRadius: BorderRadius.circular(16),

              ),
              child: Column(
                children: [
                  // 🔹 الشريط الازرق
                  Container(
                    height: 14,
                    decoration: const BoxDecoration(
                      color: AppPalette.primary,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                    ),
                  ),

                  // المحتوى
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Align(
                            alignment: Alignment.center,
                            child: Text(
                              "اشتراك أسبوعي",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppPalette.textBlack,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 17),
                          const Text(
                            "وصف خطة الاشتراك هنا والذي عادة ما يتكون من عدة أسطر وصف خطة الاشتراك هنا والذي عادة ما يتكون من عدة أسطر.",
                            style: TextStyle(
                              color: AppPalette.textSubtitleLight,
                              fontSize: 16,
                              height: 2,
                            ),
                          ),
                          const SizedBox(height: 35),
                          Row(
                            children: const [
                              Icon(Icons.check,
                                  color: AppPalette.textOrange, size: 20),
                              SizedBox(width: 8),
                              Text("وصف الميزة هنا",
                                  style: TextStyle(
                                      color: AppPalette.textBlack, fontSize: 16)),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: const [
                              Icon(Icons.check,
                                  color: AppPalette.textOrange, size: 20),
                              SizedBox(width: 8),
                              Text("وصف الميزة هنا",
                                  style: TextStyle(
                                      color: AppPalette.textBlack, fontSize: 16)),

                            ],
                          ),


                          const SizedBox(height: 20),
                          Row(
                            children: const [

                              Text("تاريخ التجديد 2023 يناير",
                                  style: TextStyle(
                                      color: AppPalette.textSubtitleLight, fontSize: 14)),

                            ],
                          ),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                "السعر",
                                style: TextStyle(
                                  color: AppPalette.textBlack,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "70 د.ل",
                                    style: TextStyle(
                                      color: AppPalette.textBlack,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    "70 د.ل",
                                    style: TextStyle(
                                      color: AppPalette.actionFailLight,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 40),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppPalette.textFiledEnabledBorder,
                                padding:
                                const EdgeInsets.symmetric(vertical: 20),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                    const PaymentScreen(),
                                  ),
                                );
                              },

                              label: const Text(
                                " تجديد اشتراك",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: AppPalette.textSubtitleLight,
                                ),
                              ),

                            ),

                          ),
                          SizedBox(height:10 ,)
                        ],
                      ),
                    ),

                  ),
                ],

              ),
            ),
          ),
        ),
      ),
    )
    );
  }
}
