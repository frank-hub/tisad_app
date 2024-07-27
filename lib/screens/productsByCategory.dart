// explore.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tisad_shop_app/constants.dart';
import 'package:tisad_shop_app/providers/cart_provider.dart';
import 'package:tisad_shop_app/screens/cart.dart';
import '../models/product.dart';
import '../theme.dart';
import '../widgets/bottomNav.dart';
import 'product_details.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
class ProductsCategory extends StatefulWidget {
  final String category;

  const ProductsCategory({Key? key, required this.category}) : super(key: key);

  @override
  State<ProductsCategory> createState() => _ProductsCategoryState();
}

class _ProductsCategoryState extends State<ProductsCategory> {
  List<Product> product = [];

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    final response = await http.get(Uri.parse('$BaseUrl/product/${widget.category}'));

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = json.decode(response.body);
      List<dynamic> productData = responseData['data'];

      setState(() {
        product = productData.map((data) => Product.fromJson(data)).toList();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('No Products On This Category'),
          backgroundColor: lightColorScheme.primary,
        ),

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
        currentIndex: 2,
        selectedItemColor: lightColorScheme.primary,
        unselectedItemColor: Colors.black,
        onTap: (index) {
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
                  SizedBox(width: 5),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        hintText: 'Search products...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.filter_list),
                          onPressed: () {
                            // Handle filter icon tap
                          },
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.shopping_cart, color: lightColorScheme.primary),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder:
                          (context)=> CartScreen()
                      ));
                    },
                  )
                ],
              ),
              SizedBox(height: 20),
              SingleChildScrollView(
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: product.length,
                  itemBuilder: (context, index) {
                    String StringPrice = product[index].price.toString() ?? '0';
                    int IntPrice = int.parse(StringPrice);
                    String price  = NumberFormat('#,##0').format(IntPrice);
                    return InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetails(currentIndex: 2, p_index: product[index].id.toString())));
                      },
                      child: Card(
                        child: Container(
                          padding: EdgeInsets.all(9),
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
                              SizedBox(height: 10),
                              Text(product[index].p_name.toString() ?? 'Null',
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                              Text(product[index].category_id ?? 'Null',
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey.withOpacity(0.8)
                                ),
                              ),
                              SizedBox(height: 3),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text:price,
                                          style: TextStyle(fontSize: 17, color: Colors.black, fontWeight: FontWeight.bold),
                                        ),
                                        WidgetSpan(
                                          child: SizedBox(width: 1),
                                        ),
                                        TextSpan(
                                          text: 'KES',
                                          style: TextStyle(fontSize: 10, color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Provider.of<CartProvider>(context, listen: false).addItem(product[index]);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('${product[index].p_name} added to cart'),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      height: 35,
                                      width: 35,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: lightColorScheme.primary,
                                      ),
                                      child: Icon(
                                        Icons.add_shopping_cart_outlined,
                                        size: 21,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
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
