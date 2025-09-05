import 'package:eazy/core/config/images_manager.dart';
import 'package:eazy/features/home/Data/home_cubit.dart';
import 'package:eazy/features/home/Data/model/home_model.dart';
import 'package:flutter/material.dart';
import 'package:eazy/core/config/text_styles_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:eazy/core/config/app_palette.dart';

class PromotionalBanner extends StatefulWidget {
  const PromotionalBanner({super.key});

  @override
  State<PromotionalBanner> createState() => _PromotionalBannerState();
}

class _PromotionalBannerState extends State<PromotionalBanner> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return SizedBox(
            height: 150.h,
            child: const Center(child: CircularProgressIndicator()),
          );
        } else if (state is HomeLoaded) {
          final List<SliderItem> sliders = state.homeData.sliders;

          return Column(
            children: [
              SizedBox(
                height: 180.h,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: sliders.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final slider = sliders[index];
                    return Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(22.r),
                          child: Image.network(
                            slider.image,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                            errorBuilder: (context, error, stackTrace) =>
                                Image.asset(
                                  ImagesManager.newOffer,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                          ),
                        ),
                        // العنوان والنص فوق الصورة
                        Positioned(
                          left: 20,
                          top: 20,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  style: TextStylesManager.headlineMediumLight
                                      .copyWith(
                                        color: AppPalette.textLight,
                                        fontWeight: FontWeight.bold,
                                      ),
                                  children: [
                                    const TextSpan(text: "اشترك بخصم "),
                                    TextSpan(
                                      text: "50%",
                                      style: TextStylesManager.titleLarge
                                          .copyWith(
                                            color: AppPalette.primary,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.sp,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  style: TextStylesManager.headlineMediumLight
                                      .copyWith(
                                        color: AppPalette.textLight,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.sp,
                                      ),
                                  children: _buildSubtitleSpans(
                                    "وتعلم جميع الدروس\nعلى إيزي",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 4),
              SmoothPageIndicator(
                controller: _pageController,
                count: sliders.length,
                effect: ExpandingDotsEffect(
                  dotHeight: 6,
                  dotWidth: 6,
                  activeDotColor: Colors.orange,
                  dotColor: Colors.grey.shade300,
                ),
              ),
            ],
          );
        } else if (state is HomeError) {
          return Text("Error: ${state.message}");
        }
        return const SizedBox.shrink();
      },
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
              fontSize: 18.sp,
            ),
          ),
        );
      }
    }
    return spans;
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
