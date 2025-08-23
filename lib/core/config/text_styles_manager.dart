 import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_palette.dart';

class TextStylesManager {
  // ******************************************** light ****************************************
  static TextStyle titleLargeLight = TextStyle(
    fontFamily: 'FFShamelFamily',
    fontSize: 16.sp,
    color: AppPalette.textBlack,
    fontWeight: FontWeight.w700,
  );
  static TextStyle titleMedium = TextStyle(
    fontFamily: 'FFShamelFamily',
    fontSize: 18.sp,
    color: AppPalette.textBlack,
    fontWeight: FontWeight.w400,
  );
  static TextStyle titleSmall = TextStyle(
    fontFamily: 'FFShamelFamily',
    fontSize: 12.sp,
    color: AppPalette.textBlack,
    fontWeight: FontWeight.w400,
  );
  static TextStyle headlineLargeLight = TextStyle(
    fontFamily: 'FFShamelFamily',
    fontSize: 15.sp,
    color: AppPalette.textSubtitleLight,
    fontWeight: FontWeight.w400,
  );
  static TextStyle headlineMediumLight = TextStyle(
    fontFamily: 'FFShamelFamily',
    fontSize: 14.sp,
    color: AppPalette.textSubtitleLight,
    fontWeight: FontWeight.w400,
  );
  static TextStyle headlineSmallLight = TextStyle(
    fontFamily: 'FFShamelFamily',
    fontSize: 12.sp,
    color: AppPalette.textSubtitleLight,
    fontWeight: FontWeight.w400,
  );
  static TextStyle bodyLargeLight = TextStyle(
    fontFamily: 'FFShamelFamily',
    fontSize: 18.sp,
    color: AppPalette.textBlack,
    fontWeight: FontWeight.w400,
  );
  static TextStyle bodyMediumLight = GoogleFonts.tajawal(
    fontSize: 14.sp,
    color: AppPalette.textBlackLight,
    fontWeight: FontWeight.w700,
  );
  static TextStyle bodySmallLight = TextStyle(
    fontFamily: 'FFShamelFamily',
    fontSize: 12.sp,
    color: const Color.fromRGBO(254, 159, 69, 1),
    fontWeight: FontWeight.w400,
  );
}
