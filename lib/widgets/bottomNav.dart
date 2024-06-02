import 'package:flutter/material.dart';
import 'package:tisad_shop_app/screens/account.dart';
import 'package:tisad_shop_app/screens/explore.dart';
import 'package:tisad_shop_app/screens/home.dart';
import 'package:tisad_shop_app/screens/stores.dart';
// Import other screens as needed

class BottomNavLogic {
  static void onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
      // Navigate to HomeScreen with currentIndex 0
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen(currentIndex: 0)),
        );
        break;
      case 1:
      // Navigate to StoreScreen with currentIndex 1
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Stores(currentIndex: 1)),
        );
        break;
      case 2:
      // Navigate to ExploreScreen with currentIndex 2
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Explore(currentIndex: 2)),
        );
        break;
      case 3:
      // Navigate to AccountScreen with currentIndex 3
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AccountScreen(currentIndex: 3)),
        );
        break;
      default:
        break;
    }
  }
}
