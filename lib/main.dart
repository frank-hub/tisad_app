import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tisad_shop_app/Onbording.dart';
import 'package:tisad_shop_app/providers/cart_provider.dart';  // Import the CartProvider

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Onbording();
  }
}
