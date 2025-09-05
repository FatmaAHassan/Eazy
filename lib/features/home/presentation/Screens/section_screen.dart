import 'package:eazy/core/config/text_styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:eazy/core/config/app_palette.dart';

class SectionScreen extends StatelessWidget {
  const SectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final services = [
      ServiceItem(
        icon: Icons.quiz_outlined,
        title: 'القواعد',
        color: Colors.white,
      ),
      ServiceItem(
        icon: Icons.record_voice_over_outlined,
        title: 'كلمات',
        color: Colors.white,
      ),
      ServiceItem(
        icon: Icons.headset_mic_outlined,
        title: 'الاستماع',
        color: Colors.white,
      ),
      ServiceItem(
        icon: Icons.menu_book_outlined,
        title: 'القراءة',
        color: Colors.white,
      ),
      ServiceItem(
        icon: Icons.edit_note_outlined,
        title: 'الكتابة',
        color: Colors.white,
      ),
      ServiceItem(
        icon: Icons.psychology_outlined,
        title: 'المفردات',
        color: Colors.white,
      ),
      ServiceItem(
        icon: Icons.spatial_audio_outlined,
        title: 'المحادثة',
        color: Colors.white,
      ),
      ServiceItem(
        icon: Icons.translate_outlined,
        title: 'الترجمة',
        color: Colors.white,
      ),
      ServiceItem(
        icon: Icons.school_outlined,
        title: 'الاختبارات',
        color: Colors.white,
      ),
      ServiceItem(
        icon: Icons.quiz_outlined,
        title: 'القواعد',
        color: Colors.white,
      ),
      ServiceItem(
        icon: Icons.record_voice_over_outlined,
        title: 'كلمات',
        color: Colors.white,
      ),
      ServiceItem(
        icon: Icons.headset_mic_outlined,
        title: 'الاستماع',
        color: Colors.white,
      ),
    ];

    return Scaffold(
      backgroundColor: AppPalette.backgroundLight,
      appBar: AppBar(
        title: Text("الأقسام", style: TextStylesManager.titleLarge),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1,
          ),
          itemCount: services.length,
          itemBuilder: (context, index) =>
              ServiceCard(service: services[index]),
        ),
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final ServiceItem service;

  const ServiceCard({required this.service});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppPalette.foregroundLight,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Material(
        color: const Color.fromARGB(0, 235, 67, 67),
        child: InkWell(
          onTap: () {
            // Navigator.push(...) لما تروحي لصفحة تانية
          },
          borderRadius: BorderRadius.circular(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: AppPalette.badgeButton,
                  shape: BoxShape.circle,
                ),
                child: Icon(service.icon, size: 25, color: service.color),
              ),
              const SizedBox(height: 8),
              Text(
                service.title,
                style: TextStylesManager.titleSmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ServiceItem {
  final IconData icon;
  final String title;
  final Color color;

  ServiceItem({required this.icon, required this.title, required this.color});
}