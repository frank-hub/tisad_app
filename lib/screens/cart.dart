import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../theme.dart';
import '../widgets/bottomNav.dart';
import 'shipping_address.dart';
import 'package:intl/intl.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Shopping Cart"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Store',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          ),
        ],
        currentIndex: 2,
        selectedItemColor: lightColorScheme.primary,
        unselectedItemColor: Colors.black,
        onTap: (index) {
          // Call the onItemTapped method from BottomNavLogic
          BottomNavLogic.onItemTapped(context, index);
        },
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
                  String sPrice = item.product.price.toString() ?? '0';
                  String price = NumberFormat('#,##0').format(item.product.price ?? 0);

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 100,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item.product.p_name ?? '', style: TextStyle(fontSize: 15)),
                                Text(
                                  'Ksh ${price ?? '0.00'}',
                                  style: TextStyle(fontSize: 13, color: Colors.grey.withOpacity(0.5)),
                                ),
                              ],
                            ),
                          ),
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
                          Text(
                            'Ksh ${NumberFormat('#,##0').format((double.tryParse(sPrice)!  * item.quantity))}',
                            style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                          ),
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
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
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
                        'Ksh${NumberFormat('#,##0').format(cartProvider.totalAmount)}',
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
                            // Navigator.push(context,
                            //     MaterialPageRoute(builder: (context)=>const ShippingAddress())
                            // );
                            // hhhhhh
                            if (cartProvider.totalAmount != 0.00) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const ShippingAddress()),
                              );
                            } else {
                              // Handle the case where the amount is 0.00 (e.g., show an alert)
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Alert'),
                                    content: Text('No Items In Cart'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('OK'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
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
