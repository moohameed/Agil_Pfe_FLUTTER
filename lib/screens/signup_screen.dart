import 'package:buy_it/provider/modelHud.dart';
import 'package:buy_it/screens/login_screen.dart';
import 'package:buy_it/screens/user/homePage.dart';
import 'package:buy_it/widgets/custom_textfield.dart';
import 'package:buy_it/widgets/cutsom_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import 'package:buy_it/services/auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:date_field/date_field.dart';
import 'package:intl/intl.dart';

class SignupScreen extends StatelessWidget {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  static String id = 'SignupScreen';
  String _username , _email, _password ,_addres,_ville ,_number , _postal ;
  final _auth = Auth();
  DateTime _selectedDate;
  TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: kMainColor,
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<ModelHud>(context).isLoading,
        child: Form(
          key: _globalKey,
          child: ListView(
            children: <Widget>[
              CustomLogo(),
              SizedBox(
                height: height * .1,
              ),
              CustomTextField(
                onClick: (value) {
                  _username = value ;
                },
                icon: Icons.perm_identity,
                hint: 'Enter your name',
              ),
              SizedBox(
                height: height * .02,
              ),
              CustomTextField(
                onClick: (value) {
                  _email = value;
                },
                hint: 'Enter your email',
                icon: Icons.email,
              ),
              SizedBox(
                height: height * .02,
              ),
              CustomTextField(
                onClick: (value) {
                  _password = value;
                },
                hint: 'Enter your password',
                icon: Icons.lock,
              ),
              SizedBox(
                height: height * .02,
              ),
              CustomTextField(
                onClick: (value) {
                  _addres = value;
                },
                hint: 'Enter your addres',
                icon: Icons.place,
              ),
              SizedBox(
                height: height * .02,
              ),
              CustomTextField(
                onClick: (value) {
                  _ville = value;
                },
                hint: 'Enter your ville',
                icon: Icons.local_airport,
              ),
              SizedBox(
                height: height * .02,
              ),
              CustomTextField(
                onClick: (value) {
                  _number = value;
                },
                hint: 'Enter your Number',
                icon: Icons.phone,
              ),
              SizedBox(
                height: height * .02,
              ),
              CustomTextField(
                onClick: (value) {
                  _postal = value;
                },
                hint: 'Enter your Postal code',
                icon: Icons.post_add,
              ),
              SizedBox(
                height: height * .02,
              ),
           TextField(
            focusNode: AlwaysDisabledFocusNode(),
            controller: _textEditingController,
            onTap: () {
              _selectDate(context);
            },
           ),


              SizedBox(
                height: height * .05,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 120),
                child: Builder(
                  builder: (context) => FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () async {
                      final modelhud =
                          Provider.of<ModelHud>(context, listen: false);
                      modelhud.changeisLoading(true);
                      if (_globalKey.currentState.validate()) {
                        _globalKey.currentState.save();
                        try {
                          final authResult = await _auth.signUpNode(
                            _username.trim(),  _email.trim(), _password.trim());
                          modelhud.changeisLoading(false);
                          Navigator.pushNamed(context, HomePage.id);
                        } on PlatformException catch (e) {
                          modelhud.changeisLoading(false);
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text(e.message),
                          ));
                        }
                      }
                    },
                    color: Colors.black,
                    child: Text(
                      'Sign up',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * .05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Do have an account ? ',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

_selectDate(BuildContext context) async {
  DateFormat formatter = DateFormat('yyyy-mm-dd');//specifies day/month/year format
  DateTime newSelectedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate != null ? _selectedDate : DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2040),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: Colors.deepPurple,
              onPrimary: Colors.white,
              surface: Colors.blueGrey,
              onSurface: Colors.yellow,
            ),
            dialogBackgroundColor: Colors.blue[500],
          ),
          child: child,
        );
      });

  if (newSelectedDate != null) {
    _selectedDate = newSelectedDate;
    _textEditingController
      ..text = DateFormat.yMMMd().format(_selectedDate)
      ..selection = TextSelection.fromPosition(TextPosition(
          offset: _textEditingController.text.length,
          affinity: TextAffinity.upstream));
  }
}
}
class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
  

