class OrderList {
  final int id;
  final int user;
  final String payingAmount;
  final String paymentType;
  final DateTime? datetime;

  OrderList({
    required this.id,
    required this.user,
    required this.payingAmount,
    required this.paymentType,
    this.datetime,
  });

  factory OrderList.fromJson(Map<String, dynamic> json) {
    return OrderList(
      id: json['id'] as int,
      user: json['user'] as int,
      payingAmount: json['paying_amount'] as String,
      paymentType: json['payment_type'] as String,
      datetime: json['datetime'] != null
          ? DateTime.tryParse(json['datetime'] as String)
          : null,
    );
  }
}
