class Order {
  final String? company;
  final String streetAddress;
  final String? apartment;
  final String city;
  final String phone;
  final String email;
  final String payingAmount;
  final String paymentType;
  final String? couponCode;
  final bool? saveData;
  final List<int> cartItemIds;
 
  Order({
    this.company,
    required this.streetAddress,
    this.apartment,
    required this.city,
    required this.phone,
    required this.email,
    required this.payingAmount,
    required this.paymentType,
    this.couponCode,
    this.saveData,
    required this.cartItemIds,
  });
 
  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      company: json['company'] as String?,
      streetAddress: json['street_address'] as String,
      apartment: json['apartment'] as String?,
      city: json['city'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String,
      payingAmount: json['paying_amount'] as String,
      paymentType: json['payment_type'] as String,
      couponCode: json['coupon_code'] as String?,
      saveData: json['save_data'] as bool?,
      cartItemIds: (json['cart_item_ids'] as List<dynamic>? ?? [])
          .map((e) => e as int)
          .toList(),
    );
  }
 
  // Serverga yuborish uchun (POST body)
  Map<String, dynamic> toJson() => {
        if (company != null) 'company': company,
        'street_address': streetAddress,
        if (apartment != null) 'apartment': apartment,
        'city': city,
        'phone': phone,
        'email': email,
        'paying_amount': payingAmount,
        'payment_type': paymentType,
        if (couponCode != null) 'coupon_code': couponCode,
        if (saveData != null) 'save_data': saveData,
        'cart_item_ids': cartItemIds,
      };
}