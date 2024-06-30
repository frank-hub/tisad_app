import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tisad_shop_app/screens/vendor/order_details.dart';
import 'package:http/http.dart' as http;
import '../../../constants.dart';
import '../../../models/product.dart';
import '../../../theme.dart';

class InventoryList extends StatefulWidget {
  const InventoryList({super.key});

  @override
  State<InventoryList> createState() => _InventoryListState();
}

class _InventoryListState extends State<InventoryList> {
  List<Product> products = [];

  Future<void> _fetchInventory() async{
    final response = await http.get(Uri.parse('$BaseUrl/product/new'));

    if(response.statusCode == 200)
    {
      Map<String,dynamic> resData = json.decode(response.body);
      List<dynamic> productData = resData['data'];

      setState(() {
        products = productData.map((data) => Product.fromJson(data)).toList();
      });
    }

  }
  @override
  void initState(){
    super.initState();
    _fetchInventory();
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
                    itemCount:products.length,
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
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Ref #"+products[index].id.toString() ?? '' ,
                                            style: TextStyle(
                                                color: lightColorScheme.primary,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500
                                            ),
                                          ),
                                          Text(products[index].date ?? '',
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
                                          Text("Category Name",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500
                                            ),
                                          ),
                                          Text(products[index].category_id ?? '',
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
                                          Text(products[index].p_name ?? '',
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
                                                text: products[index].price ?? '',
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
                                      ),

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
