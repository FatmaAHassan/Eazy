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
    const String token="eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2Vhc3kuc3ludGVjaGVnLmNvbS9hcGkvbG9naW4iLCJpYXQiOjE3NTY3NDA5MzEsImV4cCI6MTc1Njc0NDUzMSwibmJmIjoxNzU2NzQwOTMxLCJqdGkiOiJCd1E3N3U2T2VHbXg4eE00Iiwic3ViIjoiNjkiLCJwcnYiOiJhYmM4NDdmZjY0ZDA4OTQ3MTExZWU3NjNkZTEzMzY5MWRiNWEyNTgzIn0.Qy4rT0BX9R2G95Ccp8AWlvdW5ahh_R9yECONUrj7nZM";

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppPalette.primary,
        body: SafeArea(
          child: FutureBuilder<subscription?>(
            future: repo.getSubscription(token),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator(color: AppPalette.textLight));
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    "حصل خطأ: ${snapshot.error}",
                    style: const TextStyle(color:  AppPalette.textLight),
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
          ),
        ),
      ),
    );
  }
}
