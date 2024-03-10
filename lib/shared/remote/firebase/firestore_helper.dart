
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do/model/user.dart';

class FireStoreHelper{
  static CollectionReference<User> getUsersCollection(){
    var reference = FirebaseFirestore.instance.collection("user").withConverter(
        fromFirestore:(snapshot, options){
          Map<String , dynamic>? data = snapshot.data();
          return User.fromFirestore(data??{});
        } ,
        toFirestore: (user , options){
          return user.toFirestore();
        }
    );
    return reference;
  }
  static Future<void> addUser(String fullName, String email ,String userId) async{
    var document = getUsersCollection().doc(userId);
    await document.set(
      User(
          id: userId,
          fullName: fullName,
          email: email
      )
    );
  }
  static Future<User?> getUser(String userId)async{
    var document = getUsersCollection().doc(userId);
     var snapshot = await document.get();
    User? user = snapshot.data();
    return user;
  }
}