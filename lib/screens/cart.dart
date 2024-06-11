import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tisad_shop_app/screens/shipping_address.dart';
import '../providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Shopping Cart"),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const CartScreen()));
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Cart Items List
            Expanded(
              child: ListView.builder(
                itemCount: cartProvider.items.length,
                itemBuilder: (context, index) {
                  var item = cartProvider.items.values.toList()[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Product Name

                          SizedBox(
                            width: 100,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item.product.p_name ?? '', style: TextStyle(fontSize: 15)),
                                Text(
                                  'Ksh ${double.tryParse(item.product.price ?? '')?.toStringAsFixed(2) ?? '0.00'}',
                                  style: TextStyle(fontSize: 13,color: Colors.grey.withOpacity(0.5)),
                                ),
                              ],
                            ),
                          ),
                          // Quantity Selector
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () {
                                  cartProvider.updateQuantity(item.product, item.quantity - 1);
                                },
                              ),
                              SizedBox(
                                width: 13,
                                child: Center(
                                  child: Text(item.quantity.toString(), style: TextStyle(fontSize: 16)),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {
                                  cartProvider.updateQuantity(item.product, item.quantity + 1);
                                },
                              ),
                            ],
                          ),
                          // Unit Price

                          // Total Price
                          Text(
                            'Ksh ${(double.tryParse(item.product.price ?? '')! * item.quantity).toStringAsFixed(2)}',
                            style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                          ),
                          // Remove Item Button
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              cartProvider.removeItem(item.product.id ?? 0);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            // Total and Checkout
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: const Color(0xffEEEEEE),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total:",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '\$${cartProvider.totalAmount.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(CupertinoIcons.left_chevron, size: 18, color: Colors.white70),
                              SizedBox(width: 10),
                              Text('CONTINUE SHOPPING', style: TextStyle(fontSize: 10)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ShippingAddress()),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.exit_to_app, size: 18, color: Colors.white70),
                              SizedBox(width: 10),
                              Text('CHECKOUT', style: TextStyle(fontSize: 10)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
