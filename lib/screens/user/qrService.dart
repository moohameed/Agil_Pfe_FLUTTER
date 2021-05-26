import 'package:buy_it/constants.dart';
import 'package:buy_it/screens/user/homePage.dart';
import 'package:buy_it/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrService extends StatefulWidget {
  static String id = 'qrservice';
  @override
  _QrServiceState createState() => _QrServiceState();
}

class _QrServiceState extends State<QrService> {
  String qrCode = 'Unknown';
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.popAndPushNamed(context, HomePage.id);
        },
        backgroundColor: kMainColor,
        child: Icon(Icons.cancel),
      ),
      appBar: AppBar(
        backgroundColor: kMainColor,
        title: Text(
          'Qr Code Service ',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 200),
        child: ListView(
          children: [
            CustomTextField(
                onClick: (test) => {},
                icon: Icons.high_quality,
                hint: "Enter your gasoit type"),
            SizedBox(
              height: height * .02,
            ),
            CustomTextField(
              icon: Icons.monetization_on,
              hint: "Enter the price ",
            ),
            SizedBox(
              height: height * .02,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 120),
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                onPressed: () => scanQRCode(),
                color: Colors.black,
                child: Text(
                  'Scan The Qr Code',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: height * .02,
            ),
            Center(
              child: Text(
                '$qrCode',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> scanQRCode() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.QR,
      );

      if (!mounted) return;

      setState(() {
        this.qrCode = qrCode;
      });
    } on PlatformException {
      qrCode = 'Failed to get platform version.';
    }
  }
}
