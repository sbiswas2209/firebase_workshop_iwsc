import 'package:flutter/material.dart';
import 'package:sample_firestore_app/models/userData.dart';
import 'package:sample_firestore_app/services/database.dart';
class NewNote extends StatefulWidget {
  static final String tag = 'new-note';
  final UserData user;
  NewNote({this.user});
  @override
  _NewNoteState createState() => _NewNoteState();
}

class _NewNoteState extends State<NewNote> {
  bool _loading = false;
  String _title;
  String _subTitle;
  final _formKey = GlobalKey<FormState>();
  Future<void> _showNullFieldDialog(BuildContext context){
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context){
        return AlertDialog(
          backgroundColor: Theme.of(context).primaryColorDark,
          title: Text('One or more fields empty'),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new item',
          style: Theme.of(context).textTheme.headline1,
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () async {
              if(_title == null || _subTitle == null){
                _showNullFieldDialog(context);
              }
              else{
                new DatabaseService(uid: widget.user.uid).setItemData(_title, _subTitle, widget.user.uid);
                setState(() {
                  _loading = true;
                });
                Navigator.pop(context);
              }
            }, 
            child: Icon(Icons.add , color: Theme.of(context).primaryColorDark,)
          ),
        ],
      ),
      body: Form(
        key: _formKey,
              child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                keyboardType: TextInputType.text,
                style: Theme.of(context).textTheme.bodyText1,
                decoration: InputDecoration(
                  hintText: 'Title',
                  hintStyle: Theme.of(context).textTheme.bodyText1,
                  icon: Icon(Icons.keyboard_arrow_right , color: Theme.of(context).primaryColor,),
                ),
                onChanged: (value){
                  setState(() {
                    _title = value;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                minLines: 1,
                maxLines: 10,
                style: Theme.of(context).textTheme.bodyText1,
                decoration: InputDecoration(
                  hintText: 'Subtitle',
                  hintStyle: Theme.of(context).textTheme.bodyText1,
                  icon: Icon(Icons.keyboard_arrow_right , color: Theme.of(context).primaryColor,),
                ),
                onChanged: (value){
                  setState(() {
                    _subTitle = value;
                  });
                },
              ),
            ),
            _loading ? Center(child: CircularProgressIndicator()) : SizedBox(),
          ],
        ),
      ),
    );
  }
}