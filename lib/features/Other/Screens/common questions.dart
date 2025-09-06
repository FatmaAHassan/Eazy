import 'package:eazy/core/config/app_palette.dart';
import 'package:eazy/nav_bar.dart';
import 'package:flutter/material.dart';
import 'Api terms/Terms and Conditions.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> faqs = [
      {
        "question": "كيف أبدأ أول درس في التطبيق؟",
        "answer": "لتبدأ أول درس، اذهب إلى الصفحة الرئيسية واختر المستوى الذي يناسبك، ثم اضغط على الدرس الأول للبدء."
      },
      {
        "question": "هل يمكنني مراجعة الدروس السابقة؟",
        "answer": "نعم، يمكنك العودة إلى أي درس سبق وأنهيته من قائمة الدروس، ومراجعة المحتوى متى شئت."
      },
      {
        "question": "هل هناك اختبارات أو تمارين بعد الدروس؟",
        "answer": "نعم، بعد كل درس ستجد مجموعة من التمارين والأسئلة لاختبار مدى فهمك للمحتوى."
      },
      {
        "question": "هل التطبيق يدعم الصوتيات والنطق الصحيح للكلمات؟",
        "answer": "نعم، كل درس يحتوي على ملفات صوتية لتعليم النطق الصحيح، ويمكنك الاستماع لها أكثر من مرة."
      },
      {
        "question": "كيف يمكنني متابعة تقدمي في التعلم؟",
        "answer": "يمكنك متابعة تقدمك من صفحة الملف الشخصي حيث يظهر لك عدد الدروس المكتملة والمستوى الحالي."
      },
      {
        "question": "هل هناك خطة لتعلم اللغة الإنجليزية بشكل يومي؟",
        "answer": "نعم، التطبيق يقدم توصيات يومية للدروس والتمارين للحفاظ على الاستمرارية والتقدم السريع."
      },
      {
        "question": "هل يمكن استخدام التطبيق بدون الإنترنت؟",
        "answer": "بعض الدروس الأساسية يمكن تحميلها واستخدامها بدون اتصال بالإنترنت، ولكن الميزات الكاملة تتطلب اتصال."
      },
      {
        "question": "كيف يمكنني تغيير إعدادات اللغة أو واجهة التطبيق؟",
        "answer": "يمكنك تغيير اللغة وإعدادات التطبيق من صفحة الملف الشخصي ضمن قسم الإعدادات."
      },
    ];


    return Scaffold(
      backgroundColor: AppPalette.textLight,
      appBar: AppBar(
        backgroundColor: AppPalette.textLight,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          "الأسئلة الشائعة",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppPalette.textBlackLight,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: faqs.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          return _buildFAQItem(
            faqs[index]["question"]!,
            faqs[index]["answer"]!,
          );
        },
      ),
    );
  }

  Widget _buildFAQItem(String question, String answer) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppPalette.textLight,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppPalette.textBlackLight,
            blurRadius: 6,
            spreadRadius: 2,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Theme(
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          collapsedIconColor: AppPalette.textBlack,
          iconColor: AppPalette.textBlack,
          title: Directionality(
            textDirection: TextDirection.rtl,
            child: Text(
              question,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppPalette.primary,
              ),
            ),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Text(
                  answer,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppPalette.textSubtitleLight,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}