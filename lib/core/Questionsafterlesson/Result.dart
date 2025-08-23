import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../config/app_palette.dart';
import '../config/images_manager.dart';
import 'Results.dart';

class ResultScreen extends StatelessWidget {
  final int correctAnswers;
  final int totalQuestions;
  final Duration timeTaken;

  const ResultScreen({
    super.key,
    required this.correctAnswers,
    required this.totalQuestions,
    this.timeTaken = const Duration(minutes: 5),
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ✅ أيقونة النجاح فوق الكونتينر
            SizedBox(height: 60,),

            SvgPicture.asset(
              ImagesManager.success,
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 20),

            const Text(
              "نتيجة الاختبار",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 50),

            //  الكونتينر الأساسي
            Container(
              width:313 ,
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
                            color:AppPalette.primary,
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
                        backgroundColor:
                        isCorrect ? AppPalette.primary : AppPalette.actionFailLight,
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

                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>  ResultsScreen(),
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
                            const Text(
                              "عرض الحلول",
                              style: TextStyle(color: AppPalette.textOrange),
                            ),
                            const SizedBox(width: 6),
                            CircleAvatar(
                              radius: 12,
                              backgroundColor:AppPalette.textOrange,
                              child: const Icon(Icons.remove_red_eye,
                                  size: 16, color: AppPalette.textLight),
                            ),
                          ],
                        ),
                      ),

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
                      )

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
                    // TODO: انتقل للدرس التالي
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:  AppPalette.primary, // اللون الأزرق من التصميم
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // Radius زي التصميم
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
            )
          ],
        ),
      ),
    );
  }
}
