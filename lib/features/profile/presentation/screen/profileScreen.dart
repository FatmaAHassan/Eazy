
import 'package:easy_app/features/profile/presentation/screen/personalDetailsScreen.dart';
import 'package:flutter/material.dart';

import '../../../../constants.dart';
import '../../../../core/Other/Screens/contact us.dart';
import '../../../../core/Other/Screens/log out.dart';
import '../../../../core/Other/Screens/share app.dart';
import '../../../../core/Subscriptions/Screens/Subscriptions.dart';
import '../../../authscreen/widgets/custom_setting_row.dart';
import '../../../authscreen/widgets/show_bottom_sheet.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  static const String routeName = 'Profile_Screen';
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 0,
          selectedItemColor: kPrimaryColor,
          unselectedItemColor: kSecondaryColor,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "حسابي"),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_book),
              label: "دروسي",
            ),
          ],
        ),
        appBar: AppBar(
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

              Image.asset("assets/images/notf.jpg", height: 50, width: 50),
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
                        builder: (context) => const UpgradeNowScreen()),
                  );
                },
                icon: Image.asset("assets/images/crown.png", height: 30, width: 30),
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
                  onTap: () {},
                ),
                CustomSettingRow(
                  image: 'assets/images/question 1.png',
                  text: "الأسئلة الشائعة",
                ),
                CustomSettingRow(
                  image: 'assets/images/condition 1.png',
                  text: "الشروط والأحكام",
                ),
                CustomSettingRow(
                  image: 'assets/images/call 1.png',
                  text: "تواصل معنا",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ContactUsScreen()),
                    );
                  },
                ),
                CustomSettingRow(
                  image: 'assets/images/share (1) 2.png',
                  text: "مشاركة التطبيق", ///////////////////////////////////////////////////////
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SharePage()),
                    );
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
                  child: ElevatedButton(
                     onPressed: () {
                       Navigator.push(
                         context,
                         MaterialPageRoute(builder: (context) => const LogoutPage()),
                       );
                     },
                    child: Text("تسجيل الخروج",
                    style: TextStyle(
                    color: kSecondaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,

                  ),),
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
