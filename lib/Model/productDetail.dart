import 'category.dart';
import 'picture.dart';

class ProductDetail {
  final int id;
  final String title;
  final String description;
  final Category category;
  final String price;
  final int? discountPercent;
  final String? discountPrice;
  final int quantity;
  final num stars;
  final int reviewQuantity;
  final List<Picture> pictures;
  final Map<String, dynamic> properties;

  ProductDetail({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.discountPercent,
    required this.discountPrice,
    required this.quantity,
    required this.stars,
    required this.reviewQuantity,
    required this.pictures,
    required this.properties,
  });

  factory ProductDetail.fromJson(Map<String, dynamic> json) {
    return ProductDetail(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      category: Category.fromJson(json["category"]),
      price: json["price"],
      discountPercent: json["discount_percent"],
      discountPrice: json["discount_price"],
      quantity: json["quantity"],
      stars: json["stars"],
      reviewQuantity: json["review_quantity"],
      pictures: (json["pictures"] as List)
          .map((e) => Picture.fromJson(e))
          .toList(),
      properties: json["properties"],
    );
  }
}