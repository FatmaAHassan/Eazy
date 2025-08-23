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
        backgroundColor: AppPalette.primary,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // زر الإغلاق
                Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close, color: AppPalette.textLight),
                  ),
                ),
                const SizedBox(height: 20),

                // أيقونة القفل
                Image.asset(
                  ImagesManager.unLocked,
                  height: 80,
                ),
                const SizedBox(height: 20),

                // العنوان
                const Text(
                  '''الترقية الى 
النسخة المميزه''',
                  style: TextStyle(
                    color: AppPalette.textLight,
                    fontSize: 33,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),


                // الكارت الأبيض مع الشريط الأصفر
                Container(
                  width: 355, // العرض المطلوب
                  height: 470, // الارتفاع المطلوب
                  decoration: BoxDecoration(
                    color: AppPalette.backgroundLight,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      // 🔹 الشريط الأصفر
                      Container(
                        height: 12,
                        decoration: const BoxDecoration(
                          color: AppPalette.sectionBackgroundOrange,
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
                              // عنوان الاشتراك في المنتصف
                              const Align(
                                alignment: Alignment.center, // توسيط النص
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

                              Text(
                                "وصف خطة الاشتراك هنا والذي عادة ما يتكون من عدة أسطر وصف خطة الاشتراك هنا والذي عادة ما يتكون من عدة أسطر.",
                                style: const TextStyle(
                                  color: AppPalette.textSubtitleLight,
                                  fontSize: 16,
                                  height: 2,

                                ),
                              ),
                              const SizedBox(height: 35),

                              // المميزات
                              Row(
                                children: const [
                                  Icon(Icons.check, color: AppPalette.textOrange, size: 20),
                                  SizedBox(width: 8),
                                  Text("وصف الميزة هنا",
                                      style: TextStyle(color: AppPalette.textBlack,fontSize:16 )),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: const [
                                  Icon(Icons.check, color: AppPalette.textOrange, size: 20),
                                  SizedBox(width: 8),
                                  Text("وصف الميزة هنا",
                                      style: TextStyle(color: AppPalette.textBlack,fontSize:16)),
                                ],
                              ),
                              const Spacer(),

                              // السعر
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
                                        "70 د.ل", // السعر المخفض
                                        style: TextStyle(
                                          color: AppPalette.textBlack,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        "70 د.ل", // السعر القديم
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

                              // زر الاشتراك
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:Colors.amber[50],
                                    padding: const EdgeInsets.symmetric(vertical: 20),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  onPressed: () {Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const PaymentScreen(),
                                    ),
                                  );},
                                  icon: Image.asset(
                                    ImagesManager.crown,
                                    height: 20,
                                    color: AppPalette.textLight,
                                  ),
                                  label: const Text(
                                    "اشتراك",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: AppPalette.textOrange,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
