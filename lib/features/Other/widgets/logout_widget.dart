import 'package:eazy/core/config/app_palette.dart';
import 'package:eazy/features/authscreen/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LogoutButton extends StatelessWidget {
  final VoidCallback? onConfirm; // هنا تدي أكشن بعد ما يضغط "نعم"

  const LogoutButton({super.key, this.onConfirm});

  void _showLogoutSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppPalette.backgroundLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (_) {
        return Padding(
          padding: EdgeInsets.all(5.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "تسجيل الخروج",
                style: TextStyle(
                  color: AppPalette.textBlack,
                  fontWeight: FontWeight.bold,
                  fontSize: 23,
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                "هل ترغب في تسجيل الخروج؟",
                style: TextStyle(
                  color: AppPalette.textSubtitleLight,
                  fontSize: 15,
                ),
              ),
              SizedBox(height: 20.h),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppPalette.badgeGrayButton,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                      ),
                      onPressed: () {
                        Navigator.pop(context); // يقفل الشيت
                      },
                      child: Text(
                        "تراجع",
                        style: TextStyle(
                          color: AppPalette.textLight,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 7.w),
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: AppPalette.badgeButton,
                        side: BorderSide(color: AppPalette.badgeButton),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, LoginScreen.routeName); // يقفل الشيت
                        if (onConfirm != null) {
                          onConfirm!(); // ينفذ الأكشن اللي أنتي بعتاه
                        }
                      },
                      child: Text(
                        "نعم",
                        style: TextStyle(
                          color: AppPalette.textLight,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _showLogoutSheet(context),
      child: const Text(
        "تسجيل الخروج",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}