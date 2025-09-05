import 'package:eazy/core/config/app_palette.dart';
import 'package:eazy/core/config/text_styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

void showExitLessonDialog(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "الخروج من الدرس ",
              style: TextStylesManager.titleLarge.copyWith(fontSize: 20.sp),
            ),
            SizedBox(height: 15.h),
            Text(
              " هل تود الخروج من الدرس؟يمكنك الرجوع في اي وقت ",
              style: TextStylesManager.headlineMediumLight.copyWith(
                fontSize: 13,
              ),
            ),
            SizedBox(height: 25.h),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppPalette.badgeButton,
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      "نعم",
                      style: TextStyle(color: AppPalette.textLight),
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppPalette.badgeGrayButton,
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      "تراجع",
                      style: TextStyle(color: AppPalette.textLight),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}