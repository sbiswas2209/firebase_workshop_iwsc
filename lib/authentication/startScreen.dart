import 'package:flutter/material.dart';
import 'package:sample_firestore_app/authentication/loginPage.dart';
import 'package:sample_firestore_app/authentication/signUpPage.dart';
class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  bool _signInStatus = true;
  _toggleView(){
    setState(() {
      _signInStatus = !_signInStatus;
    });
  }
  @override
  Widget build(BuildContext context) {
    return _signInStatus ? LoginPage(toggleView: _toggleView) : SignUpPage(toggleView: _toggleView);
  }
}