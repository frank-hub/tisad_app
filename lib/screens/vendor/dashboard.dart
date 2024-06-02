import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tisad_shop_app/screens/vendor/add_products.dart';
import 'package:tisad_shop_app/screens/vendor/orders.dart';
import 'package:tisad_shop_app/theme.dart';
class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
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
                        height: 145,
                        width: 157,
                        child: Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image(image: AssetImage('assets/images/Frame.png')),
                              SizedBox(height: 10,),
                              Text("Add New Products",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
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
                        height: 145,
                        width: 157,
                        child: Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image(image: AssetImage('assets/images/Group.png')),
                              SizedBox(height: 10,),
                              Text("New Orders",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
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
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Container(
                        width: double.infinity,
                        height: 170,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(13.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      children: [
                                        Text("#20211028-07104354",
                                          style: TextStyle(
                                              color: lightColorScheme.primary,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500
                                          ),
                                        ),
                                        Text("2 Nov 2021 04:24 PM",
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Customer Name",
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500
                                          ),
                                        ),
                                        Text("Ankit Gajera",
                                          style: TextStyle(
                                              color: lightColorScheme.primary,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Product Name",
                                          style: TextStyle(
                                              color: lightColorScheme.primary,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500
                                          ),
                                        ),
                                        Text("Pajamas 67",
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'Ksh.',
                                              style: TextStyle(
                                                  color: lightColorScheme.primary,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500
                                              ),
                                            ),
                                            TextSpan(
                                              text: '230.44',
                                              style: TextStyle(
                                                  color: lightColorScheme.primary,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500
                                              ),
                                            )
                                          ]
                                      ),
                                    ),
                                    SizedBox(height: 30,),
                                    Image(image: AssetImage('assets/images/Group.png'),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
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
