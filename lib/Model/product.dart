import 'category.dart';

class Product {
  final int id;
  final String title;
  final String price;
  final int? discountPercent;
  final String discountPrice;
  final int reviewQuantity;
  final num stars;
  final Category category;
  final List<String> pictures;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.discountPercent,
    required this.discountPrice,
    required this.reviewQuantity,
    required this.stars,
    required this.category,
    required this.pictures,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["id"],
      title: json["title"],
      price: json["price"],
      discountPercent: json["discount_percent"],
      discountPrice: json["discount_price"],
      reviewQuantity: json["review_quantity"],
      stars: json["stars"],
      category: Category.fromJson(json["category"]),
      pictures: List<String>.from(json["pictures"]),
    );
  }
}