import 'package:eazy/core/config/app_padding.dart';
import 'package:eazy/core/config/app_palette.dart';
import 'package:eazy/core/config/images_manager.dart';
import 'package:eazy/core/config/text_styles_manager.dart';
import 'package:eazy/features/authscreen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // الخلفية
          SizedBox.expand(
            child: Image.asset(ImagesManager.splashScreen, fit: BoxFit.cover),
          ),

          // المحتوى في منتصف الشاشة
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [Image.asset(ImagesManager.eazy, height: 200.h)],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 40.h),
              child: const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _pageController;
  int _currentPage = 0;

  final List<OnboardingPageModel> _pages = [
    OnboardingPageModel(
      title: "قم بتمكين تجربة التعلم الخاصة بك",
      description:
          "هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص. هذا النص هو مثال لنص يمكن",
    ),
    OnboardingPageModel(
      title: "اكتشف محتوى تعليمي متميز",
      description:
          "استفد من آلاف الساعات التعليمية المصممة خصيصاً لتطوير مهاراتك",
    ),
    OnboardingPageModel(
      title: "ابدأ رحلتك التعليمية الآن",
      description: "سجل حسابك وابدأ التعلم معنا في دقائق معدودة",
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              // محتوى الصفحات
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  physics: const BouncingScrollPhysics(),
                  reverse: true,
                  itemCount: _pages.length,
                  onPageChanged: (page) {
                    setState(() => _currentPage = page);
                  },
                  itemBuilder: (context, index) {
                    return _buildOnboardingPage(_pages[index]);
                  },
                ),
              ),

              // الأزرار أسفل الشاشة
              Padding(
                padding: EdgeInsets.only(
                  left: AppPadding.horizontalPagePadding,
                  right: AppPadding.horizontalPagePadding,
                  bottom: 30.h,
                ),
                child: _currentPage == _pages.length - 1
                    // زر البدء
                    ? ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppPalette.textOrange,
                          minimumSize: Size(double.infinity, 60.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          "ابدأ",
                          style: TextStylesManager.headlineMediumLight.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      )
                    // الصفحات الأولى والثانية
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        textDirection: TextDirection.ltr,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppPalette.badgeButton,
                              minimumSize: const Size(200, 57),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                  size: 18,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "التالي",
                                  style: TextStylesManager.headlineLargeLight
                                      .copyWith(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ),
                              );
                            },
                            child: Text(
                              "تخطي",
                              style: TextStylesManager.headlineLargeLight,
                            ),
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOnboardingPage(OnboardingPageModel page) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppPadding.horizontalPagePadding,
        vertical: AppPadding.verticalPadding,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(ImagesManager.onboarding, height: 350.h),
          SizedBox(height: 50.h),

          // مؤشر الصفحات تحت الصورة
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            textDirection: TextDirection.rtl,
            children: List.generate(
              _pages.length,
              (index) => _buildPageIndicator(index),
            ),
          ),

          SizedBox(height: 50),

          // العنوان
          Text(
            page.title,
            style: TextStylesManager.titleLarge,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10.h),

          // الوصف
          Text(
            page.description,
            style: TextStylesManager.headlineLargeLight,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildPageIndicator(int index) {
    return Container(
      width: 15.w,
      height: 15.h,
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentPage == index ? AppPalette.primary : Colors.grey[300],
      ),
    );
  }
}

class OnboardingPageModel {
  final String title;
  final String description;

  OnboardingPageModel({required this.title, required this.description});
}
