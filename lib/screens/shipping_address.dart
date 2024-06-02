import 'package:flutter/material.dart';
import 'package:tisad_shop_app/screens/thank_you.dart';
import 'package:tisad_shop_app/screens/vendor/thank_you.dart';

import '../theme.dart';

class ShippingAddress extends StatefulWidget {
  const ShippingAddress({super.key});

  @override
  State<ShippingAddress> createState() => _ShippingAddressState();
}

class _ShippingAddressState extends State<ShippingAddress> {
  TextEditingController f_nameController = TextEditingController();
  TextEditingController l_nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController countyController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController townController = TextEditingController();


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
                    const Text("Shipping Address",
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
                const SizedBox(
                  height: 25.0,
                ),
                TextField(
                  controller: f_nameController,
                  onChanged: (value){
                    setState(() {
                      f_nameController.text = value;
                    });
                  },
                  decoration: InputDecoration(
                    label: const Text('First Name'),
                    hintText: 'Enter First Name',
                    hintStyle: const TextStyle(
                      color: Colors.black26,
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.black12, // Default border color
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: lightColorScheme.primary, // Default border color
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25.0,
                ),
                TextField(
                  controller: l_nameController,
                  onChanged: (value){
                    setState(() {
                      l_nameController.text = value;
                    });
                  },
                  decoration: InputDecoration(
                    label: const Text('Last Name'),
                    hintText: 'Enter Last Name',
                    hintStyle: const TextStyle(
                      color: Colors.black26,
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.black12, // Default border color
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: lightColorScheme.primary, // Default border color
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),



                const SizedBox(
                  height: 25.0,
                ),
                TextField(
                  controller: phoneController,
                  onChanged: (value){
                    setState(() {
                      phoneController.text = value;
                    });
                  },
                  decoration: InputDecoration(
                    label: const Text('Phone No.'),
                    hintText: 'Enter Phone No.',
                    hintStyle: const TextStyle(
                      color: Colors.black26,
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.black12, // Default border color
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: lightColorScheme.primary, // Default border color
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25.0,
                ),
                TextField(
                  controller: cityController,
                  onChanged: (value){
                    setState(() {
                      cityController.text = value;
                    });
                  },
                  decoration: InputDecoration(
                    label: const Text('City'),
                    hintText: 'Enter City',
                    hintStyle: const TextStyle(
                      color: Colors.black26,
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.black12, // Default border color
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: lightColorScheme.primary, // Default border color
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25.0,
                ),
                TextField(
                  controller: countyController,
                  onChanged: (value){
                    setState(() {
                      countyController.text = value;
                    });
                  },
                  decoration: InputDecoration(
                    label: const Text('County'),
                    hintText: 'Enter County',
                    hintStyle: const TextStyle(
                      color: Colors.black26,
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.black12, // Default border color
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: lightColorScheme.primary, // Default border color
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25.0,
                ),
                TextField(
                  controller: l_nameController,
                  onChanged: (value){
                    setState(() {
                      l_nameController.text = value;
                    });
                  },
                  decoration: InputDecoration(
                    label: const Text('Address Line'),
                    hintText: 'Enter Address Line',
                    hintStyle: const TextStyle(
                      color: Colors.black26,
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.black12, // Default border color
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: lightColorScheme.primary, // Default border color
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25.0,
                ),
                TextField(
                  controller: townController,
                  onChanged: (value){
                    setState(() {
                      townController.text = value;
                    });
                  },
                  decoration: InputDecoration(
                    label: const Text('Town'),
                    hintText: 'Enter Town',
                    hintStyle: const TextStyle(
                      color: Colors.black26,
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.black12, // Default border color
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: lightColorScheme.primary, // Default border color
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25.0,
                ),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder:
                    (context)=> ThankYouOrder()
                    ));
                  },
                  child: Container(
                    height: 50,
                    padding: EdgeInsets.symmetric(horizontal:10),
                    decoration: BoxDecoration(
                        color: lightColorScheme.primary,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Center(
                      child: RichText(
                        text: const TextSpan(
                            children: [
                              WidgetSpan(
                                  child: Icon(Icons.credit_card_outlined,size: 25,color: Colors.white,)
                              ),
                              WidgetSpan(
                                  child: SizedBox(width: 15,)
                              ),
                              TextSpan(
                                  text: 'Proceed To Payment',
                                  style: TextStyle(
                                      fontSize: 19
                                  )
                              )
                            ]
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
