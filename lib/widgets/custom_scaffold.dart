import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({super.key, this.child});
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
      ColorFiltered(
          colorFilter: ColorFilter.mode(
              const Color(0xFF185B6F).withOpacity(0.5), // Semi-transparent orange color
              BlendMode.srcATop,
            ),
        child: Image.asset(
          'assets/images/cover.jpg',
        ), // Replace 'image.png' with your image path
        ),

          SafeArea(
            child: child!,
          ),
        ],
      ),
    );
  }
}