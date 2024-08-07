import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:tisad_shop_app/constants.dart';

import '../Onbording.dart';
class AuthService {
  final _auth  = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<UserCredential?> loginWithGoogle() async {
    try{
      final googleUser = await GoogleSignIn().signIn();
      final googleAuth = await googleUser?.authentication;
      final cred = GoogleAuthProvider.credential(
          idToken: googleAuth?.idToken,accessToken: googleAuth?.accessToken
      );
      if(googleUser != null){
        _handleSignIn(googleUser);
      }
      return await _auth.signInWithCredential(cred);
    }catch(e){
      print(e.toString());
    }
    return null;
  }

  Future<void> _handleSignIn(GoogleSignInAccount account) async {

    final authentication = await account.authentication;
    final idToken = authentication.idToken;
    const String url = '$BaseUrl/google-signin';

    final Map<String, String> data = {
      'name': account.displayName.toString(),
      'email': account.email,
      'phone': '000000000',
      'password': account.id,
    };

    final response = await http.post(Uri.parse(url), body: data);


    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      var token = responseData['token'];

      // Store token securely on the device
      // For example, using shared preferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', token);
      // Store token in secure storage and navigate to home screen
    } else {
      print('Errrror${response.statusCode}');
    }
  }

  Future<String?> loggedIn() async{
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final username = user.email; // Assuming username is the email address
      // Display the username using Text widget or other UI elements
      return username;
    } else {
      // Handle the case where the user is not signed in
      return 'Please Login';
    }
  }

  Future<void> logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      print('No token found.');
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('$BaseUrl/logout'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        // Clear SharedPreferences
        await prefs.remove('token');

        // Perform sign out operations
        await _signOutGoogleAndFirebase(context);

        if (context.mounted) {
          // Navigate to login screen or wherever appropriate
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Onbording()),
          );
        }
      } else {
        print('Logout failed: ${response.statusCode}');
        if (context.mounted) {
          // Optionally show a message to the user
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Logout failed: ${response.reasonPhrase}')),
          );
        }
      }
    } catch (e) {
      print('Error during logout: $e');
      if (context.mounted) {
        // Optionally show a message to the user
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An error occurred during logout')),
        );
      }
    }
  }

  Future<void> _signOutGoogleAndFirebase(BuildContext context) async {
    try {
      // Sign out from Google
      await _googleSignIn.signOut();

      // Sign out from Firebase
      await _auth.signOut();
    } catch (e) {
      print('Error signing out: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error signing out. Please try again.')),
        );
      }
    }
  }

}