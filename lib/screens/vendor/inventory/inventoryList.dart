import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tisad_shop_app/screens/vendor/order_details.dart';

import '../../../theme.dart';
class InventoryList extends StatefulWidget {
  const InventoryList({super.key});

  @override
  State<InventoryList> createState() => _InventoryListState();
}

class _InventoryListState extends State<InventoryList> {
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
                    Text("All Products",
                      style: TextStyle(
                          color: lightColorScheme.primary,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
                SingleChildScrollView(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 20,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder:
                              (context)=> OrderDetails()
                          ));
                        },
                        child: Container(
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
