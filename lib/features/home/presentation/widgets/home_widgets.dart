import 'package:eazy/core/config/text_styles_manager.dart';
import 'package:eazy/features/home/presentation/Screens/section_screen.dart';
import 'package:eazy/features/lessons/presentation/screens/lessons.dart';
import 'package:flutter/material.dart';
import 'package:eazy/core/config/app_palette.dart';
import 'package:eazy/core/config/images_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../core/routing/routes.dart';

class PromotionalBanner extends StatefulWidget {
  const PromotionalBanner({super.key});

  @override
  State<PromotionalBanner> createState() => _PromotionalBannerState();
}

class _PromotionalBannerState extends State<PromotionalBanner> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 140,
          child: PageView(
            controller: _pageController,
            physics: const BouncingScrollPhysics(),
            children: [
              _buildBanner(
                title1: "اشترك بخصم ",
                title2: "20%",
                subtitle: "وتعلم جميع الدروس\nعلى إيزي",
                image: ImagesManager.newOffer,
              ),
              _buildBanner(
                title1: "عرض مميز ",
                title2: "50%",
                subtitle: "على جميع الكورسات",
                image: ImagesManager.newOffer,
              ),
            ],
          ),
        ),
        const SizedBox(height: 5),
        SmoothPageIndicator(
          controller: _pageController,
          count: 2,
          effect: ExpandingDotsEffect(
            dotHeight: 6,
            dotWidth: 6,
            activeDotColor: Colors.orange,
            dotColor: Colors.grey.shade300,
          ),
        ),
      ],
    );
  }

  Widget _buildBanner({
    required String title1,
    required String title2,
    required String subtitle,
    required String image,
  }) {
    return Container(
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(22.r),
            child: Image.asset(
              image,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Positioned(
            left: 20,
            top: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: TextStylesManager.headlineMediumLight.copyWith(
                      color: AppPalette.textLight,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(text: title1),
                      TextSpan(
                        text: title2,
                        style: TextStylesManager.titleLarge.copyWith(
                          color: AppPalette.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                RichText(
                  text: TextSpan(
                    style: TextStylesManager.headlineMediumLight.copyWith(
                      color: AppPalette.textLight,
                      fontWeight: FontWeight.bold,
                    ),
                    // TextStyle(
                    //   color: Colors.white,
                    //   fontSize: 14,
                    //   fontWeight: FontWeight.w500,
                    //   height: 1.2,
                    // ),
                    children: _buildSubtitleSpans(subtitle),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<TextSpan> _buildSubtitleSpans(String subtitle) {
    List<TextSpan> spans = [];
    List<String> parts = subtitle.split('إيزي');

    for (int i = 0; i < parts.length; i++) {
      if (parts[i].isNotEmpty) {
        spans.add(TextSpan(text: parts[i]));
      }

      if (i < parts.length - 1) {
        spans.add(
          TextSpan(
            text: 'إيزي  ',
            style: TextStylesManager.titleLarge.copyWith(
              color: AppPalette.primary,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        );
      }
    }
    return spans;
  }
}

@override
class SearchSection extends StatelessWidget {
  const SearchSection();

  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: (value) {
        if (value.trim().isNotEmpty) {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => SearchResultPage(query: value),
          //   ),
          // );
        }
      },
      decoration: InputDecoration(
        hintText: 'ابحث عن درس ...',
        hintStyle: TextStylesManager.titleSmall,
        prefixIcon: Icon(
          Icons.search_sharp,
          color: AppPalette.lightBlack,
          size: 22,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        filled: true,
        fillColor: AppPalette.textFiledSearch,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: AppPalette.textFiledEnabledBorder,
            width: 0.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: AppPalette.textFiledEnabledBorder,
            width: 1,
          ),
        ),
      ),
      style: TextStyle(color: AppPalette.textBlack),
    );
  }
}

class WelcomeSection extends StatelessWidget {
  const WelcomeSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        children: [Text('أحدث العروض', style: TextStylesManager.titleLarge)],
      ),
    );
  }
}

class ServicesSection extends StatelessWidget {
  const ServicesSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('الأقسام ', style: TextStylesManager.titleLarge),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SectionScreen(),
                  ),
                );
              },
              child: Text('المزيد', style: TextStylesManager.bodySmallLight),
            ),
          ],
        ),
        const SizedBox(height: 10),
        const ServiceGrid(),
      ],
    );
  }
}

class ServiceGrid extends StatelessWidget {
  const ServiceGrid();

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
        title: 'القواعد',
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
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1,
      ),
      itemCount: services.length,
      itemBuilder: (context, index) => ServiceCard(service: services[index]),
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
            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(
            //     content: Text('تم اختيار قسم ${service.title}'),
            //     backgroundColor: service.color,
            //     duration: const Duration(seconds: 2),
            //   ),
            // );
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

class ContinueLessonsCard extends StatelessWidget {
  const ContinueLessonsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'الفرق بين {a-an}',
                style: TextStylesManager.bodyMediumLight,
              ),
              Icon(Icons.bookmark, color: Colors.orange),
            ],
          ),
          const SizedBox(height: 4),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, Routes.FirstQuestionScreen);
            },
            child: const Text(
              '4 أسئلة تقييم وتمارين',
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
          ),

          const SizedBox(height: 4),

          // الوقت
          Row(
            children: const [
              Icon(Icons.timer_outlined, size: 14, color: Colors.grey),
              SizedBox(width: 4),
              Text(
                '5 دقائق',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),

          const SizedBox(height: 10),

          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: 0.1,
                    backgroundColor: Colors.grey.shade200,
                    color: Colors.orange,
                    minHeight: 8,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade700,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LessonsScreen(),
                    ),
                  );
                },
                child: Text(
                  'استكمل',
                  style: TextStylesManager.headlineSmallLight,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}