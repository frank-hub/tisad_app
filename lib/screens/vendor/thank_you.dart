import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tisad_shop_app/main.dart';
import 'package:tisad_shop_app/screens/auth/login.dart';
import 'package:tisad_shop_app/screens/auth/register.dart';
import 'package:tisad_shop_app/screens/vendor/dashboard.dart';
import 'package:tisad_shop_app/screens/vendor/payment.dart';
import 'package:tisad_shop_app/theme.dart';

class ThankYou extends StatefulWidget {
  final String? id;
  const ThankYou({super.key,required this.id});
  @override
  _ThankYouState createState() => _ThankYouState();
}

class _ThankYouState extends State<ThankYou> {
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
                      const Text("Thank You For \nBecoming Tisad Vendor",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: const Text("Easily manage your shopping across multiples stores",
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
                            (context)=> Payment(vendor_id: widget.id.toString(),)
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
                          child: Text("Proceed To Payment",
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