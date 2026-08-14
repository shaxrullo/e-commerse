import 'package:e_commerce/Model/CartItemPicture.dart';
import 'package:e_commerce/Model/orderDetailProperty.dart';

class CartItem {
  final int id;
  final String title;
  final double price;
  final double discountPrice;
  final int quantity;
  final double subtotal;
  final List<CartItemPicture> pictures;
  final List<CartItemProperty> properties;
  final int productId;

  CartItem({
    required this.id,
    required this.title,
    required this.price,
    required this.discountPrice,
    required this.quantity,
    required this.subtotal,
    required this.pictures,
    required this.properties,
    required this.productId,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'] as int,
      title: json['title'] as String,
      price: (json['price'] as num).toDouble(),
      discountPrice: (json['discount_price'] as num).toDouble(),
      quantity: json['quantity'] as int,
      subtotal: (json['subtotal'] as num).toDouble(),
      pictures: (json['pictures'] as List<dynamic>)
          .map((e) => CartItemPicture.fromJson(e as Map<String, dynamic>))
          .toList(),
      properties: (json['properties'] as List<dynamic>)
          .map((e) => CartItemProperty.fromJson(e as Map<String, dynamic>))
          .toList(),
      productId: json['product_id'] as int,
    );
  }
}