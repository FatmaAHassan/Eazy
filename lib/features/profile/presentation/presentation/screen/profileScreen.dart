import 'package:eazy/constants.dart';
import 'package:eazy/core/config/images_manager.dart';
import 'package:eazy/features/Other/Screens/Terms%20and%20Conditions.dart';
import 'package:eazy/features/Other/Screens/common%20questions.dart';
import 'package:eazy/features/Other/Screens/contact%20us.dart';
import 'package:eazy/features/Other/widgets/logout_widget.dart';
import 'package:eazy/features/Other/widgets/share_Sheet.dart';
import 'package:eazy/features/Subscriptions/Screens/Subscriptions.dart';
import 'package:eazy/features/Subscriptions/Screens/Upgrade%20now.dart';
import 'package:eazy/features/authscreen/widgets/custom_setting_row.dart';
import 'package:eazy/features/authscreen/widgets/show_bottom_sheet.dart';
import 'package:eazy/features/profile/presentation/presentation/screen/personalDetailsScreen.dart';
import 'package:eazy/notification/presentation/screen/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../profilecubit/profile_cubit.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  static const String routeName = 'ProfileScreen';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // سجل الصفحة مع RouteObserver
    routeObserver.subscribe(this, ModalRoute.of(context)!);
    // جلب البيانات لأول مرة
    context.read<ProfileCubit>().getProfile();
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  // هذا ينفذ عند العودة للصفحة بعد الخروج منها
  @override
  void didPopNext() {
    // جلب البيانات المحدثة
    context.read<ProfileCubit>().getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
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
                  child: SvgPicture.asset(ImagesManager.notification),
                ),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(16),
                child: BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (context, state) {
                    if (state is ProfileLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is ProfileLoaded) {
                      final profile = state.profile;
                      return Row(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundImage: profile.image != null
                                ? NetworkImage(profile.image!) as ImageProvider
                                : const AssetImage("assets/images/Oval.png"),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  profile.name,
                                  style: const TextStyle(
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
                                    ).then((_) {

                                      context.read<ProfileCubit>().getProfile();
                                    });
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
                      );
                    } else if (state is ProfileError) {
                      return Text(
                        state.message,
                        style: const TextStyle(color: Colors.red),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ),
            ),
            // Upgrade Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
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
                  foregroundColor: const Color(0xFFFE9F45),
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
                  text: "مشاركة التطبيق",
                  onTap: () {
                    showShareSheet(context);
                  },
                ),
              ],
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
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
                      print("User Logged Out ✅");
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

// لازم تعرف RouteObserver في مكان مركزي بالـ app
final RouteObserver<ModalRoute<void>> routeObserver =
    RouteObserver<ModalRoute<void>>();
