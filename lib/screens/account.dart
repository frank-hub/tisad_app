import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tisad_shop_app/screens/orderHistory.dart';
import 'package:tisad_shop_app/screens/returnRequest.dart';
import 'package:tisad_shop_app/screens/shipping_address.dart';
import 'package:tisad_shop_app/screens/vendor/onboarding.dart';

import '../theme.dart';
import '../widgets/bottomNav.dart';
class AccountScreen extends StatefulWidget {
  final int currentIndex;
  const AccountScreen({super.key, required this.currentIndex});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
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
              const Text("MY ACCOUNT",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                ),
              ),
              IconButton(
                icon: const Icon(Icons.shopping_cart, color: Colors.black),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 150,
                      width:180,
                      padding: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.grey.withOpacity(0.8)
                        )
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.edit,
                          size: 70,
                          ),
                          SizedBox(height: 10,),
                          Text('Edit your account information',
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 150,
                      width:180,
                      padding: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1,
                              color: Colors.grey.withOpacity(0.8)
                          )
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.lock_reset_rounded,
                            size: 70,
                          ),
                          SizedBox(height: 10,),
                          Text('Change Password',
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder:
                        (context)=> ShippingAddress()
                        ));
                      },
                      child: Container(
                        height: 150,
                        width:180,
                        padding: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1,
                                color: Colors.grey.withOpacity(0.8)
                            )
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.badge_outlined,
                              size: 70,
                            ),
                            SizedBox(height: 10,),
                            Text('Modify your address book',
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder:
                        (context)=> OnBoarding()
                        ));
                      },
                      child: Container(
                        height: 150,
                        width:180,
                        padding: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1,
                                color: Colors.grey.withOpacity(0.8)
                            )
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.storefront,
                              size: 70,
                            ),
                            SizedBox(height: 10,),
                            Text('Become A Vendor',
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                const Text("MY ORDERS",
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Container(
                  height: 1,
                  width: 80,
                  color: Colors.red,
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder:
                        (context)=> OrderHistory()
                        ));
                      },
                      child: Container(
                        height: 150,
                        width:180,
                        padding: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1,
                                color: Colors.grey.withOpacity(0.8)
                            )
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.list_alt,
                              size: 70,
                            ),
                            SizedBox(height: 10,),
                            Text('View your order history',
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder:
                        (context)=> ReturnRequest()
                        ));
                      },
                      child: Container(
                        height: 150,
                        width:180,
                        padding: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1,
                                color: Colors.grey.withOpacity(0.8)
                            )
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.reply,
                              size: 70,
                            ),
                            SizedBox(height: 10,),
                            Text('View your return requests',
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ]
          ),
        ),
      ),
    );
  }
}
