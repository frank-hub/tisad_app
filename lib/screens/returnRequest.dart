import 'package:flutter/material.dart';

import '../theme.dart';

class ReturnRequest extends StatefulWidget {
  const ReturnRequest({super.key});

  @override
  State<ReturnRequest> createState() => _ReturnRequestState();
}

class _ReturnRequestState extends State<ReturnRequest> {
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
                  const Text("Return Request",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.notifications_active, color: Colors.black),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10,),
              Container(
                height: 40,
                width: double.infinity,
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

              Container(
                height: 900,
                width: double.infinity,
                child: ListView.builder(
                  itemCount:5,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (){

                      },
                      child: Card(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          height: 120,
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.5),
                                  image: const DecorationImage(
                                    image: AssetImage('assets/shoes.jpg'),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              const SizedBox(width: 10,),

                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Official Brown Shoes',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  const SizedBox(height: 10,),
                                  Text('Quantity: 5',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),

                                  const SizedBox(height: 10,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      RichText(
                                        text: const TextSpan(
                                            children: [
                                              TextSpan(
                                                  text: '1,800',
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.bold
                                                  )
                                              ),
                                              WidgetSpan(
                                                  child: SizedBox(width: 1,)
                                              ),
                                              TextSpan(
                                                  text: 'KES',style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.black,
                                              )
                                              ),
                                            ]
                                        ),
                                      ),
                                      SizedBox(width: 130,),
                                      Container(
                                        height: 22,
                                        width: 22,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(50),
                                          color: Colors.red,
                                        ),
                                        child: const Icon(Icons.cancel,
                                          size: 21,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
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
              )

            ],
          ),
        ),
      ),
    );
  }
}
