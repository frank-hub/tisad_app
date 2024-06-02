import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tisad_shop_app/main.dart';
import 'package:tisad_shop_app/screens/auth/login.dart';
import 'package:tisad_shop_app/screens/auth/register.dart';
import 'content_model.dart';

class Onbording extends StatefulWidget {
  @override
  _OnbordingState createState() => _OnbordingState();
}

class _OnbordingState extends State<Onbording> {
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
              mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("ShopSmart Wallet",
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold
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
                  const Image(image: AssetImage('assets/images/logo.png',),
                  height: 300,
                  ),
                  const SizedBox(height: 200,),
                  InkWell(
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder:
                      (context)=> SignInScreen()
                      ));
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.black,

                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: const Center(
                        child: Text("Explore",
                        textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                            child: const Text("I already have an account"),
                          onTap: (){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder:
                                (context)=> SignInScreen()
                            ));
                          },
                        ),
                        InkWell(
                            onTap: (){
                              Navigator.pushReplacement(context, MaterialPageRoute(builder:
                              (context)=> SignUpScreen()
                              ));
                            },
                            child: const Text("New Here")),
                      ],
                    ),
                  )

                ]
            ),
          ),
        )
    );
  }
}