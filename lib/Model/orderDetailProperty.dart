class CartItemProperty {
  final String key;
  final String value;

  CartItemProperty({required this.key, required this.value});

  factory CartItemProperty.fromJson(Map<String, dynamic> json) {
    return CartItemProperty(
      key: json['key'] as String,
      value: json['value'] as String,
    );
  }
}