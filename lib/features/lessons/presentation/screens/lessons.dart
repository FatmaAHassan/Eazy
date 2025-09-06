import 'package:eazy/core/config/text_styles_manager.dart';
import 'package:eazy/features/Subscriptions/Screens/Api%20UpgradeNow/Upgrade%20now.dart';
import 'package:flutter/material.dart';
import 'package:eazy/core/config/app_palette.dart';
import 'package:eazy/features/lessons/presentation/widgets/lessons_title.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LessonsScreen extends StatelessWidget {
  const LessonsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppPalette.backgroundLight,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5.h),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          size: 24.sp,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30.h),
                  LessonHeader(),
                  SizedBox(height: 40.h),
                  LessonTitle(text: "القواعد"),
                  SizedBox(height: 8.h),
                  LessonSectionTitle(text: "الوصف"),
                  SizedBox(height: 10.h),
                  LessonDescription(
                    text:
                    "سنتعلم في هذا الدرس متى نستخدم سنتعلم في هذا الدرس متى نستخدم مع "
                        "سنتعلم في هذا الدرس متى نستخدم سنتعلم في هذا الدرس متى نستخدم مع "
                        "سنتعلم في هذا الدرس متى نستخدم سنتعلم ... ",
                  ),
                  SizedBox(height: 20.h),
                  Divider(color: Colors.grey.shade300, thickness: 1),
                  SizedBox(height: 10.h),
                  LessonTitle(text: "الدروس"),
                  SizedBox(height: 20.h),

                  // قائمة الدروس
                  LessonItem(
                    title: "الفرق بين {a-an}",
                    subtitle: "الدرس الأول",
                    isCompleted: false,
                    isLocked: false,
                  ),
                  SizedBox(height: 16.h),

                  LessonItem(
                    title: "الفرق بين {this-that}",
                    subtitle: "الدرس الثاني",
                    isCompleted: false,
                    isLocked: true,
                  ),
                  SizedBox(height: 16.h),

                  LessonItem(
                    title: "الفرق بين {these-those}",
                    subtitle: "الدرس الثالث",
                    isCompleted: false,
                    isLocked: true,
                  ),
                  SizedBox(height: 16.h),

                  LessonItem(
                    title: "الأفعال المساعدة",
                    subtitle: "الدرس الرابع",
                    isCompleted: false,
                    isLocked: true,
                    hasNotification: true,
                  ),
                  SizedBox(height: 30.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LessonItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isCompleted;
  final bool isLocked;
  final bool hasNotification;

  const LessonItem({
    Key? key,
    required this.title,
    required this.subtitle,
    this.isCompleted = false,
    this.isLocked = false,
    this.hasNotification = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subtitle,
                    style: TextStylesManager.headlineMediumLight.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    title,
                    style: TextStylesManager.bodyMediumLight.copyWith(
                      color: isLocked ? Colors.black : Colors.black,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(width: 16.w),
            // Lock icon and subscribe text for locked items
            if (isLocked) ...[
              SizedBox(width: 4.w),
              SizedBox(
                width: 60.w,
                height: 28.h,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UpgradeNowScreen(),
                      ),
                    );
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: AppPalette.textOrange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.zero,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "اشترك",
                        style: TextStylesManager.headlineSmallLight.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(width: 2.w),
                      Icon(Icons.lock, size: 16.sp, color: Colors.white),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 2.w),
            ],
            Container(
              width: 40.w,
              height: 40.h,
              child: Center(
                child: Icon(_getIcon(), color: _getIconColor(), size: 20.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getIconColor() {
    if (isCompleted) return Colors.orange;
    if (isLocked) return Colors.grey;
    return Colors.orange;
  }

  IconData _getIcon() {
    if (isCompleted) return Icons.check;
    if (isLocked) return Icons.bookmark;
    return Icons.bookmark;
  }
}