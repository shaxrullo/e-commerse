class CartItemPicture {
  final String file;
  final bool asMain;

  CartItemPicture({required this.file, required this.asMain});

  factory CartItemPicture.fromJson(Map<String, dynamic> json) {
    return CartItemPicture(
      file: json['file'] as String,
      asMain: json['as_main'] as bool,
    );
  }
}
