import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tisad_shop_app/screens/vendor/order_details.dart';
import 'package:http/http.dart' as http;
import '../../constants.dart';
import '../../models/order.dart';
import '../../theme.dart';
class AllOrders extends StatefulWidget {
  const AllOrders({super.key});

  @override
  State<AllOrders> createState() => _AllOrdersState();
}

class _AllOrdersState extends State<AllOrders> {
  late Future<List<Order>> _orderHistory;

  @override
  void initState() {
    super.initState();
    _orderHistory = fetchOrderHistory();
  }

  Future<List<Order>> fetchOrderHistory() async {
    final response = await http.get(Uri.parse('$BaseUrl/orders'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((order) => Order.fromJson(order)).toList();
    } else {
      throw Exception('Failed to load order history');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    SizedBox(width: 20,),
                    Text("All Orders",
                      style: TextStyle(
                          color: lightColorScheme.primary,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25.0,
                ),
                SizedBox(height: 10,),
                Container(
                  height: 900,
                  child: FutureBuilder<List<Order>>(
                    future: _orderHistory,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else {
                        final orders = snapshot.data!;
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: orders.length,
                          itemBuilder: (context, index) {
                            var order = orders[index];
                            return Card(
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Total: KES ${order.totalAmount}',
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                    ),
                                    ...order.items.map((item) => Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 5),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(item.productName, style: TextStyle(fontSize: 15)),
                                          Text('Qty: ${item.quantity}', style: TextStyle(fontSize: 15)),
                                          Text('KES ${item.totalPrice}', style: TextStyle(fontSize: 15)),
                                        ],
                                      ),
                                    )),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                )
              ]
          ),
        ),
      ),
    );
  }
}
