import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:tisad_shop_app/screens/payment_screen.dart';
import '../constants.dart';
import '../theme.dart';

class ShippingAddress extends StatefulWidget {
  const ShippingAddress({super.key});

  @override
  State<ShippingAddress> createState() => _ShippingAddressState();
}

class _ShippingAddressState extends State<ShippingAddress> {
  final TextEditingController fNameController = TextEditingController();
  final TextEditingController lNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController(text: '254');
  final TextEditingController cityController = TextEditingController();
  final TextEditingController countyController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController townController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  String email = '';

  final _formKey = GlobalKey<FormState>();
  String? _errorMessage;

  String? _validateMpesaNumber(String? value) {
    if (value == null || value.isEmpty || !value.startsWith('+254')) {
      return 'M-Pesa number must start with +254';
    }
    String numberPart = value.substring(4);
    if (numberPart.length != 8) {
      return 'M-Pesa number must be exactly 8 digits after +254';
    }
    if (!RegExp(r'^[0-8]+$').hasMatch(numberPart)) {
      return 'M-Pesa number must contain only digits';
    }
    return null;
  }

  @override
  void dispose() {
    fNameController.dispose();
    lNameController.dispose();
    phoneController.dispose();
    cityController.dispose();
    countyController.dispose();
    addressController.dispose();
    townController.dispose();
    emailController.dispose();
    super.dispose();
  }

