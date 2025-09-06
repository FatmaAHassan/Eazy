class Lesson {
  final int id;
  final String title;
  final String content;
  final String image;
  final String? audio;
  final List<String> gallery;

  Lesson({
    required this.id,
    required this.title,
    required this.content,
    required this.image,
    this.audio,
    required this.gallery,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      image: json['image'],
      audio: json['audio'],
      gallery: (json['gallery'] as String)
          .split(",")
          .map((e) => e.trim())
          .toList(),
    );
  }
}
