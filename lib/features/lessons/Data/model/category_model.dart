class Category {
  final int id;
  final String title;
  final String image;
  final String cover;
  final int status;
  final String content;
  final List<Lesson> lessons;

  Category({
    required this.id,
    required this.title,
    required this.image,
    required this.cover,
    required this.status,
    required this.content,
    required this.lessons,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      cover: json['cover'],
      status: json['status'],
      content: json['content'],
      lessons: (json['lessons'] as List<dynamic>?)
              ?.map((e) => Lesson.fromJson(e))
              .toList() ?? [],
    );
  }
}

class Lesson {
  final int id;
  final String title;
  final String content;
  final int categoryId;
  final String image;
  final int paid;

  Lesson({
    required this.id,
    required this.title,
    required this.content,
    required this.categoryId,
    required this.image,
    required this.paid,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      categoryId: json['category_id'],
      image: json['image'],
      paid: json['paid'] ?? 0,
    );
  }
}
