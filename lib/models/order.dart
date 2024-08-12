import 'order_item.dart';

class Order {
  final int id;
  final String customerId;
  final String phone;
  final String totalAmount;
  final String status;
  final String createdAt;
  final List<OrderItem> items;

  Order({
    required this.id,
    required this.customerId,
    required this.phone,
    required this.totalAmount,
    required this.status,
    required this.createdAt,
    required this.items,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    var list = json['order_items'] as List<dynamic>?;
    List<OrderItem> itemList = list != null
        ? list.map((i) => OrderItem.fromJson(i)).toList()
        : [];  // Default to an empty list if 'order_items' is null

    return Order(
      id: json['id'],
      customerId: json['customer_id'],
      phone: json['phone'],
      totalAmount: json['total_amount'],
      status: json['status'],
      createdAt: json['created_at'],
      items: itemList,
    );
  }
}
