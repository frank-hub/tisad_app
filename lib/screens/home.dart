

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tisad_shop_app/constants.dart';
import 'package:tisad_shop_app/models/category.dart';
import 'package:tisad_shop_app/screens/cart.dart';
import 'package:tisad_shop_app/screens/explore.dart';
import 'package:tisad_shop_app/screens/stores.dart';
import 'package:tisad_shop_app/screens/product_details.dart';
import 'package:tisad_shop_app/widgets/bottomNav.dart';

import '../models/product.dart';
import '../theme.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  @override
  void initState(){
    super.initState();
    _fetchNew();
    _fetchTrending();
  }

  final List<Category> categories = [
    Category(id: '1', name: 'Electronics', imageUrl: 'https://i0.wp.com/dhuka.co.ke/wp-content/uploads/2023/01/36.jpg?fit=680%2C680&ssl=1'),
    Category(id: '2', name: 'Clothing &\n Fashion', imageUrl: 'https://i.etsystatic.com/13583441/r/il/7d5dd4/2299793038/il_1080xN.2299793038_i1rr.jpg'),
    Category(id: '3', name: 'Home &\n Kitchen', imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS8Y7fLrmwqA81Ombx9hgXiGcgSNGBWgZckam_IIezOQqN-druG6ZdEsEuMv1z1-2Y8Ehk&usqp=CAU'),
    Category(id: '4', name: 'Health &\n Beauty', imageUrl: 'data:image/jpeg;base64,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'),
    Category(id: '5', name: 'Sports &\n Outdoors', imageUrl: 'https://i.etsystatic.com/13583441/r/il/7d5dd4/2299793038/il_1080xN.2299793038_i1rr.jpg'),
    Category(id: '6', name: 'Books &\n Stationery', imageUrl: 'https://i.etsystatic.com/13583441/r/il/7d5dd4/2299793038/il_1080xN.2299793038_i1rr.jpg'),
    Category(id: '7', name: 'Toys &\n Games', imageUrl: 'https://i.etsystatic.com/13583441/r/il/7d5dd4/2299793038/il_1080xN.2299793038_i1rr.jpg'),
    Category(id: '8', name: 'Automotive', imageUrl: 'https://i.etsystatic.com/13583441/r/il/7d5dd4/2299793038/il_1080xN.2299793038_i1rr.jpg'),
    Category(id: '9', name: 'Jewelry &\n Accessories', imageUrl: 'https://i.etsystatic.com/13583441/r/il/7d5dd4/2299793038/il_1080xN.2299793038_i1rr.jpg'),
    Category(id: '10', name: 'Pet Supplies', imageUrl: 'https://m.media-amazon.com/images/I/81h4D2jhVzL._AC_UF1000,1000_QL80_.jpg'),
    Category(id: '11', name: 'Food &\n Beverages', imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSFEfiEmu6p8E4chaAQDLH1FLToq0HRjCxgnQ&usqp=CAU'),
    Category(id: '12', name: 'Arts &\n Crafts', imageUrl: 'https://i.etsystatic.com/13583441/r/il/7d5dd4/2299793038/il_1080xN.2299793038_i1rr.jpg'),
    Category(id: '13', name: 'Baby &\n Maternity', imageUrl: 'https://i.etsystatic.com/13583441/r/il/7d5dd4/2299793038/il_1080xN.2299793038_i1rr.jpg'),
    Category(id: '14', name: 'Electronics \n Accessories', imageUrl: 'https://i.etsystatic.com/13583441/r/il/7d5dd4/2299793038/il_1080xN.2299793038_i1rr.jpg'),
    Category(id: '15', name: 'Office Supplies', imageUrl: 'https://i.etsystatic.com/13583441/r/il/7d5dd4/2299793038/il_1080xN.2299793038_i1rr.jpg'),
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
              Text('Welcome Frankline',style: TextStyle(
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
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const Explore(currentIndex: 2)));
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
                                      image: NetworkImage(category.imageUrl),
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
                              const SizedBox(height: 10,),
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
                              const SizedBox(height: 10,),
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
                                              text: new_products[index].price ?? '',
                                              style: const TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold
                                              )
                                          )
                                        ]
                                    ),
                                  ),
                                  const Icon(Icons.add_shopping_cart_outlined,
                                    size: 21,
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
                            const SizedBox(height: 10,),
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
                                            text: new_products[index].price ?? '',
                                            style: const TextStyle(
                                                fontSize: 17,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold
                                            )
                                        )
                                      ]
                                  ),
                                ),
                                const Icon(Icons.add_shopping_cart_outlined,
                                  size: 21,
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
            ],
          ),
        ),
      ),
    );
  }
}
