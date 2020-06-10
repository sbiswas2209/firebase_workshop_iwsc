import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sample_firestore_app/services/auth.dart';
class LoginPage extends StatefulWidget {
  static final String tag = 'login-page';
  final Function toggleView;
  LoginPage({this.toggleView});
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = new GlobalKey<FormState>();
  String _email;
  String _password;
  bool _loading = false;
  Future<void> _showNullFieldDialog(BuildContext context){
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context){
        return AlertDialog(
          backgroundColor: Theme.of(context).primaryColorDark,
          title: Text('One or more fields are empty'),
          content: Text('Please fill up all fields.'),
          titleTextStyle: Theme.of(context).textTheme.headline1.copyWith(color: Colors.white),
          contentTextStyle: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.white),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      }
    );
  }
  Future<void> _showErrorFieldDialog(BuildContext context){
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context){
        return AlertDialog(
          backgroundColor: Theme.of(context).primaryColorDark,
          title: Text('Error'),
          content: Text('An error occured. Check the fields and try again.'),
          titleTextStyle: Theme.of(context).textTheme.headline1.copyWith(color: Colors.white),
          contentTextStyle: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.white),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Login Page',
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            _loading ? Center(child: LinearProgressIndicator(),):SizedBox(height: 50.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                style: Theme.of(context).textTheme.bodyText1,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  icon: Icon(Icons.email , color: Theme.of(context).primaryColor,),
                  hintText: 'Email',
                  hintStyle: Theme.of(context).textTheme.bodyText1,
                ),
                onChanged: (value) {
                  setState(() {
                    _email = value;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                style: Theme.of(context).textTheme.bodyText1,
                obscureText: true,
                decoration: InputDecoration(
                  icon: Icon(Icons.lock_outline , color: Theme.of(context).primaryColor,),
                  hintText: 'Password',
                  hintStyle: Theme.of(context).textTheme.bodyText1,
                ),
                onChanged: (value) {
                  setState(() {
                    _password = value;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
                              child: RaisedButton.icon(
                  color: Theme.of(context).primaryColor,
                  icon: Icon(Icons.keyboard_arrow_right , color: Theme.of(context).primaryColorDark,),
                  label: Text('Log In'),
                  onPressed: () async {
                    if(_email == null || _password == null){
                      _showNullFieldDialog(context);
                    }
                    else{
                      setState(() {
                        _loading = true;
                      });
                      try{
                        await new AuthService().signIn(_email, _password);
                      }
                      catch(e){
                        _showErrorFieldDialog(context);
                      }
                    }
                  },
                ),
              ),
            ),
            FlatButton.icon(
              label: Text('Sign Up', style: TextStyle(color: Theme.of(context).primaryColor),),
              icon: Icon(Icons.add , color: Theme.of(context).primaryColor,),
              onPressed: widget.toggleView,
            ),
          ],
        ),
      ),
    );
  }
}