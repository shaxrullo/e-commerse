import 'package:e_commerce/Model/orderDetail.dart';

class OrderRetrieve {
  final int id;
  final String? company;
  final String streetAddress;
  final String? apartment;
  final String city;
  final String phone;
  final String email;
  final String payingAmount;
  final String paymentType;
  final int? coupon;
  final bool? saveData;
  final DateTime? datetime;
  final List<OrderDetail> details;
 
  OrderRetrieve({
    required this.id,
    this.company,
    required this.streetAddress,
    this.apartment,
    required this.city,
    required this.phone,
    required this.email,
    required this.payingAmount,
    required this.paymentType,
    this.coupon,
    this.saveData,
    this.datetime,
    required this.details,
  });
 
  factory OrderRetrieve.fromJson(Map<String, dynamic> json) {
    return OrderRetrieve(
      id: json['id'] as int,
      company: json['company'] as String?,
      streetAddress: json['street_address'] as String,
      apartment: json['apartment'] as String?,
      city: json['city'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String,
      payingAmount: json['paying_amount'] as String,
      paymentType: json['payment_type'] as String,
      coupon: json['coupon'] as int?,
      saveData: json['save_data'] as bool?,
      datetime: json['datetime'] != null
          ? DateTime.tryParse(json['datetime'] as String)
          : null,
      details: (json['details'] as List<dynamic>? ?? [])
          .map((e) => OrderDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}