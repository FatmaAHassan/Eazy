import 'package:eazy/core/config/app_palette.dart';
import 'package:eazy/core/config/images_manager.dart';
import 'package:eazy/core/config/text_styles_manager.dart';
import 'package:eazy/core/routing/routes.dart';
import 'package:eazy/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class LessonTitle extends StatelessWidget {
  final String text;
  const LessonTitle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.tajawal(
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }
}

class LessonSectionTitle extends StatelessWidget {
  final String text;
  const LessonSectionTitle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.tajawal(
        fontSize: 14.sp,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }
}

class LessonDescription extends StatelessWidget {
  final String text;
  const LessonDescription({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStylesManager.headlineLargeLight,
      // style: GoogleFonts.tajawal(
      //   fontSize: 12.sp,
      //   color: Colors.grey[600],
      //   height: 1.6,
      // ),
    );
  }
}

class LessonHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: double.infinity,
              height: 200.h,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(22.r),
                child: Image.asset(
                  ImagesManager.newOffer,
                  width: double.infinity,
                  height: 195.h,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              left: 20.w,
              top: 70.h,
              child: Text(
                "grammer",
                textAlign: TextAlign.center,
                style: GoogleFonts.tajawal(
                  fontSize: 29.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            Positioned(
              left: 25.w,
              right: 25.w,
              bottom: -20.h,
              child: TextButton(
                onPressed: () {
                  context.pushNamed(Routes.LessonsDetails);
                },
                style: TextButton.styleFrom(
                  backgroundColor: AppPalette.badgeButton,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 20.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.r),
                  ),
                  elevation: 2,
                  shadowColor: Colors.black.withOpacity(0.1),
                ),
                child: Text(
                  'ابدأ الدرس الأول',
                  style: TextStylesManager.headlineSmallLight.copyWith(
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}