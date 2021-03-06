import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_firestore_app/authentication/startScreen.dart';
import 'package:sample_firestore_app/pages/home.dart';

import 'models/user.dart';
class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if(user == null){
      return StartScreen();
    }
    else{
      return HomePage(user : user);
    }
  }
}