import 'package:eazy/core/config/app_palette.dart';
import 'package:eazy/features/Subscriptions/Screens/payment.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Api UpgradeNow/upgradeNow_Model.dart';
import 'Api UpgradeNow/upgradenowRepositry.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("access_token");
  }

  @override
  Widget build(BuildContext context) {
    final repo = SubscriptionRepository();

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
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),

        body: SafeArea(
          child: FutureBuilder<String?>(
            future: _getToken(),
            builder: (context, tokenSnapshot) {
              if (tokenSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(color: AppPalette.textLight),
                );
              }

              if (!tokenSnapshot.hasData || tokenSnapshot.data == null) {
                return const Center(
                  child: Text("لم يتم العثور على التوكين"),
                );
              }

              final token = tokenSnapshot.data!;

              return FutureBuilder<subscription?>(
                future: repo.getSubscription(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child:
                        CircularProgressIndicator(color: AppPalette.textLight));
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

                  return Padding(
                    padding: const EdgeInsets.only(top: 40),
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
                            // 🔹 الشريط الأزرق
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

                            // 🔹 المحتوى
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
                                    Text(
                                      package.content ?? "لا يوجد وصف",
                                      style: const TextStyle(
                                        color: AppPalette.textSubtitleLight,
                                        fontSize: 16,
                                        height: 2,
                                      ),
                                    ),
                                    const SizedBox(height: 35),
                                    Row(
                                      children: const [
                                        Icon(
                                          Icons.check,
                                          color: AppPalette.textOrange,
                                          size: 20,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          "مميزات حصرية لعملائنا المميزين.",
                                          style: TextStyle(
                                            color: AppPalette.textBlack,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 15),
                                    Row(
                                      children: const [
                                        Icon(
                                          Icons.check,
                                          color: AppPalette.textOrange,
                                          size: 20,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          "دعم فني متواصل على مدار الساعة",
                                          style: TextStyle(
                                            color: AppPalette.textBlack,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),

                                    const SizedBox(height: 30),
                                    Column(
                                      children: [
                                        Text(
                                          " تاريخ الاشتراك :${package.createdAt ?? 0}",
                                          style: const TextStyle(
                                            color: AppPalette.textSubtitleLight,
                                            fontSize: 14,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          " تاريخ التجديد :${package.updatedAt ?? 0} ",
                                          style: const TextStyle(
                                            color: AppPalette.textSubtitleLight,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
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
                                              "${package.price ?? 0} د.ل",
                                              style: const TextStyle(
                                                color: AppPalette.textBlack,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
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
                                          backgroundColor:
                                          AppPalette.textFiledEnabledBorder,
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 20,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(12),
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
                                    const SizedBox(height: 10),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
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
