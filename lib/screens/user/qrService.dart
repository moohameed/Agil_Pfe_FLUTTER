import 'package:buy_it/constants.dart';
import 'package:buy_it/screens/user/homePage.dart';
import 'package:buy_it/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrService extends StatefulWidget {
  static String id = 'qrservice';
  @override
  _QrServiceState createState() => _QrServiceState();
}

class _QrServiceState extends State<QrService> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.popAndPushNamed(context, HomePage.id) ;
        },
        backgroundColor: kMainColor ,
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
                onClick: (test)=> {},
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
                onPressed: () {
                  // to replace with scannig as a target !!

                },
                color: Colors.black,
                child: Text(
                  'Scan The Qr Code',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),

          ],
        ),
      ),

    ) ;
  }
}
