class OrderItem {
  final int id;
  final String productName;
  final int quantity;
  final String totalPrice;

  OrderItem({
    required this.id,
    required this.productName,
    required this.quantity,
    required this.totalPrice,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'],
      productName: json['product_name'],
      quantity: json['quantity'],
      totalPrice: json['total_price'],
    );
  }
}