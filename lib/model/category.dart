class Category {
  String? nameCategory;

  Category({
    this.nameCategory,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      nameCategory: json['nameCategory'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nameCategory': nameCategory,
    };
  }
}
