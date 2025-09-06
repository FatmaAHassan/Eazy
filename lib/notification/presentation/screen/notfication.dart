import 'package:flutter/material.dart';

import '../../../features/authscreen/widgets/custom_icon_bar.dart';

class NotificationsPage extends StatelessWidget {
  final List<Map<String, String>> notifications;

  const NotificationsPage({super.key, required this.notifications});

  @override
  Widget build(BuildContext context) {
    bool hasNotifications = notifications.isNotEmpty;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "الإشعارات",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          //  leading: IconButton(
          //    icon: CustomIconBar(),
          //    //const Icon(Icons.arrow_back_ios, color: Colors.black),
          //    onPressed: () => Navigator.pop(context),
          //  ),
        ),
        body: hasNotifications
            ? ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            final item = notifications[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.article_outlined, size: 28),
                  ),
                  const SizedBox(width: 12),
                  // النصوص
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['title']!,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          item['body']!,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey.shade600,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        )
            : Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                "images/no notification.png",
                width: 120,
                height: 120,
              ),
              const SizedBox(height: 16),
              Text(
                "ليس لديك إشعارات جديدة حتى الآن",
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}