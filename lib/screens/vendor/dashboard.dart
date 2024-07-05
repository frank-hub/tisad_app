import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tisad_shop_app/screens/vendor/add_products.dart';
import 'package:tisad_shop_app/screens/vendor/inventory/inventoryList.dart';
import 'package:tisad_shop_app/screens/vendor/order_details.dart';
import 'package:tisad_shop_app/screens/vendor/orders.dart';
import 'package:tisad_shop_app/theme.dart';
import 'package:http/http.dart' as http;

import '../../constants.dart';
import '../../models/order.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
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
        child:Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("MY DASHBOARD",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        color: lightColorScheme.primary,
                      ),
                    ),
                    IconButton(
                      icon:Icon(Icons.notifications_active, color: lightColorScheme.primary),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder:
                        (context)=> AddProduct()
                        ));
                      },
                      child: Container(
                        height:105,
                        width: 117,
                        child: Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image(image: AssetImage('assets/images/Frame.png')),
                              SizedBox(height: 10,),
                              Text("Add New Products",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: lightColorScheme.primary
                              ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder:
                            (context)=> AllOrders()
                        ));
                      },
                      child: Container(
                        height: 105,
                        width: 117,
                        child: Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image(image: AssetImage('assets/images/Group.png')),
                              SizedBox(height: 10,),
                              Text("New Orders",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: lightColorScheme.primary
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder:
                            (context)=> InventoryList()
                        ));
                      },
                      child: Container(
                        height: 105,
                        width: 117,
                        child: Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image(image: AssetImage('assets/images/checklists.png')),
                              SizedBox(height: 10,),
                              Text("Inventory",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: lightColorScheme.primary
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
                SizedBox(height: 20,),
                Text("New Order",
                  style: TextStyle(
                      color: lightColorScheme.primary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  height: 900,
                  child:FutureBuilder<List<Order>>(
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
                            return InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context)=> OrderDetails()
                                ));
                              },
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Row(

                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children:[
                                              Text(
                                                'Ref:#${order.id.toString()}',
                                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                              ),
                                              Text(
                                                'Total: KES ${order.totalAmount}',
                                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                              )
                                            ]
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
                                    ],
                                  ),
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
