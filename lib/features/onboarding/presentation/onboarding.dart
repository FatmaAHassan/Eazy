import 'package:eazy/core/Api/api_service.dart';
import 'package:eazy/core/config/app_padding.dart';
import 'package:eazy/core/config/app_palette.dart';
import 'package:eazy/core/config/images_manager.dart';
import 'package:eazy/core/config/text_styles_manager.dart';
import 'package:eazy/features/authscreen/login_screen.dart';
import 'package:eazy/features/onboarding/data/onboarding_cubit.dart';
import 'package:eazy/features/onboarding/data/onboarding_datasource.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          OnboardingCubit(OnboardingRemoteDataSource(ApiService()))
            ..fetchOnboarding(),
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<OnboardingCubit, OnboardingState>(
            builder: (context, state) {
              if (state is OnboardingLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is OnboardingLoaded) {
                final slides = state.slides;
                return Column(
                  children: [
                    //الصفح
                    Expanded(
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: slides.length,
                        onPageChanged: (index) {
                          setState(() => _currentPage = index);
                        },
                        itemBuilder: (context, index) {
                          final slide = slides[index];
                          return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.network(
                                  slide.image,
                                  height: 200.h,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                      ImagesManager.onboarding,
                                      height: 350.h,
                                    );
                                  },
                                ),
                                SizedBox(height: 50.h), // المؤشر تحت الصورة
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(
                                    slides.length,
                                    (dotIndex) => Container(
                                      width: 15.w,
                                      height: 15.h,
                                      margin: const EdgeInsets.symmetric(
                                        horizontal: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: _currentPage == dotIndex
                                            ? AppPalette.primary
                                            : Colors.grey[300],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 50),
                                Text(
                                  slide.title,
                                  style: TextStylesManager.titleLarge,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  slide.content,
                                  style: TextStylesManager.headlineLargeLight,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    // الأزرار
                    Padding(
                      padding: EdgeInsets.only(
                        left: AppPadding.horizontalPagePadding,
                        right: AppPadding.horizontalPagePadding,
                        bottom: 30.h,
                      ),
                      child: _currentPage == slides.length - 1
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
                                minimumSize: const Size(double.infinity, 60),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                "ابدأ",
                                style: TextStylesManager.headlineMediumLight
                                    .copyWith(color: Colors.white),
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              textDirection: TextDirection.ltr,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    _pageController.nextPage(
                                      duration: const Duration(
                                        milliseconds: 300,
                                      ),
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
                                      Text(
                                        "التالي",
                                        style: TextStylesManager
                                            .headlineLargeLight
                                            .copyWith(color: Colors.white),
                                      ),
                                      const SizedBox(width: 15),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.white,
                                        size: 18,
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
                );
              } else if (state is OnboardingError) {
                return Center(child: Text("Error: ${state.message}"));
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
