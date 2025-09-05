import 'package:eazy/constants.dart';
import 'package:eazy/features/authscreen/update_password_screen.dart';
import 'package:eazy/features/authscreen/widgets/custom_buttom.dart';
import 'package:eazy/features/authscreen/widgets/custom_icon_bar.dart';
import 'package:eazy/features/authscreen/widgets/custom_text_field.dart';
import 'package:eazy/features/authscreen/widgets/show_bottom_sheet.dart';
import 'package:eazy/features/home/presentation/Screens/home.dart';
import 'package:eazy/features/profile/presentation/screen/profileScreen.dart';
import 'package:eazy/helper/show_dialog.dart';
import 'package:flutter/material.dart';

class PersonalDetailsScreen extends StatelessWidget {
  const PersonalDetailsScreen({super.key});
  static const String routeName = 'personal_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "البيانات الشخصية",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
              // push(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) => const ProfileScreen()),
              // );
            },
            icon: CustomIconBar(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  const CircleAvatar(
                    radius: 70,
                    backgroundImage: AssetImage("assets/images/Oval.png"),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(6),
                    child: const Icon(
                      Icons.camera_alt,
                      color: kPrimaryColor,
                      size: 30,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              CustomTextField(text: "اسم المستخدم"),
              const SizedBox(height: 25),
              CustomTextField(text: "رقم الهاتف"),
              const SizedBox(height: 25),
              CustomTextField(text: "البريد الإلكتروني"),
              const SizedBox(height: 25),

              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, UpdatePasswordScreen.routeName);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Text(
                      "تغيير كلمة المرور",
                      style: TextStyle(
                        color: kSecondaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.lock_outline, size: 25, color: Colors.grey),
                  ],
                ),
              ),

              SizedBox(height: 100),

              CustomButton(
                onTap: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                text: 'حفظ التعديلات',
              ),

              // زر حذف الحساب
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        backgroundColor: Colors.white,
                        context: context,
                        builder: (context) {
                          return ShowBottomSheet(
                            title: 'حذف الحساب',
                            firstLine:
                            'هل انت متأكد من انك تريد حذف الحساب؟ سيتم حذف',
                            secondLine: 'البيانات بشكل كامل',
                          );
                        },
                      );
                    },
                    child: Text(
                      "حذف الحساب",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: 4),
                  Icon(Icons.delete_outline, color: Colors.red),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}