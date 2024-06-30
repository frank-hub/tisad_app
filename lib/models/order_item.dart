// models/order_item.dart
class OrderItem {
  final String productName;
  final int quantity;
  final String totalPrice;

  OrderItem({required this.productName, required this.quantity, required this.totalPrice});

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      productName: json['product_name'],
      quantity: json['quantity'],
      totalPrice: json['total_price'],
    );
  }
}

