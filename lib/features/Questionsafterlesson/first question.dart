import 'package:eazy/core/config/app_palette.dart';
import 'package:eazy/core/config/images_manager.dart';
import 'package:flutter/material.dart';
import 'Result.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FirstQuestionScreen extends StatefulWidget {
  const FirstQuestionScreen({super.key});
  static const String routeName = 'FirstQuestionScreen';

  @override
  State<FirstQuestionScreen> createState() => _FirstQuestionScreenState();
}

class _FirstQuestionScreenState extends State<FirstQuestionScreen> {
  int currentQuestion = 1;
  int totalQuestions = 4;


  final ScrollController _scrollController = ScrollController();

  final List<Map<String, dynamic>> questions = [
    {
      "question": " I saw ___ cat on the roof",
      "options": ["a", "an", "the", "there"],
      "answer": 0,
    },
    {
      "question": "She is ___ honest person",
      "options": ["a", "an", "the", "there"],
      "answer": 1,
    },
    {
      "question": " sun rises in the east  ___",
      "options": ["a", "an", "the", "there"],
      "answer": 2,
    },
    {
      "question": "is a book on the table  ___ ",
      "options": ["a", "an", "the", "there"],
      "answer": 3,
    },
  ];

  late List<int> selectedAnswers; // لتخزين اختيار كل سؤال
  int answeredCount = 0;

  @override
  void initState() {
    super.initState();
    selectedAnswers = List.filled(questions.length, -1); // -1 يعني لم يتم الاختيار بعد
  }

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
    IconButton(
    padding: EdgeInsets.zero,
    constraints: const BoxConstraints(),
    onPressed: () {
    if (currentQuestion > 1) {
    setState(() {
    currentQuestion--;
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
      IconButton(
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
        onPressed: () {
          if (currentQuestion < totalQuestions) {
            setState(() {
              currentQuestion++;
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
    buildProgressBar(),
    Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
    child: Row(
    children: [
    Image.asset(
    ImagesManager.mcqP,
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
    Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    child: Text(
    questions[currentQuestion - 1]["question"],
    textAlign: TextAlign.right,
    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    ),
    ),
    Expanded(
    child: SingleChildScrollView(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Column(
    children: List.generate(
    questions[currentQuestion - 1]["options"].length,
    (index) {
    return GestureDetector(
    onTap: () {
    setState(() {
    selectedAnswers[currentQuestion - 1] = index;
    });
    },
    child: Container(
    margin: const EdgeInsets.only(bottom: 12),
    decoration: BoxDecoration(
    color: selectedAnswers[currentQuestion - 1] == index
    ? AppPalette.primary
        : AppPalette.textLight,
    borderRadius: BorderRadius.circular(8),
    ),
    child: ListTile(
    title: Text(
    questions[currentQuestion - 1]["options"][index],
    style: TextStyle(
      color: selectedAnswers[currentQuestion - 1] == index
          ? AppPalette.textLight
          : AppPalette.textBlack,
      fontWeight: FontWeight.w500,
      fontSize: 15,
    ),
    ),
    ),
    ),
    );
    },
    ),
    ),
    ),
    ),
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
              int answer = selectedAnswers[currentQuestion - 1];
              if (answer != -1 &&
                  answer == questions[currentQuestion - 1]["answer"]) {
                answeredCount++;
              }

              if (currentQuestion < totalQuestions) {
                setState(() {
                  currentQuestion++;
                });
                _scrollToCurrentQuestion();
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResultScreen(
                      correctAnswers: answeredCount,
                      totalQuestions: totalQuestions,
                      questions: questions,
                      selectedAnswers: selectedAnswers,
                    ),
                  ),
                );
              }
            },
            child: Text(
              currentQuestion == totalQuestions ? "انهاء" : "التالي",
              style: const TextStyle(
                  fontSize: 16, color: AppPalette.textLight),
            ),
          ),
        ),
      ),
      const SizedBox(height: 20),
    ],
    ),
        ),
    );
  }
}