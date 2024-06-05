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
              Navigator.push(context, MaterialPageRoute(builder:
                  (context)=> CartScreen()
              ));
              },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: const Color(0xffEEEEEE),
                  border: Border.all(width: 0.1, color: Colors.black.withOpacity(0.8)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      width: 80,
                      child: const Text("MODEL"),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      width: 75,
                      child: const Text("QUANTITY"),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text("UNIT\nPRICE"),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text("TOTAL"),
                    ),
                  ],
                ),
              ),
              Column(
                children: cartProvider.items.values.map((item) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(width: 0.1, color: Colors.black.withOpacity(0.8)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          width: 80,
                          child: Text(item.product.p_name ?? ''),
                        ),
                        Container(
                          width: 70,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(width: 0.8, color: Colors.black.withOpacity(0.8)),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 20,
                                      height: 30,
                                      child: TextField(
                                        readOnly: true,
                                        controller: TextEditingController(text: item.quantity.toString()),
                                        keyboardType: TextInputType.number,
                                        onSubmitted: (value) {
                                          final newQuantity = int.tryParse(value) ?? 1;
                                          cartProvider.updateQuantity(item.product, newQuantity);
                                        },
                                      ),
                                    ),
                                    Container(
                                      color: Colors.grey,
                                      child: Column(
                                        children: [
                                          IconButton(
                                            icon: const Icon(Icons.keyboard_arrow_up, size: 15),
                                            onPressed: () {
                                              cartProvider.updateQuantity(item.product, item.quantity + 1);
                                            },
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.keyboard_arrow_down, size: 15),
                                            onPressed: () {
                                              cartProvider.updateQuantity(item.product, item.quantity - 1);
                                            },
                                          ),
                                        ],
                                      ),
                                    ),

                                    // Container(
                                    //   width: 30,
                                    //   height: 30,
                                    //   color: Colors.red,
                                    //   child: Center(
                                    //     child: IconButton(
                                    //       icon: const Icon(Icons.delete_forever, color: Colors.white, size: 18),
                                    //       onPressed: () {
                                    //         cartProvider.removeItem(item.product.id ?? 0);
                                    //       },
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            double.tryParse(item.product.price ?? '')?.toStringAsFixed(2) ?? '0.00',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            (double.tryParse(item.product.price ?? '')! * item.quantity).toStringAsFixed(2),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 50),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: const BoxDecoration(color: Color(0xffEEEEEE)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      height: 45,
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text(
                            "Total:",
                            style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                          ),
                          Container(
                            width: 65,
                            padding: const EdgeInsets.only(right: 10, left: 10),
                            child: Text(cartProvider.totalAmount.toStringAsFixed(2)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      height: 1,
                      width: double.infinity,
                      color: Colors.red.withOpacity(0.2),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      color: Colors.grey,
                      height: 45,
                      child: Center(
                        child: RichText(
                          text: const TextSpan(
                            children: [
                              WidgetSpan(
                                child: Icon(CupertinoIcons.left_chevron, size: 18, color: Colors.white70),
                              ),
                              WidgetSpan(
                                child: SizedBox(width: 10),
                              ),
                              TextSpan(
                                text: 'CONTINUE SHOPPING',
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ShippingAddress()),
                        );
                      },
                      child: Container(
                        color: Colors.green,
                        height: 45,
                        child: Center(
                          child: RichText(
                            text: const TextSpan(
                              children: [
                                WidgetSpan(
                                  child: Icon(Icons.exit_to_app, size: 18, color: Colors.white70),
                                ),
                                WidgetSpan(
                                  child: SizedBox(width: 10),
                                ),
                                TextSpan(
                                  text: 'CHECKOUT',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
