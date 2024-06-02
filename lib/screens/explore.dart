import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tisad_shop_app/constants.dart';
import 'package:tisad_shop_app/models/product.dart';
import 'package:tisad_shop_app/models/vendor.dart';
import 'package:tisad_shop_app/screens/product_details.dart';
import 'package:tisad_shop_app/theme.dart';
import 'package:tisad_shop_app/widgets/bottomNav.dart';
import 'package:http/http.dart' as http;
class Explore extends StatefulWidget {
  final int currentIndex;

  const Explore({Key? key, required this.currentIndex}) : super(key: key);

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  List<Product> product = [];

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    final response = await http.get(Uri.parse('$BaseUrl/product/all_products'));
    debugPrint('worked');

    if (response.statusCode == 200) {

      // Decode the response body into a map
      Map<String, dynamic> responseData = json.decode(response.body);

      // Extract the list of events from the map using the appropriate key
      List<dynamic> productData = responseData['data'];

      setState(() {
        product = productData.map((data) => Product.fromJson(data)).toList();
      });
    } else {
      throw Exception('Failed to load events');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Store',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          ),
        ],
        currentIndex: widget.currentIndex, // Index 2 corresponds to Explore
        selectedItemColor: lightColorScheme.primary,
        unselectedItemColor: Colors.black,
        onTap: (index) {
          // Call the onItemTapped method from BottomNavLogic
          BottomNavLogic.onItemTapped(context, index);
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 25),
              Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: lightColorScheme.primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                        hintText: ' Search products...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.filter_list),
                          onPressed: () {
                            // Handle filter icon tap
                            // You can show a filter dialog or navigate to a filter screen here
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Container(
                height: 900,
                width: double.infinity,
                child: ListView.builder(
                  itemCount:product.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder:
                            (context)=> ProductDetails(currentIndex: 2, p_index: product[index].id.toString(),)
                        ));
                      },
                      child: Card(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          height: 240,
                          width: 270,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 130,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(product[index].image ?? 'Null'),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              SizedBox(height: 10,),
                              Text(product[index].p_name ?? 'Null',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                        children: [
                                          TextSpan(
                                              text: product[index].price ?? '',
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold
                                              )
                                          ),
                                          WidgetSpan(
                                            child: SizedBox(width: 1,)
                                          ),
                                          TextSpan(
                                              text: 'KES',style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.black,
                                          )
                                          ),
                                        ]
                                    ),
                                  ),
                                  Container(
                                    height: 35,
                                    width: 35,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: lightColorScheme.primary,
                                    ),
                                    child: Icon(Icons.add_shopping_cart_outlined,
                                      size: 21,
                                      color: Colors.white,
                                    ),
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

            ],
          ),
        ),
      ),
    );
  }
}
