class Category {
  final String? categoryID;
  final String? category_name;

  Category({
    this.categoryID,
    this.category_name,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      categoryID: json['categoryID'],
      category_name: json['category_name'],
    );
  }
}
