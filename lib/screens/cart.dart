import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tisad_shop_app/screens/shipping_address.dart';
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  const Text("Shopping  Cart",
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
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: const Color(0xffEEEEEE),
                    border: Border.all(
                      width: 0.1,
                      color: Colors.black.withOpacity(0.8)
                    )
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        width: 80,
                        child: const Text(
                            "MODEL"
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        width: 75,
                        child: const Text(
                            "QUANTITY"
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                            "UNIT\nPRICE"
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                            "TOTAL"
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 0.1,
                          color: Colors.black.withOpacity(0.8)
                      )
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        width: 80,
                        child: const Text(
                            "Original Shoe"
                        ),
                      ),
                      Container(
                        width: 75,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 0.8,
                                  color: Colors.black.withOpacity(0.8)
                              )
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 20,
                                    height: 30,
                                    child: const TextField(
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                  Container(
                                    color: Colors.grey,
                                    child: const Column(
                                      children: [
                                        Icon(Icons.keyboard_arrow_up,
                                          size: 15,
                                        ),
                                        Icon(Icons.keyboard_arrow_down,
                                          size: 15,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 18,
                                    height: 30,
                                    color: Colors.black,
                                    child: const Center(
                                      child: Icon(Icons.refresh,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 20,
                                    height: 30,
                                    color: Colors.red,
                                    child: const Center(
                                      child: Icon(Icons.delete_forever,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                            '400'
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                            "2000"
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 0.1,
                          color: Colors.black.withOpacity(0.8)
                      )
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        width: 80,
                        child: const Text(
                            "Original Shoe"
                        ),
                      ),
                      Container(
                        width: 75,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 0.8,
                                  color: Colors.black.withOpacity(0.8)
                              )
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 20,
                                    height: 30,
                                    child: const TextField(
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                  Container(
                                    color: Colors.grey,
                                    child: const Column(
                                      children: [
                                        Icon(Icons.keyboard_arrow_up,
                                          size: 15,
                                        ),
                                        Icon(Icons.keyboard_arrow_down,
                                          size: 15,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 18,
                                    height: 30,
                                    color: Colors.black,
                                    child: const Center(
                                      child: Icon(Icons.refresh,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 20,
                                    height: 30,
                                    color: Colors.red,
                                    child: const Center(
                                      child: Icon(Icons.delete_forever,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                            '400'
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                            "2000"
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 0.1,
                          color: Colors.black.withOpacity(0.8)
                      )
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        width: 80,
                        child: const Text(
                            "Original Shoe"
                        ),
                      ),
                      Container(
                        width: 75,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 0.8,
                                  color: Colors.black.withOpacity(0.8)
                              )
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 20,
                                    height: 30,
                                    child: const TextField(
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                  Container(
                                    color: Colors.grey,
                                    child: const Column(
                                      children: [
                                        Icon(Icons.keyboard_arrow_up,
                                          size: 15,
                                        ),
                                        Icon(Icons.keyboard_arrow_down,
                                          size: 15,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 18,
                                    height: 30,
                                    color: Colors.black,
                                    child: const Center(
                                      child: Icon(Icons.refresh,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 20,
                                    height: 30,
                                    color: Colors.red,
                                    child: const Center(
                                      child: Icon(Icons.delete_forever,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                            '400'
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                            "2000"
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50,),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                  decoration: const BoxDecoration(
                    color: Color(0xffEEEEEE)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("WHAT WOULD YOU LIKE TO DO NEXT ?",
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
                      const SizedBox(height: 20,),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("USE COUPON CODE",
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Icon(Icons.arrow_right_alt)
                        ],
                      ),
                      const SizedBox(height: 10,),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: Colors.red.withOpacity(0.2),
                      ),
                      const SizedBox(height: 10,),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("USE GIFT CERTIFICATE",
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Icon(Icons.arrow_right_alt)
                        ],
                      ),
                      const SizedBox(height: 20,),
                      Container(
                        width: double.infinity,
                        height: 45,
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Text("Sub-Total:",
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            Container(
                              width: 65,
                              padding: const EdgeInsets.only(right: 10,left: 10),
                              child: const Text("500"),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: Colors.red.withOpacity(0.2),
                      ),
                      Container(
                        width: double.infinity,
                        height: 45,
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Text("Total:",
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            Container(
                              width: 65,
                              padding: const EdgeInsets.only(right: 10,left: 10),
                              child: const Text("1,500"),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 20,),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: Colors.red.withOpacity(0.2),
                      ),
                      const SizedBox(height: 10,),
                      Container(
                        color: Colors.grey,
                        height: 45,
                        child: Center(
                          child: RichText(
                            text: const TextSpan(
                              children: [
                                WidgetSpan(
                                  child: Icon(CupertinoIcons.left_chevron,
                                  size: 18,
                                    color: Colors.white70,
                                  )
                                ),
                                WidgetSpan(
                                  child: SizedBox(
                                    width: 10,
                                  )
                                ),
                                TextSpan(
                                  text:'CONTINUE SHOPPING',
                                  style: TextStyle(
                                    fontSize: 18,
                                  )
                                )
                              ]
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder:
                          (context)=> ShippingAddress()
                          ));
                        },
                        child: Container(
                          color: Colors.green,
                          height: 45,
                          child: Center(
                            child: RichText(
                              text: const TextSpan(
                                  children: [
                                    WidgetSpan(
                                        child: Icon(Icons.exit_to_app,
                                          size: 18,
                                          color: Colors.white70,
                                        )
                                    ),
                                    WidgetSpan(
                                        child: SizedBox(
                                          width: 10,
                                        )
                                    ),
                                    TextSpan(
                                        text:'CHECKOUT',
                                        style: TextStyle(
                                          fontSize: 18,
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
                )
            ]
          ),
        ),
      ),
    );
  }
}
