import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tisad_shop_app/screens/cart.dart';
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

  String user_id ='';

  @override
  void initState(){
    super.initState();
        fetchUser();
  }
  Future<void> fetchUser() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');

    final url = Uri.parse('$BaseUrl/user');
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'}
    );

    if (response.statusCode == 200) {
      var userData = json.decode(response.body);
      setState(() {
        user_id = userData['id'].toString();
      });

    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please Login To Place An Order'))
      );
    }


  }

  Future<void> sendOrder(BuildContext context) async {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final orderItems = cartProvider.items.values.map((item) {
      return {
        "customer_id": user_id,
        "phone": widget.phone,
        "product_name": item.product.p_name,
        "quantity": item.quantity,
        "total_price": double.tryParse(item.product.price.toString() ?? '0.0')! * item.quantity,
      };
    }).toList();

    final orderData = {
      "items": orderItems,
      "total_amount": cartProvider.totalAmount,
      "customer_id": user_id,
      "phone": widget.phone,
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
      var message = json.decode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Order placed successfully!"+ message['order']['id'].toString()),
          duration: Duration(seconds: 2),
        ),
      );
      Future.delayed(Duration(seconds: 30), () async{
        final res = await http.get(Uri.parse('$BaseUrl/order/payment/confirmation/${message['order']['id']}'));

        if(res.statusCode == 200){
          var trans  = json.decode(res.body);
          if(trans['TransID'].isNotEmpty){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ThankYouOrder()),
            );
          }else{
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('No Payment Received'))
            );
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CartScreen()),
            );
          }
        }else{
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Something went wrong'))
          );

        }

      });
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

      Map<String,dynamic> body = json.decode(response.body);

      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text(body['CheckoutRequestID']))
      // );

      final verify = {
        "checkoutRequestID": body['CheckoutRequestID'],
      };

      final res = await http.post(
        Uri.parse('$BaseUrl/mpesa/verify/payment'),
        headers: {"Content-Type": "application/json"},
        body: json.encode(verify),
      );

      // Navigator.push(context, MaterialPageRoute(builder:
      //     (context)=> ThankYouOrder()
      // ));

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
