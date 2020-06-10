import 'package:firebase_auth/firebase_auth.dart';
import 'package:sample_firestore_app/models/user.dart';
import 'package:sample_firestore_app/services/database.dart';
class AuthService{
  FirebaseAuth _auth = FirebaseAuth.instance;

  User _userFromFirebase(FirebaseUser user){
    return user!=null ? User(uid: user.uid) : null;
  }

  Stream<User> get user{
    return _auth.onAuthStateChanged.map(_userFromFirebase);
  }

  Future<dynamic> signIn(String email , String password) async {
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebase(user);
    }
    catch(e){
      return e.toString();
    }
  }

  Future<dynamic> signUp(String userName , String email , String password) async {
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      await new DatabaseService(uid: user.uid).setUserData(userName, email, password);
      return _userFromFirebase(user);
    }
    catch(e){
      return e.toString();
    }
  }

  Future<void> signOut() async {
    return _auth.signOut();
  }

}