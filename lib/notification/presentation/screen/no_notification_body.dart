import 'package:eazy/constants.dart';
import 'package:eazy/features/authscreen/widgets/custom_icon_bar.dart';
import 'package:flutter/material.dart';

class NoNotificationBody extends StatelessWidget {
  const NoNotificationBody({super.key});
  static const String routeName = 'no_notification_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "الإشعارات",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: CustomIconBar(),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              'assets/images/notification_icon.png',
              height: 100,
              width: 100,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'ليس لديك اشعارات جديدة حتي الآن',
            style: TextStyle(color: kSecondaryColor, fontSize: 18),
          ),
        ],
      ),
    );
  }
}