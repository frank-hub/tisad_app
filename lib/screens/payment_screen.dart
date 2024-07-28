import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:tisad_shop_app/screens/thank_you.dart';
import 'package:tisad_shop_app/screens/vendor/dashboard.dart';
import 'package:tisad_shop_app/theme.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../constants.dart';
import '../providers/cart_provider.dart';

class PaymentScreen extends StatefulWidget {
  String phone;
  PaymentScreen({super.key ,required this.phone});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {

  Future<void> sendOrder(BuildContext context) async {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final orderItems = cartProvider.items.values.map((item) {
      return {
        "product_name": item.product.p_name,
        "quantity": item.quantity,
        "total_price": double.tryParse(item.product.price.toString() ?? '0.0')! * item.quantity,
      };
    }).toList();

    final orderData = {
      "items": orderItems,
      "total_amount": cartProvider.totalAmount,
    };

    final response = await http.post(
      Uri.parse('$BaseUrl/orders'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(orderData),
    );

    if (response.statusCode == 201) {
      // Mpesa Request
      stkPush(cartProvider.totalAmount);
      // Order successfully sent
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Order placed successfully!'),
          duration: Duration(seconds: 2),
        ),
      );

      // Optionally navigate to another screen
    } else {
      // Failed to send order
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.body.toString()),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
  
  Future<void> stkPush(double totalAmount) async{

    final mpesa = {
      "phone": widget.phone,
      "amount": totalAmount,
    };

    final response = await http.post(
      Uri.parse('$BaseUrl/mpesa/stkpush'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(mpesa),
    );
    if(response.statusCode == 200){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Enter Pin"))
      );
      Navigator.push(context, MaterialPageRoute(builder:
          (context)=> ThankYouOrder()
      ));
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Something went wrong"))
      );
    }
  } 


  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Details'),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.red, Colors.blue],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Total Amount Payable',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 5,),
                  Text('Ksh ${NumberFormat('#,##0').format(cartProvider.totalAmount)}',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 400,
                  width: 700,
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
                    ],
                  ),
                ),
                const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: (){
                      sendOrder(context);
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.green.withOpacity(0.8),
                              lightColorScheme.primary,
                            ],
                            // radius: 2.8,
                            stops: [0.2, 1.0],
                            // center: Alignment.center,
                          ),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: const Center(
                        child: Text("CONFIRM",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )

          ],
        ),
      ),
    );
  }
}
