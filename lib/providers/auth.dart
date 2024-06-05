import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:tisad_shop_app/constants.dart';
class AuthService {
  final _auth  = FirebaseAuth.instance;
  Future<UserCredential?> loginWithGoogle() async {
    try{
      final googleUser = await GoogleSignIn().signIn();
      final googleAuth = await googleUser?.authentication;
      final cred = GoogleAuthProvider.credential(
          idToken: googleAuth?.idToken,accessToken: googleAuth?.accessToken
      );

      return await _auth.signInWithCredential(cred);
    }catch(e){
      print(e.toString());
    }
    return null;
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

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.post(
      Uri.parse('$BaseUrl/logout'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      // Clear SharedPreferences
      await prefs.remove('token');
      // Navigate to login screen or wherever appropriate
    } else {
      print('$token');
    }
  }

}