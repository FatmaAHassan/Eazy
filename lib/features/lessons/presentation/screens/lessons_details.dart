import 'package:eazy/core/config/app_palette.dart';
import 'package:eazy/core/config/images_manager.dart';
import 'package:eazy/core/config/text_styles_manager.dart';
import 'package:eazy/features/lessons/presentation/widgets/showExitLessons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class LessonsDetails extends StatelessWidget {
  final String lessonTitle;
  final String lessonSubtitle;
  final String lessonContent;

  const LessonsDetails({
    Key? key,
    this.lessonTitle = 'Grammar',
    this.lessonSubtitle = 'الفرق بين {a-an}',
    this.lessonContent = '''وصف الدرس

يوضح قواعد اللغة الانجليزية بطريقة سهلة ومبسطة إحدى أهم القواعد في اللغة وهي عادة البسيطة كحماية الملل. ويتضمن قواعد الكتابة والقراءة والكتابة والكلام وهي عادة إبداء الكتابة. يوضح قواعد اللغة الانجليزية من خلال عادة مسبقة من خلال قواعد اللغة.

شرح الفرق بين go و و have في التفصيل

قبل البدء نعرف ؟ حروف العلة او الحروف المدركة وهي
(A-E-I-O-U)
وهو من الأدوات التي تعني "كل"، "مثل" و day هو من الاختيارات من خلال البيانات المؤونة والعلاقة المقترح أو قيل الحصي أو الاسماء الغير محدودة''',
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      // 👈 الاتجاه RTL
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
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(
                          Icons.arrow_back_ios,
                          size: 24.sp,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 30.h),
                  Column(
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 180.h,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(22.r),
                              child: Image.asset(
                                ImagesManager.newOffer,
                                width: double.infinity,
                                height: 192.h,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 20.w,
                            top: 55.h,
                            child: Text(
                              "grammaer",
                              textDirection: TextDirection.rtl,
                              style: GoogleFonts.cairo(
                                fontSize: 29.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: 20.h),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "الفرق بين {a - an}",
                          textAlign: TextAlign.right,
                          style: TextStylesManager.bodyMediumLight,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          // Fav button
                        },
                        icon: Icon(
                          Icons.bookmark,
                          size: 24.sp,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 8.h),

                  Text(
                    "وصف الدرس ",
                    style: GoogleFonts.tajawal(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[600],
                    ),
                  ),

                  SizedBox(height: 12.h),

                  Text(
                    "سنتعلم في هذا الدرس متى نستخدم سنتعلم في هذا الدرس متى نستخدم مع  ",
                    style: TextStylesManager.headlineLargeLight.copyWith(
                      fontSize: 12.sp,
                    ),
                  ),

                  SizedBox(height: 15.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "الامثلة",
                        style: TextStylesManager.bodySmallLight.copyWith(
                          fontSize: 12.sp,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      _buildExample("It's a present day", "إنه يوم حاضر"),
                      _buildExample("It's a lovely day", "إنه يوم جميل"),
                      _buildExample("Are you a doctor?", "هل أنت طبيب؟"),
                      _buildExample(
                        "I have got a daughter and two sons",
                        "لدي بنت وولدين",
                      ),
                    ],
                  ),

                  SizedBox(height: 20.h),

                  Text(
                    "أيضاً: نستخدم a مع الاسم الجمع وتأتي قبل",
                    style: GoogleFonts.tajawal(
                      fontSize: 12.sp,
                      color: AppPalette.badgeButton,
                      height: 1.6,
                    ),
                  ),

                  Text(
                    "الصفة المفردة في المذكر",
                    style: GoogleFonts.tajawal(
                      fontSize: 12.sp,
                      color: Colors.grey,
                      height: 1.6,
                    ),
                  ),

                  Text(
                    "سنتعلم أن قبل اسم مذكر مفرد يا فردي.",
                    style: GoogleFonts.tajawal(
                      fontSize: 12.sp,
                      color: Colors.grey[600],
                      height: 1.6,
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // Grammar rules card
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: Colors.blue),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "a/an",
                          textDirection: TextDirection.ltr,
                          style: GoogleFonts.tajawal(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                        Text(
                          "are used as indefinite articles ومستعل قبل المذكر",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.tajawal(
                            fontSize: 10.sp,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          "The",
                          textDirection: TextDirection.ltr,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.tajawal(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                        Text(
                          "is used as definite articles ومستعل قبل الاثة المعرفة",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.tajawal(
                            fontSize: 10.sp,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'We put "a" before a noun starting with a constant sound',
                          textDirection: TextDirection.ltr,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.tajawal(
                            fontSize: 10.sp,
                            color: Colors.grey[600],
                          ),
                        ),
                        Text(
                          "نضع \"a\" قبل الاسماء التي تبدأ بحرف صامت",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.tajawal(
                            fontSize: 10.sp,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          'We put "an" before a noun starting with a vowel sound',
                          textDirection: TextDirection.ltr,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.tajawal(
                            fontSize: 10.sp,
                            color: Colors.grey[600],
                          ),
                        ),
                        Text(
                          "نضع \"an\" قبل الاسماء التي تبدأ بحرف من حروف العلة",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.tajawal(
                            fontSize: 10.sp,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 40.h),

                  // Bottom button - not fixed, part of scroll content
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          showExitLessonDialog(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppPalette.badgeButton,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'انهي الدرس',
                          style: TextStylesManager.headlineSmallLight.copyWith(
                            fontSize: 16.sp,
                          ),
                          // style: GoogleFonts.tajawal(
                          //   fontSize: 16.sp,
                          //   fontWeight: FontWeight.w600,
                          // ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildExample(String english, String arabic) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            arabic,
            style: GoogleFonts.tajawal(fontSize: 10.sp, color: Colors.black),
          ),
          SizedBox(width: 8.w),
          Text(
            "• $english",
            textDirection: TextDirection.ltr,
            style: GoogleFonts.tajawal(fontSize: 10.sp, color: Colors.black),
          ),
        ],
      ),
    );
  }
}