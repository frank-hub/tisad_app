import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tisad_shop_app/constants.dart';
import 'package:tisad_shop_app/models/category.dart';
import 'package:tisad_shop_app/screens/barcode_screen.dart';
import 'package:tisad_shop_app/screens/cart.dart';
import 'package:tisad_shop_app/screens/explore.dart';
import 'package:tisad_shop_app/screens/product_details.dart';
import 'package:tisad_shop_app/screens/productsByCategory.dart';
import 'package:tisad_shop_app/widgets/bottomNav.dart';

import '../models/product.dart';
import '../providers/cart_provider.dart';
import '../theme.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  final int currentIndex;

  const HomeScreen({Key? key, required this.currentIndex}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  List<Product> new_products = [];
  List<Product> trend_product = [];
  List<dynamic> trendData =[];
  String userName = '';

  @override
  void initState(){
    super.initState();
    _fetchNew();
    _fetchTrending();
    fetchUser();

  }

  Future<void> fetchUser() async {
    // Fetch user details from your API using the authentication token
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final url = Uri.parse('$BaseUrl/user');
    final response = await http.get(
        url,
        headers: {'Authorization': 'Bearer $token'}
    );

    if (response.statusCode == 200) {
      var userData = json.decode(response.body);
      setState(() {
        userName = userData['name'];
      });

    } else {
      userName = 'Please Login';
    }
  }

  final List<Category> categories = [
    Category(id: '1', name: 'Electronics', imageUrl: 'assets/images/category/electronics.jpg'),
    Category(id: '2', name: 'Clothing &\n Fashion', imageUrl: 'assets/images/category/Tisad clothing.jpg'),
    Category(id: '3', name: 'Home &\n Kitchen', imageUrl: 'assets/images/category/Tisad kitchen.jpg'),
    Category(id: '4', name: 'Health &\n Beauty', imageUrl: 'assets/images/category/Tisad beauty.jpg'),
    Category(id: '5', name: 'Sports &\n Outdoors', imageUrl: 'assets/images/category/Tisad fitness.jpg'),
    Category(id: '6', name: 'Books &\n Stationery', imageUrl: 'assets/images/category/Tisad books.jpg'),
    Category(id: '7', name: 'Toys &\n Games', imageUrl: 'assets/images/category/Tisad Toys.jpg'),
    Category(id: '8', name: 'Automotive', imageUrl: 'assets/images/category/Tisad automotive.jpg'),
    Category(id: '9', name: 'Jewelry &\n Accessories', imageUrl: 'assets/images/category/Tisad jewelry.jpg'),
    Category(id: '10', name: 'Pet Supplies', imageUrl: 'assets/images/category/Tisad pet supplies.jpg'),
    Category(id: '11', name: 'Food &\n Beverages', imageUrl: 'assets/images/category/Tisad Food n Bev.jpg'),
    Category(id: '12', name: 'Arts &\n Crafts', imageUrl: 'assets/images/category/Tisad  Art.jpg'),
    Category(id: '13', name: 'Baby &\n Maternity', imageUrl: 'assets/images/category/Tisad maternity.jpg'),
    Category(id: '15', name: 'Office Supplies', imageUrl: 'assets/images/category/Tisad office.jpg'),
  ];


  Future<void> _fetchNew() async{
    final response = await http.get(Uri.parse('$BaseUrl/product/new'));

    if(response.statusCode == 200)
      {
        Map<String,dynamic> resData = json.decode(response.body);
        List<dynamic> productData = resData['data'];

        setState(() {
          new_products = productData.map((data) => Product.fromJson(data)).toList();
        });
      }

  }

  Future<void> _fetchTrending() async {

    final response = await http.get(Uri.parse('$BaseUrl/product/trending'));

    if(response.statusCode == 200){
      Map<String,dynamic> trendingData =  json.decode(response.body);
      trendData = trendingData['data'];

      setState(() {
        trend_product = trendData.map((data) => Product.fromJson(data)).toList();
      });

    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Something Went Wrong'))
      );
    }
  }
  late final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(
            builder: (context)=> BarcodeScannerScreen()
          ));
        },
        child: const Icon(CupertinoIcons.barcode),
      ),
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
          currentIndex: widget.currentIndex,
          selectedItemColor: lightColorScheme.primary,
          unselectedItemColor: Colors.black,
          onTap: (index) {
            // Call the onItemTapped method from BottomNavLogic
            BottomNavLogic.onItemTapped(context, index);
          },
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 20,left: 20,right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        width: 200,
                        child: const Text('EXPLORE SHOPS',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900
                        ),
                        )),
                    IconButton(
                      icon: const Icon(Icons.shopping_cart, color: Colors.black),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder:
                            (context)=> const CartScreen()
                        ));
                      },
                    ),
                  ],
                ),
              ),
              Text('Welcome $userName',style: TextStyle(
                color: Colors.black.withOpacity(0.5)
              ),),
              const SizedBox(height: 10,),
              Container(
                height: 50,
                child: TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: 'Search...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15,),

              Column(
                children: [
                Container(
                height: 120,
                width: double.infinity,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        return GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => ProductsCategory(category: category.name,)

                            ));
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            child: Column(
                              children: [
                                Container(
                                  height: 65,
                                  width: 65,
                                  padding: const EdgeInsets.all(5),
                                  margin: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.grey[200],
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(category.imageUrl),
                                    ),
                                  ),
                                ),
                                Text(category.name)
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              Container(
                height: 1,
                margin: const EdgeInsets.only(bottom: 15),
                width: double.infinity,
                color: Colors.grey.withOpacity(0.2),
              ),
              const Text('New On Tisad',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                ),
              ),
              Container(
                height: 1,
                margin: const EdgeInsets.only(top: 15),
                width: double.infinity,
                color: Colors.grey.withOpacity(0.2),
              ),
              Container(
                height: 250,
                width: double.infinity,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: new_products.length,
                  itemBuilder: (context, index) {

                    // String priceString = new_products[index].price ?? 0.0;
                    // priceString = priceString.replaceAll(',', ''); // Remove commas
                    //
                    // int intPrice = int.parse(priceString);
                    String price = NumberFormat('#,##0').format(new_products[index].price ?? 0.0);

                    return InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder:
                            (context)=> ProductDetails(currentIndex: 2, p_index: new_products[index].id.toString() ?? '',)
                        ));
                      },
                      child: Card(
                        child: Container(
                          padding: const EdgeInsets.all(10),
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
                                    image: NetworkImage(new_products[index].image ?? Loader),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              const SizedBox(height: 5,),
                              Text(new_products[index].p_name ?? 'Null',
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              Text(new_products[index].category_id ?? 'Null',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey.withOpacity(0.8)
                                ),
                              ),
                              const SizedBox(height: 8,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                        children: [
                                          const TextSpan(
                                            text: 'Ksh',
                                            style: TextStyle(
                                              color: Colors.black
                                            )
                                          ),
                                          TextSpan(
                                              text: price ?? '',
                                              style: const TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold
                                              )
                                          )
                                        ]
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Provider.of<CartProvider>(context, listen: false).addItem(new_products[index]);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('${new_products[index].p_name} added to cart'),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 30,
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
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 15,),
              Container(
                height: 1,
                margin: const EdgeInsets.only(bottom: 15),
                width: double.infinity,
                color: Colors.grey.withOpacity(0.2),
              ),
              const Text('Trending now',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                ),
              ),
              Container(
                height: 1,
                margin: const EdgeInsets.only(top: 15),
                width: double.infinity,
                color: Colors.grey.withOpacity(0.2),
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: new_products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (context, index) {
                  // String stringPrice = new_products[index].price ?? '0';
                  // stringPrice = stringPrice.replaceAll(',', ''); // Remove commas
                  // int intPrice = int.parse(stringPrice);
                  String trendPrice = NumberFormat('#,##0').format(new_products[index].price ?? 0.0);

                  return InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder:
                          (context)=> ProductDetails(currentIndex: 2, p_index: new_products[index].id.toString() ?? '',)
                      ));
                    },
                    child: Card(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        height: 240,
                        width: 290,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 130,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(new_products[index].image ?? Loader),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            const SizedBox(height: 9,),
                            Text(new_products[index].p_name ?? 'Null',
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            Text(new_products[index].category_id ?? 'Null',
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey.withOpacity(0.8)
                              ),
                            ),
                            const SizedBox(height: 5,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RichText(
                                  text: TextSpan(
                                      children: [
                                        const TextSpan(
                                            text: 'Ksh',
                                            style: TextStyle(
                                                color: Colors.black
                                            )
                                        ),
                                        TextSpan(
                                            text: trendPrice ?? '',
                                            style: const TextStyle(
                                                fontSize: 17,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold
                                            )
                                        )
                                      ]
                                  ),
                                ),

                                InkWell(
                                  onTap: () {
                                    Provider.of<CartProvider>(context, listen: false).addItem(new_products[index]);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('${new_products[index].p_name} added to cart'),
                                        duration: Duration(seconds: 2),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 30,
                                    width: 30,
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
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
