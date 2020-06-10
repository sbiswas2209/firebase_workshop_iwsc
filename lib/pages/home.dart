import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sample_firestore_app/models/user.dart';
import 'package:sample_firestore_app/models/userData.dart';
import 'package:sample_firestore_app/pages/newNote.dart';
import 'package:sample_firestore_app/pages/profile.dart';
import 'package:sample_firestore_app/services/auth.dart';
import 'package:sample_firestore_app/services/database.dart';
class HomePage extends StatefulWidget {
  static final String tag = 'home-page';
  final User user;
  HomePage({this.user});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _loading = false;
  final AuthService _auth = new AuthService();
  UserData _userData;
  @override
  void initState(){
    super.initState();
    setState(() {
      _loading = true;
    });
      new DatabaseService(uid: widget.user.uid).getUserData().then((value) {
        setState(() {
          _userData = value;
          _loading = false;
        });
      });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page',
          style: Theme.of(context).textTheme.headline1,
        ),
        actions: <Widget>[
          FlatButton(
            child: Icon(Icons.person_outline , color: Theme.of(context).primaryColorDark,),
            onPressed: () => Navigator.push(context, new MaterialPageRoute(
              builder: (BuildContext context) => new ProfilePage(uid: widget.user.uid)
            )),
          ),
          FlatButton(
            onPressed: () async {
              _auth.signOut();
            }, 
            child: Icon(Icons.exit_to_app , color: Theme.of(context).primaryColorDark,)
          ),
        ],
      ),
      body: _loading ? Center(child: CircularProgressIndicator()):
      StreamBuilder(
        stream: Firestore.instance.collection('items').snapshots(),
        builder: (context , snapshot){
          return !snapshot.hasData?Center(child: CircularProgressIndicator(),):
          ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context , index){
              return !snapshot.hasData? Center(child: CircularProgressIndicator(),):
              Card(
                color: Theme.of(context).primaryColorDark,
                child: ListTile(
                  leading: CircleAvatar(child: Icon(Icons.note)),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(snapshot.data.documents[index]['title'],
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      FlatButton.icon(
                        icon: Icon(Icons.thumb_up , color: Colors.white,),
                        label: Text('${snapshot.data.documents[index]['likes']}',
                          style: Theme.of(context).textTheme.bodyText1
                        ),
                        onPressed: (){
                          new DatabaseService(uid: widget.user.uid).likeItem(snapshot.data.documents[index]);
                        },
                      ),
                    ],
                  ),
                  subtitle: Text(snapshot.data.documents[index]['subTitle'],
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.push(context, new MaterialPageRoute(
          builder: (BuildContext context) => new NewNote(user: _userData)
        )),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}