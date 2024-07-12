import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:tisad_shop_app/constants.dart';
import 'package:tisad_shop_app/screens/vendor/dashboard.dart';

import '../../theme.dart';


class PinVerificationPage extends StatefulWidget {
  @override
  _PinVerificationPageState createState() => _PinVerificationPageState();
}

class _PinVerificationPageState extends State<PinVerificationPage> {
  final TextEditingController _pinController = TextEditingController();
  bool _isLoading = false;
  String _message = '';

  String email = '';

  @override
  void initState(){
    super.initState();
    fetchUser();
  }

  Future<void> fetchUser() async {
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
      });

    } else {
      email = 'Please Login';
    }
  }

  Future<void> _verifyPin() async {
    setState(() {
      _isLoading = true;
    });

    final response = await http.post(
      Uri.parse('$BaseUrl/verify-pin'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'pin': _pinController.text,
        'email': email
      }),
    );

    setState(() {
      _isLoading = false;
    });

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      if (responseData['status'] == 'success') {
        setState(() {
          _message = 'Login Successful';
          Navigator.push(context, MaterialPageRoute(builder:
              (context)=>const Dashboard()
          ));
        });
      } else {
        setState(() {
          _message = 'Invalid PIN';
        });
      }
    } else {
      setState(() {
        _message = 'Error: ${response.body}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Center(
                child: Image.asset(
                  'assets/images/logo.png', // Replace with your logo asset path
                  height: 100,
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Login To Portal',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 24.0),
                      TextField(
                        controller: _pinController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Enter PIN',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 24.0),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: lightColorScheme.primary,
                            elevation: 0,
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                          ),
                          onPressed: _isLoading ? null : _verifyPin,
                          child: Text(
                            _isLoading ? 'Loading...' : 'Login',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 24.0),
                      Text(
                        _message,
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
