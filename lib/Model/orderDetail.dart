import 'package:e_commerce/Model/orderDetailProperty.dart';
import 'package:e_commerce/Model/product.dart';

class OrderDetail {
  final Product product;
  final int quantity;
  final List<CartItemProperty> properties;

  OrderDetail({
    required this.product,
    required this.quantity,
    this.properties = const [],
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) {
    return OrderDetail(
      product: Product.fromJson(json['product'] as Map<String, dynamic>),
      quantity: json['quantity'] as int,
      properties: (json['properties'] as List<dynamic>? ?? [])
          .map((e) => CartItemProperty.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
