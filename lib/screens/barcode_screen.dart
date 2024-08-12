import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:tisad_shop_app/constants.dart';
import 'package:tisad_shop_app/screens/product_details.dart';

class BarcodeScannerScreen extends StatefulWidget {
  @override
  _BarcodeScannerScreenState createState() => _BarcodeScannerScreenState();
}

class _BarcodeScannerScreenState extends State<BarcodeScannerScreen> {
  String barcode = '';

  @override
  void initState() {
    super.initState();
    _requestCameraPermission();
  }

  Future<void> _requestCameraPermission() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      status = await Permission.camera.request();
    }

    if (status.isGranted) {
      // Permission is granted, you can use the camera
    } else if (status.isDenied) {
      // Permission is denied. Show a message to the user.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Camera permission is required to scan barcodes.'),
        ),
      );
    } else if (status.isPermanentlyDenied) {
      // Permission is permanently denied, open app settings.
      openAppSettings();
    }
  }

  Future<void> scanBarcode() async {
    try {
      var result = await BarcodeScanner.scan();
      setState(() {
        barcode = result.rawContent;
      });
      searchProductByBarcode();
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() {
          barcode = 'Unknown error: $e';
        });
      }
    } on FormatException {
      setState(() {
        barcode = 'null (User returned using the "back"-button before scanning anything. Result)';
      });
    } catch (e) {
      setState(() {
        barcode = 'Unknown error: $e';
      });
    }
  }

  Future<void> searchProductByBarcode() async {
    // Replace with your Laravel API endpoint for fetching product details
    var apiUrl = '$BaseUrl/product/search';

    try {
      var response = await http.post(
        Uri.parse(apiUrl),
        body: {'barcode': barcode},
      );

      if (response.statusCode == 200) {
        // Handle successful API response here
        var productDetails = jsonDecode(response.body);
        // Use productDetails to update UI or navigate to product details screen
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Product details fetched successfully!'),
          ),
        );
        Navigator.push(context, MaterialPageRoute(builder:
            (context)=> ProductDetails(currentIndex: 2, p_index: productDetails['id'].toString() ?? '',)
        ));
        
      } else {
        // Handle errors, if any
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to fetch product details'),
          ),
        );
      }
    } catch (e) {
      // Handle network errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Barcode Scanner'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Scan result: $barcode\n', textAlign: TextAlign.center),
            ElevatedButton(
              onPressed: scanBarcode,
              child: Text('Start Barcode Scan'),
            ),
            SizedBox(height: 20),
            // ElevatedButton(
            //   onPressed: barcode.isNotEmpty ? searchProductByBarcode : null,
            //   child: Text('Search for Product'),
            // ),
          ],
        ),
      ),
    );
  }
}
