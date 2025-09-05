import 'package:flutter/material.dart';
import '../../../features/authscreen/widgets/custom_icon_bar.dart';
import '../../../features/authscreen/widgets/custom_notification_card.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});
  static const String routeName = 'notification_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: const Text(
          "الإشعارات",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          // IconButton(
          //   icon: const CustomIconBar(),
          //   onPressed: () => Navigator.pop(context),
          // ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
        child: ListView.builder(
          itemCount: 4,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: CustomNotificationCard(index: index),
            );
          },
        ),
      ),
    );
  }
}