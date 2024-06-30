import 'package:flutter/material.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

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
          ],
        ),
      ),
    );
  }
}
