import 'package:eazy/core/config/app_palette.dart';
import 'package:eazy/core/config/images_manager.dart';
import 'package:eazy/features/lessons/presentation/screens/lessons.dart';
import 'package:eazy/features/myLessons/presentation/screens/Api_Mylesson/myLessons_screen.dart';
import 'package:eazy/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'Results.dart';

class ResultScreen extends StatelessWidget {
  final int correctAnswers;
  final int totalQuestions;
  final Duration timeTaken;

  final List<Map<String, dynamic>> questions;
  final List<int> selectedAnswers;

  const ResultScreen({
    super.key,
    required this.correctAnswers,
    required this.totalQuestions,
    required this.questions,
    required this.selectedAnswers,
    this.timeTaken = const Duration(minutes: 5),
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // ✅ المحتوى الأساسي
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 60),

                Image.asset(
                  ImagesManager.success1,
                  width: 200.w,
                  height: 200.h,
                ),
                const SizedBox(height: 20),

                const Text(
                  "نتيجة الاختبار",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 50),

                //  الكونتينر الأساسي
                Container(
                  width: 313,
                  height: 231,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppPalette.primaryMidLight,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: AppPalette.textLight,
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      //0 النتيجة
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "$totalQuestions / ",
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: AppPalette.textBlack,
                              ),
                            ),
                            TextSpan(
                              text: "$correctAnswers",
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: AppPalette.primary,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),

                      // ✅ الدواير
                      Wrap(
                        spacing: 8,
                        children: List.generate(totalQuestions, (index) {
                          bool isCorrect = index < correctAnswers;
                          return CircleAvatar(
                            radius: 15,
                            backgroundColor: isCorrect
                                ? AppPalette.primary
                                : AppPalette.actionFailLight,
                            child: Text(
                              "${index + 1}",
                              style: const TextStyle(
                                color: AppPalette.textLight,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        }),
                      ),

                      const SizedBox(height: 60),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          //  عدد الأسئلة والوقت
                          Column(
                            children: [
                              Text(
                                "$totalQuestions أسئلة", //  الرقم الأول
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: AppPalette.textBlack,
                                ),
                                textDirection: TextDirection.rtl,
                              ),
                              Text(
                                "${timeTaken.inMinutes} دقائق", //  الرقم الأول
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: AppPalette.textSubtitleLight,
                                ),
                                textDirection: TextDirection.rtl,
                              ),
                            ],
                          ),


                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ResultsScreen(questions: questions,             // ← لستة الأسئلة
                                      selectedAnswers: selectedAnswers,)
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent, // ✅ زر شفاف
                              shadowColor: Colors.transparent,
                              elevation: 0,
                            ),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 12,
                                  backgroundColor: AppPalette.textOrange,
                                  child: const Icon(
                                    Icons.remove_red_eye,
                                    size: 16,
                                    color: AppPalette.textLight,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                const Text(
                                  "عرض الحلول",
                                  style: TextStyle(
                                    color: AppPalette.textOrange,
                                  ),
                                ),


                              ],
                            ),
                          ),

                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 80),

                //  زرار الانتقال للدرس التالي (برا الكونتينر)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: SizedBox(
                    width: 340, // نفس العرض الثابت
                    height: 51, // نفس الارتفاع
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                        AppPalette.primary, // اللون الأزرق من التصميم
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            12,
                          ), // Radius زي التصميم
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 48,
                        ),
                      ),
                      child: const Text(
                        "انتقل للدرس التالي",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppPalette.textLight,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ✅ زر الكانسل فوق على اليمين
          SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(
                  Icons.close,
                  size: 28,
                  color: AppPalette.badgeGrayButton,
                ),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CustomNavBar(
                        initialIndex: 0,
                      ),
                    ),
                        (route) => false,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}