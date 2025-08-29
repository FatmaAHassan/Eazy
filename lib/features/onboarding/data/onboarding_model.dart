class OnboardingModel {
  final int id;
  final String title;
  final String content;
  final String image;

  OnboardingModel({
    required this.id,
    required this.title,
    required this.content,
    required this.image,
  });

  factory OnboardingModel.fromJson(Map<String, dynamic> json) {
    return OnboardingModel(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      image: json['image'],
    );
  }
}
