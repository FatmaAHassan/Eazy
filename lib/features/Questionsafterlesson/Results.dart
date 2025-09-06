import 'package:eazy/core/config/app_palette.dart';
import 'package:eazy/core/config/images_manager.dart';
import 'package:flutter/material.dart';

class ResultsScreen extends StatefulWidget {
  final List<Map<String, dynamic>> questions;
  final List<int> selectedAnswers;

  const ResultsScreen({
    super.key,
    required this.questions,
    required this.selectedAnswers,
  });

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  final ScrollController _scrollController = ScrollController();

  late final List<GlobalKey> _questionKeys;

  @override
  void initState() {
    super.initState();
    _questionKeys = List.generate(widget.questions.length, (index) => GlobalKey());
  }

  void _scrollToQuestion(int index) {
    final context = _questionKeys[index].currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl, // عشان العربي
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppPalette.textLight,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            "النتائج",
            style: TextStyle(
              color: AppPalette.textBlack,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: AppPalette.textBlack),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body:

        Column(
          children: [
            // ✅ الدواير فوق وثابتة
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.questions.length,
                    (index) => GestureDetector(
                  onTap: () => _scrollToQuestion(index),
                  child: _buildStepCircle(
                    "${index + 1}",
                    widget.questions[index]["answer"] ==
                        widget.selectedAnswers[index],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 5),

            // ✅ الجزء اللي بيتحرك بس
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: List.generate(
                    widget.questions.length,
                        (index) => _buildQuestionCard(
                      index: index,
                      key: _questionKeys[index],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  // تصميم الدائرة
  Widget _buildStepCircle(String number, bool isCorrect) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isCorrect ? AppPalette.primary : AppPalette.redPrimary,
        shape: BoxShape.circle,
      ),
      child: Text(
        number,
        style: const TextStyle(
          color: AppPalette.textLight,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // كارت السؤال
  Widget _buildQuestionCard({required int index, Key? key}) {
    final question = widget.questions[index];
    final correctAnswer = question["answer"] as int;
    final selected = widget.selectedAnswers[index];

    return Container(
      color: AppPalette.textLight,
      key: key,
      margin: const EdgeInsets.only(bottom: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Row(
            children: [
              SizedBox(height: 7,),

              Image.asset(ImagesManager.mcqP, width: 19, height: 17.25),
              const SizedBox(width: 6),
              const Text("اختيار متعدد",
                  style: TextStyle(fontSize: 14, color: AppPalette.primary)),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            question["question"],
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 10),

          // الإجابات
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: List.generate(
              (question["options"] as List).length,
                  (i) {
                Color color = Colors.grey.shade400; // الافتراضي
                if (i == correctAnswer) {
                  color = AppPalette.primary; // الصح
                } else if (i == selected && selected != correctAnswer) {
                  color = AppPalette.redPrimary; // الغلط اللي المستخدم اختاره
                }

                return _buildAnswerButton(
                  question["options"][i],
                  color,
                );
              },
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  // زرار الإجابة
  Widget _buildAnswerButton(String text, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: AppPalette.textLight,
          padding: const EdgeInsets.symmetric(vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () {},
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
