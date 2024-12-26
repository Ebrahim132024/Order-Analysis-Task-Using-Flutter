class Order {
  final dynamic id;
  final dynamic isActive;
  final String price;
  final dynamic company;
  final dynamic buyer;
  final dynamic status;
  final dynamic registered;

  Order({
    required this.id,
    required this.isActive,
    required this.price,
    required this.company,
    required this.buyer,
    required this.status,
    required this.registered,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      isActive: json['isActive'],
      price: json['price'].replaceAll(RegExp(r'[^\d.]'), ''),
      company: json['company'],
      buyer: json['buyer'],
      status: json['status'],
      registered: DateTime.parse(json['registered']),
    );
  }
}

class OrderData {
  final String month;
  final int orderCount;

  OrderData(this.month, this.orderCount);
}