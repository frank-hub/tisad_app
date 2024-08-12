import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tisad_shop_app/screens/home.dart';
import 'package:tisad_shop_app/screens/vendor/add_products.dart';
import 'package:tisad_shop_app/screens/vendor/inventory/inventoryList.dart';
import 'package:tisad_shop_app/screens/vendor/order_details.dart';
import 'package:tisad_shop_app/screens/vendor/orders.dart';
import 'package:tisad_shop_app/theme.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../constants.dart';
import '../../models/order.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late Future<List<Order>> _orderHistory;
  int totalOrders = 0;
  int totalProducts = 0;

  @override
  void initState() {
    super.initState();
    _orderHistory = fetchOrderHistory();
    // Example for fetching total orders and products, replace with your own logic
    fetchTotalOrders();
    fetchTotalProducts();
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

  Future<void> fetchTotalOrders() async{
    final response = await http.get(Uri.parse('$BaseUrl/order/count'));

    if(response.statusCode == 200){
      var orderCount = json.decode(response.body);
      setState(() {
        totalOrders = orderCount['count']; // Example value, replace with actual data fetching
      });
    }else{
      setState(() {
        totalOrders = 0; // Example value, replace with actual data fetching
      });
    }

  }

  Future<void> fetchTotalProducts() async{
    final response = await http.get(Uri.parse('$BaseUrl/product/count'));

    if(response.statusCode == 200){
      var productCount =  jsonDecode(response.body);
      setState(() {
        totalProducts =productCount['count'];
      });
    }else{
      setState(() {
        totalProducts = 0;
      });
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "MY DASHBOARD",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: lightColorScheme.primary,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.home, color: lightColorScheme.primary),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context)=> const HomeScreen(currentIndex: 0)
                          ));
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.notifications_active, color: lightColorScheme.primary),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(height: 15),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 1,
                      color: Colors.grey.withOpacity(0.8)
                  ),
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Total Orders',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5),
                        Text(
                          totalOrders.toString(),
                          style: TextStyle(fontSize: 16, color: lightColorScheme.primary),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Total Products',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5),
                        Text(
                          totalProducts.toString(),
                          style: TextStyle(fontSize: 16, color: lightColorScheme.primary),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddProduct()),
                      );
                    },
                    child: Container(
                      height: 105,
                      width: 117,
                      child: Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(image: AssetImage('assets/images/Frame.png')),
                            SizedBox(height: 10),
                            Text(
                              "Add New Products",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: lightColorScheme.primary,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AllOrders()),
                      );
                    },
                    child: Container(
                      height: 105,
                      width: 117,
                      child: Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(image: AssetImage('assets/images/Group.png')),
                            SizedBox(height: 10),
                            Text(
                              "New Orders",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: lightColorScheme.primary,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => InventoryList()),
                      );
                    },
                    child: Container(
                      height: 105,
                      width: 117,
                      child: Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(image: AssetImage('assets/images/checklists.png')),
                            SizedBox(height: 10),
                            Text(
                              "Inventory",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: lightColorScheme.primary,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                "New Orders",
                style: TextStyle(
                  color: lightColorScheme.primary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
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

                          String StringAmount =  order.totalAmount ?? '0';
                          double IntAmount = double.parse(StringAmount);
                          String totalAmount = NumberFormat('#,##0').format(IntAmount);


                          String StringPrice =  order.totalAmount ?? '0';
                          double IntPrice = double.parse(StringAmount);
                          String totalPrice = NumberFormat('#,##0').format(IntAmount);

                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OrderDetails(),
                                ),
                              );
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
                                          children: [
                                            Text(
                                              'Ref:#${order.id.toString()}',
                                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              'Total: KES $totalAmount',
                                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                        ...order.items.map((item) => Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 5),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(item.productName, style: TextStyle(fontSize: 15)),
                                              Text('Qty: ${item.quantity}', style: TextStyle(fontSize: 15)),
                                              Text('KES $totalPrice', style: TextStyle(fontSize: 15)),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
