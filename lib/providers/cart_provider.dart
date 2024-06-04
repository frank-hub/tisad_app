// cart_provider.dart
import 'package:flutter/material.dart';
import 'package:tisad_shop_app/models/cartItem.dart';
import 'package:tisad_shop_app/models/product.dart';

class CartProvider with ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => {..._items};

  void addItem(Product product) {
    if (_items.containsKey(product.id.toString())) {
      _items[product.id.toString()]!.quantity += 1;
    } else {
      _items[product.id.toString()] = CartItem(product: product);
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void updateQuantity(Product product, int quantity) {
    if (_items.containsKey(product.id.toString())) {
      if (quantity > 0) {
        _items[product.id.toString()]!.quantity = quantity;
      } else {
        _items.remove(product.id.toString());
      }
    }
    notifyListeners();
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      total += (double.tryParse(cartItem.product.price ?? '0.0' ) ?? 0.0) * cartItem.quantity;
    });
    return total;
  }
}
