import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tisad_shop_app/screens/cart.dart';
import 'package:tisad_shop_app/widgets/bottomNav.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';
import '../theme.dart';

class ProductDetails extends StatefulWidget {
  final int currentIndex;
  final String p_index;
  const ProductDetails({super.key,required this.currentIndex,required this.p_index});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {

late Product product = Product();

  @override
  void initState() {
    super.initState();
    _fetchProductDetails();
    print(widget.p_index);
  }

  Future<void> _fetchProductDetails() async{
    try{
      final response = await http.get(Uri.parse('$BaseUrl/product/details/${widget.p_index}'));

      if(response.statusCode == 200){

        Map<String,dynamic> resData = json.decode(response.body);

        Map<String,dynamic> tisad = resData['data'];
        setState(() {
          product = Product.fromJson(tisad);
        });
      }
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Something went wrong'))
      );
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
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  const Text("Product Details",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.shopping_cart, color: Colors.black),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder:
                          (context)=> CartScreen()
                      ));
                      },
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              Text(product.p_name ?? 'Null',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  color: lightColorScheme.primary
                ),
              ),
              Container(
                height: 230,
                width: double.infinity,
                decoration:  BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: NetworkImage(product.image ?? Loader),
                    fit: BoxFit.cover,
                  )
                ),
              ),
              const SizedBox(height: 20,),
              Padding(padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                          children: [
                            TextSpan(
                                text: 'KSH ',
                                style: TextStyle(
                                    color: lightColorScheme.primary,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold
                                )
                            ),
                            TextSpan(
                                text: product.price.toString() ?? '0.0',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold
                                )
                            )
                          ]
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Text(product.description ?? ''),
                    SizedBox(height: 10,),
                    Card(
                      child: Container(
                        height: 150,
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text('Stock :',
                                  style: TextStyle(
                                    color: lightColorScheme.primary,
                                    fontSize: 15
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Text(product.availability ?? '',
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Text('Brand :',
                                  style: TextStyle(
                                    color: lightColorScheme.primary,
                                    fontSize: 15
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Text(product.brand ?? '',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Text('Model :',
                                  style: TextStyle(
                                    color: lightColorScheme.primary,
                                    fontSize: 15
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Text(product.model ?? '',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Text('Category :',
                                  style: TextStyle(
                                      color: lightColorScheme.primary,
                                      fontSize: 15
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Text(product.category_id ?? '',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 60,),
              InkWell(
                onTap: (){
                  Provider.of<CartProvider>(context, listen: false).addItem(product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text( '${product.p_name!} added to cart'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                child: Container(
                  height: 50,
                  padding: EdgeInsets.symmetric(horizontal:10),
                  decoration: BoxDecoration(
                    color: lightColorScheme.primary,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Center(
                    child: RichText(
                      text: const TextSpan(
                        children: [
                          WidgetSpan(
                            child: Icon(Icons.shopping_cart,size: 19,color: Colors.white,)
                          ),
                          WidgetSpan(
                            child: SizedBox(width: 15,)
                          ),
                          TextSpan(
                            text: 'Add',
                            style: TextStyle(
                              fontSize: 19
                            )
                          )
                        ]
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
