import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sample_firestore_app/models/userData.dart';
class DatabaseService{
  final String uid;
  DatabaseService({this.uid});
  final CollectionReference userData = Firestore.instance.collection('users');
  final CollectionReference itemData = Firestore.instance.collection('items');
  Future setUserData(String userName , String email , String password) async {
    return await userData.document(uid).setData({
      'userName': userName,
      'email': email,
      'password': password,
    });
  }
  Future setItemData(String title , String subTitle , String uid) async {
    await itemData.document().setData({
      'title': title,
      'subTitle': subTitle,
      'madeBy': uid,
      'likes': 0,
    });
  }
  getUserData() async {
    UserData user;
    DocumentSnapshot snapshot = await userData.document(uid).get();
    user = new UserData(
      email: snapshot.data['email'],
      password: snapshot.data['password'],
      name: snapshot.data['userName'],
      uid: uid,
    );
    return user;
  }
  likeItem(DocumentSnapshot data){
    Firestore.instance.runTransaction((transaction) async {
      DocumentSnapshot freshSnap = await transaction.get(data.reference);
      await transaction.update(freshSnap.reference, {
        'likes': freshSnap['likes']+1,
      });
    });
  }
}