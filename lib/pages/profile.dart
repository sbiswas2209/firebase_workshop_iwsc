import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class ProfilePage extends StatelessWidget {
  static final String tag = 'profile-page';
  final String uid;
  ProfilePage({this.uid});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Items',
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection('items').where('madeBy', isEqualTo:uid).snapshots(),
        builder: (context , snapshot){
          return !snapshot.hasData ? Center(child: CircularProgressIndicator(),):
            ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context , index){
                return ListTile(
                  leading: CircleAvatar(child: Icon(Icons.note , color: Theme.of(context).primaryColorDark,)),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(snapshot.data.documents[index]['title'],
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Row(
                        children: <Widget>[
                          Icon(Icons.thumb_up , color: Colors.white,),
                          SizedBox(width: 5),
                          Text('${snapshot.data.documents[index]['likes']}',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            );
        },
      ),
    );
  }
}