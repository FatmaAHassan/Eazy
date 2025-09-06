class Answer {
  final int id;
  final String title;
  final bool isCorrect;

  Answer({required this.id, required this.title, required this.isCorrect});

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      id: json['id'],
      title: json['title'] ?? "",
      isCorrect: json['is_correct'] == 1,
    );
  }
}

class Question {
  final int id;
  final String title;
  final List<Answer> answers;

  Question({required this.id, required this.title, required this.answers});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      title: json['title'] ?? "",
      answers: (json['answers'] as List)
          .map((e) => Answer.fromJson(e))
          .toList(),
    );
  }
}
