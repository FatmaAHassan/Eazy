import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_palette.dart';

class TextStylesManager {
  // ******************************************** light ****************************************
  static TextStyle titleLarge = TextStyle(
    fontFamily: 'tajawal',
    fontSize: 18.sp,
    color: AppPalette.textBlack,
    fontWeight: FontWeight.w800,
  );
  static TextStyle titleMedium = TextStyle(
    fontFamily: 'tajawal',
    fontSize: 16.sp,
    color: AppPalette.textBlack,
    fontWeight: FontWeight.w400,
  );
  static TextStyle titleSmall = TextStyle(
    fontFamily: 'tajawal',
    fontSize: 12.sp,
    color: AppPalette.textBlack,
    fontWeight: FontWeight.w400,
  );
  static TextStyle headlineLargeLight = TextStyle(
    fontFamily: 'tajawal',
    fontSize: 16.sp,
    color: AppPalette.textSubtitleLight,
    fontWeight: FontWeight.w400,
  );
  static TextStyle headlineMediumLight = TextStyle(
    fontFamily: 'tajawal',
    fontSize: 14.sp,
    color: AppPalette.textSubtitleLight,
    fontWeight: FontWeight.w700,
  );
  static TextStyle headlineSmallLight = TextStyle(
    fontFamily: 'tajawal',
    fontSize: 12.sp,
    color: AppPalette.textLight,
    fontWeight: FontWeight.w700,
  );
  static TextStyle bodyLargeLight = TextStyle(
    fontFamily: 'tajawal',
    fontSize: 18.sp,
    color: AppPalette.textBlack,
    fontWeight: FontWeight.w400,
  );
  static TextStyle bodyMediumLight = TextStyle(
    fontFamily: 'tajawal',
    fontSize: 14.sp,
    color: AppPalette.textBlackLight,
    fontWeight: FontWeight.w700,
  );
  static TextStyle bodySmallLight = TextStyle(
    fontFamily: 'tajawal',
    fontSize: 14.sp,
    color: const Color.fromRGBO(254, 159, 69, 1),
    fontWeight: FontWeight.w400,
  );
}