import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tisad_shop_app/constants.dart';
import 'package:tisad_shop_app/models/vendor.dart';
import 'package:tisad_shop_app/screens/explore.dart';
import 'package:tisad_shop_app/screens/product_details.dart';
import 'package:tisad_shop_app/theme.dart';
import 'package:tisad_shop_app/widgets/bottomNav.dart';
import 'package:http/http.dart' as http;
class Stores extends StatefulWidget {
  final int currentIndex;

  const Stores({Key? key, required this.currentIndex}) : super(key: key);

  @override
  State<Stores> createState() => _StoresState();
}

class _StoresState extends State<Stores> {
 List<Vendor> vendor = [];

  @override
  void initState() {
    super.initState();
    fetchVendor();
  }

  Future<void> fetchVendor() async {
    final response = await http.get(Uri.parse('$BaseUrl/vendor/all_vendors'));

    if (response.statusCode == 200) {
      debugPrint('worked');

      // Decode the response body into a map
      Map<String, dynamic> responseData = json.decode(response.body);

      // Extract the list of events from the map using the appropriate key
      List<dynamic> hikeData = responseData['data'];

      setState(() {
        vendor = hikeData.map((data) => Vendor.fromJson(data)).toList();
      });
    } else {
      // throw Exception('Failed to load events');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response.statusCode.toString()))
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
                  itemCount:vendor.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                Explore(currentIndex: 3)
                            ));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 30,
                                width: 30,
                                child: Icon(Icons.storefront,
                                size: 25,
                                ),
                              ),
                              SizedBox(width: 20,),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(vendor[index].b_name ?? 'Business Name',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    Text(vendor[index].type ?? 'Business Type',
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey.withOpacity(0.8)
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(15)
                                ),
                                child: Icon(Icons.remove_red_eye_rounded,
                                  size: 21,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: 1,
                          margin: EdgeInsets.only(top: 15),
                          width: double.infinity,
                          color: Colors.grey.withOpacity(0.2),
                        ),
                      ],
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
