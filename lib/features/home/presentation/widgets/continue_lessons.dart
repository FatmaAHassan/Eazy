import 'package:eazy/core/config/text_styles_manager.dart';
import 'package:eazy/core/routing/routes.dart';
import 'package:eazy/features/lessons/presentation/screens/lessons.dart';
import 'package:flutter/material.dart';

class ContinueLessonsCard extends StatelessWidget {
  const ContinueLessonsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'الفرق بين {a-an}',
                style: TextStylesManager.bodyMediumLight,
              ),
              Icon(Icons.bookmark, color: Colors.orange),
            ],
          ),
          const SizedBox(height: 4),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, Routes.FirstQuestionScreen);
            },
            child: const Text(
              '4 أسئلة تقييم وتمارين',
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
          ),

          const SizedBox(height: 4),

          // الوقت
          Row(
            children: const [
              Icon(Icons.timer_outlined, size: 14, color: Colors.grey),
              SizedBox(width: 4),
              Text(
                '5 دقائق',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),

          const SizedBox(height: 10),

          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: 0.1,
                    backgroundColor: Colors.grey.shade200,
                    color: Colors.orange,
                    minHeight: 8,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade700,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LessonsScreen(),
                    ),
                  );
                },
                child: Text(
                  'استكمل',
                  style: TextStylesManager.headlineSmallLight,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ContinueLessonsSection extends StatelessWidget {
  const ContinueLessonsSection({Key? key}) : super(key: key);
  // قسم استكمل دروسك الجديد
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('استكمل دروسك', style: TextStylesManager.titleLarge),
        const SizedBox(height: 12),
        const ContinueLessonsCard(),
      ],
    );
  }
}