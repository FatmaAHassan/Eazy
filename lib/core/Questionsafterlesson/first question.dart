import 'package:flutter/material.dart';
import '../config/app_palette.dart';
import '../config/images_manager.dart';
import 'Result.dart';
import 'package:flutter_svg/flutter_svg.dart';


class FirstQuestionScreen extends StatefulWidget {
  const FirstQuestionScreen({super.key});

  @override
  State<FirstQuestionScreen> createState() => _FirstQuestionScreenState();
}

class _FirstQuestionScreenState extends State<FirstQuestionScreen> {
  int selectedIndex = -1;
  final int totalQuestions = 4;
  int currentQuestion = 1;
  int answeredCount = 0;

  final ScrollController _scrollController = ScrollController();


  void _scrollToCurrentQuestion() {
    final double itemWidth = 50;
    final double targetOffset = (currentQuestion - 1) * itemWidth;

    _scrollController.animateTo(
      targetOffset,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }


  Widget buildProgressBar() {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // سهم لليسار
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: () {
                  if (currentQuestion > 1) {
                    setState(() {
                      currentQuestion--;
                      selectedIndex = -1;
                    });
                    _scrollToCurrentQuestion();
                  }
                },
                icon: const Icon(Icons.arrow_back_ios, size: 24),
              ),


              SizedBox(
                width: 208,
                height: 61,
                child: Center(
                  child: ListView.builder(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: totalQuestions,
                    itemBuilder: (context, index) {
                      final questionNumber = index + 1;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            currentQuestion = questionNumber;
                            selectedIndex = -1;
                          });
                          _scrollToCurrentQuestion();
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 6),
                          width: 33,
                          height: 33,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: questionNumber == currentQuestion
                                ? AppPalette.textOrange
                                : AppPalette.textLight,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            "$questionNumber",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: questionNumber == currentQuestion
                                  ? AppPalette.textLight
                                  : AppPalette.textSubtitleLight,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              // سهم لليمين
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: () {
                  if (currentQuestion < totalQuestions) {
                    setState(() {
                      currentQuestion++;
                      selectedIndex = -1;
                    });
                    _scrollToCurrentQuestion();
                  }
                },
                icon: const Icon(Icons.arrow_forward_ios, size: 24),
              ),
            ],
          ),

          const SizedBox(height: 6),

          Text(
            "أجبت $answeredCount من $totalQuestions",
            style: const TextStyle(fontSize: 13, color: AppPalette.textSubtitleLight),
          ),
        ],
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppPalette.textLight,
        appBar: AppBar(
          backgroundColor: AppPalette.textLight,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: const Text(
            "اختبار سريع",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppPalette.textBlack,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress Bar
            buildProgressBar(),


            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                children: [


              SvgPicture.asset(
              ImagesManager.mcq,          //  أيقونة الـ SVG
                width: 19,
                height: 17.25,
              ),

              const SizedBox(width: 6),
                  const Text(
                    "اختيار متعدد",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppPalette.primary),
                  ),
                ],
              ),
            ),


            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Text(
                "نص السؤال هنا والذي عادة ما يتكون من عدة اسطر ؟",
                textAlign: TextAlign.right,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),


            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: List.generate(4, (index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: selectedIndex == index
                              ? AppPalette.primary
                              : AppPalette.textLight,

                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ListTile(
                          title: Text(
                            "نص الاجابة ${index + 1}",
                            style: TextStyle(
                              color: selectedIndex == index
                                  ? AppPalette.textLight
                                  : AppPalette.textBlack,
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),

            //  زر التالي
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppPalette.primary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () {
                    if (selectedIndex != -1) {
                      setState(() {
                        answeredCount++;
                      });
                    }

                    if (currentQuestion < totalQuestions) {
                      setState(() {
                        currentQuestion++;
                        selectedIndex = -1;
                      });
                      _scrollToCurrentQuestion();
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResultScreen(correctAnswers: answeredCount,
                            totalQuestions: totalQuestions,),
                        ),
                      );
                    }
                  },
                  child: Text(
                    currentQuestion == totalQuestions ? "انهاء" : "التالي",
                    style: const TextStyle(fontSize: 16, color: AppPalette.textLight),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }
}
