
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do/model/user.dart';

import '../../../model/task.dart';

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
  static CollectionReference<Task> getTaskCollection(String userId){
    var tasksCollection = getUsersCollection().doc(userId).collection("tasks").withConverter(
        fromFirestore: (snapshot,options)=>Task.fromFirestore(snapshot.data()??{}),
        toFirestore: (task , options)=>task.toFirestore()
    );
    return tasksCollection;
  }

  static Future<void> AddNewTask(Task task, String userId)async{
    var reference = getTaskCollection(userId);
    var taskDocument =reference.doc();
    task.id = taskDocument.id;
    await taskDocument.set(task);
  }

  static Stream<List<Task>> ListenToTasks(String userId,int date)async*{
    Stream<QuerySnapshot<Task>> taskQueryStream = getTaskCollection(userId).where("date",isEqualTo: date).snapshots();
    Stream<List<Task>> taskStream=taskQueryStream.map((querySnapshot) => querySnapshot.docs.map((document) => document.data()).toList());
    yield* taskStream;
  }

  static Future<void> deleteTask({required String userId , required String taskId}) async {
    await getTaskCollection(userId).doc(taskId).delete();
  }
  static Future<void> doneTask({required String userId , required String taskId , required bool isDone}) async {
    await getTaskCollection(userId).doc(taskId).update({
      "isDone" : isDone
    });
  }
  static Future<void> editTask({required String userId , required String taskId ,required String title ,required String description,required int date,required int time}) async {
    await getTaskCollection(userId).doc(taskId).update({
      "title" : title,
      "description" : description,
      "date" : date,
      "time" : time,
    });
  }

}