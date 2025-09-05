import 'package:eazy/core/config/app_palette.dart';
import 'package:eazy/features/home/presentation/widgets/continue_lessons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyLessonsScreen extends StatefulWidget {
  const MyLessonsScreen({Key? key}) : super(key: key);

  @override
  State<MyLessonsScreen> createState() => _MyLessonsScreenState();
}

class _MyLessonsScreenState extends State<MyLessonsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPalette.backgroundLight,
      appBar: AppBar(
        title: const Text(
          "دروسي",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        // leading: IconButton(
        //   icon: const Icon(
        //     Icons.arrow_back_ios_new,
        //     color: Colors.black87,
        //   ),
        //   onPressed: () {
        //     context.pushNamed(Routes.HomeScreen);
        //   },
        // ),
      ),
      body: SafeArea(
        child: const SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              ContinueLessonsCard(),
              SizedBox(height: 10),
              LessonItem(
                title: " الدرس الثاني - الوظائف",
                subtitle: "قسم الكلمات ",
                isCompleted: false,
              ),
              SizedBox(height: 16),
              LessonItem(
                title: " الدرس الثالث - الوظائف",
                subtitle: "قسم الكلمات ",
                isCompleted: false,
              ),
              SizedBox(height: 16),
              LessonItem(
                title: " الدرس الرابع - الوظائف",
                subtitle: "قسم الكلمات ",
                isCompleted: false,
              ),
              SizedBox(height: 30),
            ],
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

  const LessonItem({
    Key? key,
    required this.title,
    required this.subtitle,
    this.isCompleted = false,
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
            // النص
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(width: 16.w),
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
    return Colors.orange;
  }

  IconData _getIcon() {
    if (isCompleted) return Icons.check;
    return Icons.bookmark;
  }
}