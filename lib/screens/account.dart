import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tisad_shop_app/screens/auth/pin_verification.dart';
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
                          Image.asset('assets/images/account/user.png',
                          height: 70,
                            width: 70,
                          ),
                          SizedBox(height: 10,),
                          Text('Account',
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
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
                            Image(image:AssetImage('assets/images/account/id-card.png'),
                            height: 70,
                              width: 70,
                            ),
                            SizedBox(height: 10,),
                            Text('Modify your address book',
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
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
                        // Navigator.push(context, MaterialPageRoute(builder:
                        // (context)=> OnBoarding()
                        // ));

                        Navigator.push(context, MaterialPageRoute(builder:
                        (context)=> PinVerificationPage()
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
                            Image(image: AssetImage('assets/images/account/eco-market.png'),
                            height: 70,
                              width: 70,
                            ),
                            SizedBox(height: 10,),
                            Text('Become A Vendor',
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                    ),
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
                            Image(image: AssetImage('assets/images/account/history.png'),
                            height: 70,
                              width: 70,
                            ),
                            SizedBox(height: 10,),
                            Text('Order History',
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                const Text("About Tisad Shop",
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Container(
                  height: 1,
                  width: 80,
                  color: lightColorScheme.primary,
                ),
                SizedBox(height: 10,),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text('Tisad Shop is Kenya`s premier multi-vendor marketplace, connecting buyers with a wide variety of quality products from trusted local vendors. We are committed to providing a seamless shopping experience with secure transactions and exceptional customer service. Discover the best of Kenya’s marketplace with Tisad Shop, your one-stop destination for fashion, electronics, home decor, and more.'),
                ),
                TextButton(
                onPressed: (){},
                    child: Text('Privacy Policy')
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Sign Out'),
                          content: Text('Are you sure you want to sign out?'),
                          actions: <Widget>[
                            TextButton(
                              child: Text('Cancel'),
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                              },
                            ),
                            TextButton(
                              child: Text('Sign Out'),
                              onPressed: () {
                                Auth // Close the dialog
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Container(
                    color: Colors.grey.withOpacity(0.5),
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: Center(
                      child: Text(
                        'SIGN OUT',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                )
              ]
          ),
        ),
      ),
    );
  }
}