  Future<void> submitShippingDetails() async {
    final url = Uri.parse('$BaseUrl/shipping-details');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'f_name': fNameController.text,
        'l_name': lNameController.text,
        'phone': phoneController.text,
        'city': cityController.text,
        'county': countyController.text,
        'address': addressController.text,
        'town': townController.text,
      }),
    );

    if (response.statusCode == 200) {
      // Successfully stored or updated
      Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentScreen(phone: phoneController.text,)));
    } else {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed To Save Shipping Details'))
      );
    }
  }

  @override
  void initState (){
    super.initState();
    fetchUser();
  }

  Future<void> fetchUser() async {
    // Fetch user details from your API using the authentication token
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final url = Uri.parse('$BaseUrl/user');
    final response = await http.get(
        url,
        headers: {'Authorization': 'Bearer $token'}
    );

    if (response.statusCode == 200) {
      var userData = json.decode(response.body);
      setState(() {
        email = userData['email'];
        fetchShippingDetails();
      });

    } else {
      email = 'noemail@emailcom';
    }
  }

  var shipping;

  Future<Map<String, dynamic>?> fetchShippingDetails() async {
    final url = Uri.parse('$BaseUrl/shipping-details/$email');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          shipping =  json.decode(response.body);
        });

      } else {
        // If the server returns an error response, throw an exception.
        throw Exception(response.statusCode);
      }
    } catch (e) {
      // Catch any errors and print the error message.
      print('Error: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: shipping == null
        ? Padding(
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
                  readOnly: true,
                  controller: emailController,
                  decoration: InputDecoration(
                    label: const Text('Email(Read Only)'),
                    hintText: email,
                    hintStyle: const TextStyle(
                      color: Colors.red,
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
                  controller: fNameController,
                  decoration: InputDecoration(
                    label: const Text('First Name'),
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
                  controller: lNameController,
                  decoration: InputDecoration(
                    label: const Text('Last Name'),
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
                // TextField(
                //   controller: phoneController,
                //   decoration: InputDecoration(
                //     label: const Text('Mpesa Phone No.'),
                //     hintText: '254',
                //     hintStyle: const TextStyle(
                //       color: Colors.black26,
                //     ),
                //     border: OutlineInputBorder(
                //       borderSide: const BorderSide(
                //         color: Colors.black12, // Default border color
                //       ),
                //       borderRadius: BorderRadius.circular(10),
                //     ),
                //     enabledBorder: OutlineInputBorder(
                //       borderSide: BorderSide(
                //         color: lightColorScheme.primary, // Default border color
                //       ),
                //       borderRadius: BorderRadius.circular(10),
                //     ),
                //   ),
                // ),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        controller: phoneController,
                        decoration: InputDecoration(
                          labelText: 'M-Pesa Number',
                          errorText: _errorMessage,
                        ),
                        keyboardType: TextInputType.phone,
                        maxLength: 12, // +254 followed by 9 digits
                        validator: _validateMpesaNumber,
                      ),

                    ],
                  ),
                ),
                const SizedBox(
                  height: 25.0,
                ),
                TextField(
                  controller: cityController,
                  decoration: InputDecoration(
                    label: const Text('City'),
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
                  decoration: InputDecoration(
                    label: const Text('County'),
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
                  controller: addressController,
                  decoration: InputDecoration(
                    label: const Text('Address Line'),
                    hintText: 'Address(252-20200)',
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
                  decoration: InputDecoration(
                    label: const Text('Town'),
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
                  onTap: submitShippingDetails,
                  child: Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        color: lightColorScheme.primary,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Center(
                      child: RichText(
                        text: const TextSpan(
                            children: [
                              WidgetSpan(
                                  child: Icon(Icons.credit_card_outlined, size: 25, color: Colors.white,)
                              ),
                              WidgetSpan(
                                  child: SizedBox(width: 15,)
                              ),
                              TextSpan(
                                  text: 'Proceed To Payment',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white
                                  )
                              )
                            ]
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25.0,
                ),
              ]
          ),
        )
        :shipping.isEmpty
        ? const Text('No Shipping Details Found')
        : Padding(
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
                  readOnly: true,
                  controller: emailController,
                  decoration: InputDecoration(
                    label: const Text('Email(Read Only)'),
                    hintText: email,
                    hintStyle: const TextStyle(
                      color: Colors.red,
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
                  controller: fNameController,
                  decoration: InputDecoration(
                    label: const Text('First Name'),
                    hintText: shipping['f_name'] ?? '',
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
                  controller: lNameController,
                  decoration: InputDecoration(
                    label: const Text('Last Name'),
                    hintText: shipping['l_name'] ?? '',
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
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        controller: phoneController,
                        decoration: InputDecoration(
                          labelText: 'M-Pesa Number',
                          errorText: _errorMessage,
                        ),
                        keyboardType: TextInputType.phone,
                        maxLength: 12, // +254 followed by 9 digits
                        validator: _validateMpesaNumber,
                      ),

                    ],
                  ),
                ),

                // TextField(
                //   controller: phoneController,
                //   decoration: InputDecoration(
                //     label: const Text('Phone No.'),
                //     hintText: shipping['phone'] ?? '',
                //     hintStyle: const TextStyle(
                //       color: Colors.black26,
                //     ),
                //     border: OutlineInputBorder(
                //       borderSide: const BorderSide(
                //         color: Colors.black12, // Default border color
                //       ),
                //       borderRadius: BorderRadius.circular(10),
                //     ),
                //     enabledBorder: OutlineInputBorder(
                //       borderSide: BorderSide(
                //         color: lightColorScheme.primary, // Default border color
                //       ),
                //       borderRadius: BorderRadius.circular(10),
                //     ),
                //   ),
                // ),
                const SizedBox(
                  height: 25.0,
                ),
                TextField(
                  controller: cityController,
                  decoration: InputDecoration(
                    label: const Text('City'),
                    hintText: shipping['city'] ?? '',
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
                  decoration: InputDecoration(
                    label: const Text('County'),
                    hintText: shipping['county'] ?? '',
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
                  controller: addressController,
                  decoration: InputDecoration(
                    label: const Text('Address Line'),
                    hintText: shipping['address'] ?? '',
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
                  decoration: InputDecoration(
                    label: const Text('Town'),
                    hintText: shipping['town'] ?? '',
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
                  onTap: submitShippingDetails,
                  child: Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        color: lightColorScheme.primary,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Center(
                      child: RichText(
                        text: const TextSpan(
                            children: [
                              WidgetSpan(
                                  child: Icon(Icons.credit_card_outlined, size: 25, color: Colors.white,)
                              ),
                              WidgetSpan(
                                  child: SizedBox(width: 15,)
                              ),
                              TextSpan(
                                  text: 'Proceed To Payment',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white
                                  )
                              )
                            ]
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25.0,
                ),
              ]
          ),
        ),
      ),
    );
  }
}
