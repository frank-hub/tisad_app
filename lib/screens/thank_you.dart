import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tisad_shop_app/main.dart';
import 'package:tisad_shop_app/screens/auth/login.dart';
import 'package:tisad_shop_app/screens/auth/register.dart';
import 'package:tisad_shop_app/screens/home.dart';
import 'package:tisad_shop_app/screens/vendor/dashboard.dart';
import 'package:tisad_shop_app/theme.dart';

class ThankYouOrder extends StatefulWidget {
  @override
  _ThankYouOrderState createState() => _ThankYouOrderState();
}

class _ThankYouOrderState extends State<ThankYouOrder> {
  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin:EdgeInsets.only(top: 25),
                    child: const Image(image: AssetImage('assets/images/logo.png',),
                      height: 180,
                    ),
                  ),
                  Container(
                    margin:EdgeInsets.only(top: 25),
                    child: const Image(image: AssetImage('assets/images/vendor_thanks_icon.png',),
                      height: 200,
                    ),
                  ),
                  SizedBox(height: 30,),
                  Column(
                    children: [
                      const Text("Thank You For \nYour Order",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: const Text("We will process your order\n in a few minutes",
                          textAlign: TextAlign.center,
                          style: TextStyle(

                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 200,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder:
                            (context)=> HomeScreen(currentIndex: 0)
                        ));
                      },
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.green.withOpacity(0.8),
                                lightColorScheme.primary,
                              ],
                              // radius: 2.8,
                              stops: [0.2, 1.0],
                              // center: Alignment.center,
                            ),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: const Center(
                          child: Text("Shop",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ]
            ),
          ),
        )
    );
  }
}