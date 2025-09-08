import 'package:eazy/core/network/shared_prefrence.dart';
import 'package:eazy/features/Subscriptions/Screens/Api%20UpgradeNow/upgradeNow_Model.dart';
import 'package:eazy/features/Subscriptions/Screens/Api%20UpgradeNow/upgradenowRepositry.dart';
import 'package:flutter/material.dart';
import 'package:eazy/core/config/app_palette.dart';
import 'package:eazy/core/config/images_manager.dart';
import 'package:eazy/features/Subscriptions/Screens/payment.dart';
import 'package:eazy/nav_bar.dart';

class UpgradeNowScreen extends StatelessWidget {
  const UpgradeNowScreen({super.key});
  static const String routeName = 'UpgradeNowScreen';

  @override
  Widget build(BuildContext context) {
    final repo = SubscriptionRepository();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppPalette.primary,
        body: SafeArea(
          // 🔹 الأول نجيب التوكن من الشيرد بريفرنس
          child: FutureBuilder<String?>(
            future: getToken(),
            builder: (context, tokenSnapshot) {
              if (tokenSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator(color: AppPalette.textLight));
              } else if (tokenSnapshot.hasError) {
                return Center(
                  child: Text(
                    "حصل خطأ أثناء جلب التوكن: ${tokenSnapshot.error}",
                    style: const TextStyle(color: AppPalette.textLight),
                  ),
                );
              } else if (!tokenSnapshot.hasData || tokenSnapshot.data == null) {
                return const Center(
                  child: Text(
                    "لم يتم تسجيل الدخول",
                    style: TextStyle(color: AppPalette.textLight),
                  ),
                );
              }

              final token = tokenSnapshot.data!;

              // 🔹 بعد ما جبنا التوكن نجيب الباقة
              return FutureBuilder<subscription?>(
                future: repo.getSubscription(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator(color: AppPalette.textLight));
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        "حصل خطأ: ${snapshot.error}",
                        style: const TextStyle(color: AppPalette.textLight),
                      ),
                    );
                  } else if (!snapshot.hasData || snapshot.data?.package == null) {
                    return const Center(
                      child: Text(
                        "لا توجد بيانات متاحة",
                        style: TextStyle(color: AppPalette.textLight),
                      ),
                    );
                  }

                  final package = snapshot.data!.package!;

                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          // زر الإغلاق
                          Align(
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                              onTap: () => Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const CustomNavBar(initialIndex: 2),
                                ),
                                    (route) => false,
                              ),
                              child: const Icon(
                                Icons.close,
                                color: AppPalette.textLight,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // أيقونة
                          Image.asset(ImagesManager.unlock, height: 80),
                          const SizedBox(height: 20),

                          // العنوان
                          const Text(
                            '''الترقية الى
النسخة المميزة''',
                            style: TextStyle(
                              color: AppPalette.textLight,
                              fontSize: 33,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 40),

                          // الكارت الأبيض
                          Container(
                            width: 355,
                            decoration: BoxDecoration(
                              color: AppPalette.backgroundLight,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              children: [
                                // شريط
                                Container(
                                  height: 10,
                                  decoration: const BoxDecoration(
                                    color: AppPalette.sectionBackgroundOrange,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                      topRight: Radius.circular(8),
                                    ),
                                  ),
                                ),

                                // محتوى
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // عنوان الباقة من الـ API
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          package.title ?? "خطة بدون اسم",
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: AppPalette.textBlack,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),

                                      const SizedBox(height: 16),

                                      // وصف الباقة من الـ API
                                      Text(
                                        package.content ?? "لا يوجد وصف",
                                        style: const TextStyle(
                                          color: AppPalette.textSubtitleLight,
                                          fontSize: 16,
                                          height: 1.5,
                                        ),
                                      ),

                                      const SizedBox(height: 35),

                                      // السعر
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "السعر",
                                            style: TextStyle(
                                              color: AppPalette.textBlack,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                          Text(
                                            "${package.price ?? 0} د.ل",
                                            style: const TextStyle(
                                              color: AppPalette.textBlack,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 40),

                                      // زر الاشتراك
                                      SizedBox(
                                        width: double.infinity,
                                        child: ElevatedButton.icon(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: AppPalette.textOrangeLight,
                                            padding: const EdgeInsets.symmetric(vertical: 20),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => const PaymentScreen(),
                                              ),
                                            );
                                          },
                                          icon: Image.asset(
                                            ImagesManager.crownP,
                                            height: 20,
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
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
