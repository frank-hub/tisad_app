import 'package:flutter/material.dart';
import 'package:tisad_shop_app/Onbording.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
      home: const MyApp()
  )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Onbording();
  }
}
