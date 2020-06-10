import 'package:flutter/material.dart';
import 'package:sample_firestore_app/authentication/loginPage.dart';
import 'package:sample_firestore_app/authentication/signUpPage.dart';
import 'package:provider/provider.dart';
import 'package:sample_firestore_app/pages/home.dart';
import 'package:sample_firestore_app/pages/newNote.dart';
import 'package:sample_firestore_app/pages/profile.dart';
import 'package:sample_firestore_app/services/auth.dart';
import 'package:sample_firestore_app/wrapper.dart';

import 'models/user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final routes = <String , WidgetBuilder>{
    HomePage.tag : (context) => new HomePage(),
    LoginPage.tag : (context) => new LoginPage(),
    SignUpPage.tag : (context) => new SignUpPage(),
    NewNote.tag : (context) => new NewNote(),
    ProfilePage.tag : (context) => new ProfilePage(),
  };
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
          child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
        routes: routes,
        theme: ThemeData(
          primarySwatch: Colors.lime,
          primaryColor: Colors.limeAccent,
          primaryColorDark: Colors.black,
          scaffoldBackgroundColor: Colors.black,
          fontFamily: 'Cabin',
          textTheme: TextTheme(
            headline1: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25.0,
              color: Colors.black,
            ),
            bodyText1: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
            bodyText2: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
