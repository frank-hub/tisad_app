import 'package:flutter/material.dart';

import '../../theme.dart';
class OrderDetails extends StatefulWidget {
  const OrderDetails({super.key});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
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
                    Text("Orders Details",
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
                Container(
                  height: 1,
                  color: Colors.grey.withOpacity(0.4),
                ),
                Text("Order Summary",
                  style: TextStyle(
                      color: lightColorScheme.primary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Order Code:",
                          style: TextStyle(
                              color: lightColorScheme.primary,
                              fontSize: 15,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Text("20211028-04431133",
                          style: TextStyle(
                              color: lightColorScheme.primary,
                              fontSize: 15,
                              // fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Customer:",
                          style: TextStyle(
                              color: lightColorScheme.primary,
                              fontSize: 15,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Text("MOHIN SANDHI",
                          style: TextStyle(
                            color: lightColorScheme.primary,
                            fontSize: 15,
                            // fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Email:",
                          style: TextStyle(
                              color: lightColorScheme.primary,
                              fontSize: 15,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Text("sandhimohin786@gmail.com",
                          style: TextStyle(
                            color: lightColorScheme.primary,
                            fontSize: 15,
                            // fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Shipping Address:",
                          style: TextStyle(
                              color: lightColorScheme.primary,
                              fontSize: 15,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Text("b , Ahmedabad , Gujarat",
                          style: TextStyle(
                            color: lightColorScheme.primary,
                            fontSize: 15,
                            // fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Order date:",
                          style: TextStyle(
                              color: lightColorScheme.primary,
                              fontSize: 15,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Text("28-10-2021 16:10 PM",
                          style: TextStyle(
                            color: lightColorScheme.primary,
                            fontSize: 15,
                            // fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total Amount:",
                          style: TextStyle(
                              color: lightColorScheme.primary,
                              fontSize: 15,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Text("Ksh 90000",
                          style: TextStyle(
                            color: lightColorScheme.primary,
                            fontSize: 15,
                            // fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,)
                  ],
                ),
                InkWell(
                  onTap: (){

                  },
                  child: Container(
                    width: double.infinity,
                    height: 70,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: lightColorScheme.primary
                    ),
                    child: Center(
                      child: Text('Confirm Order',
                        style: TextStyle(
                            color: Colors.white
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25.0,
                ),
              ]
          ),
        ),
      ),
    );
  }
}
