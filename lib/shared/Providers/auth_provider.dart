import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do/model/user.dart' as MyUser;
import 'package:to_do/shared/remote/firebase/firestore_helper.dart';

class MyAuthProvider extends ChangeNotifier{
  User? firebaseUserAuth;
  MyUser.User? databaseUser;

  void setUsers(User? newFirebaseUserAuth , MyUser.User? newDatabaseUser){
    firebaseUserAuth = newFirebaseUserAuth;
    databaseUser = newDatabaseUser;
  }
  bool isFirebaseUserLoggedIn(){
    if(FirebaseAuth.instance.currentUser== null)return false;
    firebaseUserAuth = FirebaseAuth.instance.currentUser;
    return true;
  }

  Future<void> retrieveDatabaseUserDara()async{
    try{
      databaseUser = await FireStoreHelper.getUser(firebaseUserAuth!.uid);
    }catch(e){
      print(e);
    }
  }
  Future<void> signOut() async{
    firebaseUserAuth = null;
    databaseUser = null;
    return await FirebaseAuth.instance.signOut();
  }
}