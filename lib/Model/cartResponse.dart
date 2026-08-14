import 'package:e_commerce/Model/cartItem.dart';

class CartResponse {
  final List<CartItem> cartItems;
  final double totalPrice;
  final double discountedTotalPrice;

  CartResponse({
    required this.cartItems,
    required this.totalPrice,
    required this.discountedTotalPrice,
  });

  factory CartResponse.fromJson(Map<String, dynamic> json) {
    return CartResponse(
      cartItems: (json['cart_items'] as List<dynamic>)
          .map((e) => CartItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPrice: (json['total_price'] as num).toDouble(),
      discountedTotalPrice: (json['discounted_total_price'] as num).toDouble(),
    );
  }
}