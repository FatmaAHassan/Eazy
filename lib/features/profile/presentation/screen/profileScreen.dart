import 'package:eazy/constants.dart';
import 'package:eazy/core/config/images_manager.dart';
import 'package:eazy/features/Other/Screens/Api%20terms/Terms%20and%20Conditions.dart';
import 'package:eazy/features/Other/Screens/common%20questions.dart';
import 'package:eazy/features/Other/Screens/Api%20contact/contact%20us.dart';
import 'package:eazy/features/Other/widgets/logout_widget.dart';
import 'package:eazy/features/Other/widgets/share_Sheet.dart';
import 'package:eazy/features/Subscriptions/Screens/Subscriptions.dart';
import 'package:eazy/features/Subscriptions/Screens/Api%20UpgradeNow/Upgrade%20now.dart';
import 'package:eazy/features/authscreen/widgets/custom_setting_row.dart';
import 'package:eazy/features/authscreen/widgets/show_bottom_sheet.dart';
import 'package:eazy/features/profile/presentation/screen/personalDetailsScreen.dart';
import 'package:eazy/notification/presentation/screen/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  static const String routeName = 'ProfileScreen';
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        // bottomNavigationBar: BottomNavigationBar(
        //   currentIndex: 0,
        //   selectedItemColor: kPrimaryColor,
        //   unselectedItemColor: kSecondaryColor,
        //   items: const [
        //     BottomNavigationBarItem(icon: Icon(Icons.person), label: "حسابي"),
        //     BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.menu_book),
        //       label: "دروسي",
        //     ),
        //   ],
        // ),
        appBar: AppBar(
          automaticallyImplyLeading: false, // 👈 دي اللي بتخفي زرار الرجوع
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset("assets/images/text.jpg", width: 50, height: 50),
              const Text(
                'حسابي',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NotificationScreen(),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(),
                  child: SvgPicture.asset(ImagesManager.notification),
                ),
              ),
            ],
          ),
        ),


        body: Column(
          children: [
            // Profile
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage("assets/images/Oval.png"),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "محمد عمران",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                  const PersonalDetailsScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              "تعديل حسابي",
                              style: TextStyle(
                                color: kPrimaryColor,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Upgrade Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context); // إغلاق الرسالة
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UpgradeNowScreen(),
                    ),
                  );
                },
                icon: Image.asset(
                  "assets/images/crown.png",
                  height: 30,
                  width: 30,
                ),
                label: const Text(
                  "الترقية إلى النسخة المميزة",
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange.shade100,
                  foregroundColor: Color(0xFFFE9F45),
                  minimumSize: const Size(double.infinity, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            Column(
              children: [
                CustomSettingRow(
                  image: 'assets/images/subscription 1.png',
                  text: "الاشتراكات",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SubscriptionScreen(),
                      ),
                    );
                  },
                ),
                CustomSettingRow(
                  image: 'assets/images/question 1.png',
                  text: "الأسئلة الشائعة",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FAQScreen(),
                      ),
                    );
                  },
                ),
                CustomSettingRow(
                  image: 'assets/images/condition 1.png',
                  text: "الشروط والأحكام",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TermsAndConditionsPage(),
                      ),
                    );
                  },
                ),
                CustomSettingRow(
                  image: 'assets/images/call 1.png',
                  text: "تواصل معنا",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ContactUsScreen(),
                      ),
                    );
                  },
                ),
                CustomSettingRow(
                  image: 'assets/images/share (1) 2.png',
                  text:
                  "مشاركة التطبيق", ///////////////////////////////////////////////////////
                  onTap: () {
                    showShareSheet(context);
                  },
                ),
              ],
            ),

            Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      backgroundColor: Colors.white,
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                      ),
                      builder: (context) {
                        return const ShowBottomSheet(
                          title: 'تسجيل الخروج',
                          firstLine: 'هل ترغب في تسجيل الخروج؟',
                          secondLine: '',
                        );
                      },
                    );
                  },
                  child: LogoutButton(
                    onConfirm: () {

                      // هنا تكتبي الأكشن اللي يحصل فعلاً بعد ما المستخدم يوافق
                      print("User Logged Out ✅");
                      // مثلا: Navigator.pushReplacementNamed(context, "/login");
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}