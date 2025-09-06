class SliderItem {
  final int id;
  final String image;

  SliderItem({required this.id, required this.image});

  factory SliderItem.fromJson(Map<String, dynamic> json) {
    return SliderItem(
      id: json['id'],
      image: json['image'] ?? "",
    );
  }
}

class CategoryItem {
  final int id;
  final String title;
  final String image;
  final String cover;

  CategoryItem({
    required this.id,
    required this.title,
    required this.image,
    required this.cover,
  });

  factory CategoryItem.fromJson(Map<String, dynamic> json) {
    return CategoryItem(
      id: json['id'],
      title: json['title'] ?? "",
      image: json['image'] ?? "",
      cover: json['cover'] ?? "",
    );
  }
}

class HomeData {
  final List<SliderItem> sliders;
  final List<CategoryItem> categories;

  HomeData({required this.sliders, required this.categories});

  factory HomeData.fromJson(Map<String, dynamic> json) {
    return HomeData(
      sliders: (json['slider'] as List)
          .map((e) => SliderItem.fromJson(e))
          .toList(),
      categories: (json['categories'] as List)
          .map((e) => CategoryItem.fromJson(e))
          .toList(),
    );
  }
}
