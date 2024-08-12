import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tisad_shop_app/screens/vendor/dashboard.dart';
import 'package:tisad_shop_app/theme.dart';
import 'package:http/http.dart' as http;
import '../../constants.dart';

class Payment extends StatefulWidget {
  final String vendor_id;
  const Payment({super.key,required  this.vendor_id});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {

  final TextEditingController phoneController = TextEditingController(text: '254');

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

  Future<void> stkPush() async{

    final mpesa = {
      "phone": phoneController.text,
      "amount": '1',
      'vendor_id':widget.vendor_id
    };
    final response = await http.post(
      Uri.parse('$BaseUrl/mpesa/vendor/stkpush'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(mpesa),
    );
    if(response.statusCode == 200){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Enter Pin"))
      );
      Future.delayed(Duration(seconds: 30), () async{
        final res = await http.get(Uri.parse('$BaseUrl/vendor/payment/confirmation/${widget.vendor_id}'));

        if(res.statusCode == 200){
          var trans  = json.decode(res.body);
          if(trans['TransID'] != null || trans['TransID'].isNotEmpty){
            Navigator.push(context, MaterialPageRoute(builder:
                (context)=> const Dashboard()
            ));
          }else{
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('No Payment Received'))
            );
          }
        }else{
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(res.body))
          );

        }

      });
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to initiate M-Pesa STK Push."))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Payment Details'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 100,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.red, Colors.blue],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Total Payment',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    ),
                    SizedBox(height: 5,),
                    Text('Ksh 1,500',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10,),
                    const Text('Monthly Price',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15
                    ),
                    ),
                    const SizedBox(height: 5,),
                    const Text('KES 1,500'),
                    Container(
                      height: 0.5,
                      margin: const EdgeInsets.symmetric(vertical: 13),
                      width: double.infinity,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                    const Text('No. Of Products',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15
                      ),
                    ),
                    const SizedBox(height: 5,),
                    const Text('Unlimited Products'),
                    Container(
                      height: 0.5,
                      margin: const EdgeInsets.symmetric(vertical: 13),
                      width: double.infinity,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                    const Text('Category Limitation',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15
                      ),
                    ),
                    const SizedBox(height: 5,),
                    const Text('None'),
                    Container(
                      height: 0.5,
                      margin: const EdgeInsets.symmetric(vertical: 13),
                      width: double.infinity,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                    const Text('No. Of Orders',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15
                      ),
                    ),
                    const SizedBox(height: 5,),
                    const Text('Unlimited'),
                    Container(
                      height: 0.5,
                      margin: const EdgeInsets.symmetric(vertical: 13),
                      width: double.infinity,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              // Card(
              //   color: Colors.green,
              //   child: Container(
              //
              //     child: const Center(
              //       child: Column(
              //         mainAxisAlignment: MainAxisAlignment.start,
              //         // crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Text("Paybill No: 880100",
              //           style: TextStyle(
              //             color: Colors.white,
              //
              //           ),
              //           ),
              //           SizedBox(height: 10,),
              //           Text("Account number: 6068010017",
              //           style: TextStyle(
              //             color: Colors.white,
              //           ),
              //           ),
              //           Padding(
              //             padding: EdgeInsets.all(8.0),
              //             child: Text('Make Payment Using The Details Above then click "confirm"-Our team will review and get back to you.'),
              //           )
              //         ],
              //       ),
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
              const SizedBox(height: 140,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: (){
                    stkPush();
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
                      child: Text("PAY NOW",
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
        
            ],
          ),
        ),
      ),
    );
  }
}
