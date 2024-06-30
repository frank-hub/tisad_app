
import 'package:tisad_shop_app/models/order_item.dart';

class Order {
  final List<OrderItem> items;
  final String totalAmount;

  Order({required this.items, required this.totalAmount});

  factory Order.fromJson(Map<String, dynamic> json) {
    var itemsJson = json['items'] as List;
    List<OrderItem> itemsList = itemsJson.map((i) => OrderItem.fromJson(i)).toList();

    return Order(
      items: itemsList,
      totalAmount: json['total_amount'],
    );
  }
}