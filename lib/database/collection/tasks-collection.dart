import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/tasks.dart';

class TasksCollection{

  static CollectionReference<Task> getTasksCollection(userId){
    var db = FirebaseFirestore.instance;
    return db.collection("users")
        .doc(userId)
        .collection("tasks")
        .withConverter(
        fromFirestore: (snapshot, options) {
          return Task.fromFireStore(snapshot.data());
        },
        toFirestore: (task, options) {
          return task.toFireStore();
        });
  }

  static Future<void> createTask(String userId, Task task){

    var docRef = getTasksCollection(userId)
        .doc();// id auto generated
    task.id = docRef.id;
    return docRef.set(task);

  }

  static Future<List<Task>> getAllTasks(String userId, int selectedDate)async{
    var querySnapshot = await getTasksCollection(userId)
        .where('date',isEqualTo: selectedDate)
        .orderBy('time',descending: false)
        .get();
    var tasksList = querySnapshot.docs.map((docSnapshot) => docSnapshot.data())
        .toList();
    return tasksList;
  }

  static  Stream<QuerySnapshot<Task>> listenForTasks(String userId, int selectedDate)async*{

    yield* getTasksCollection(userId)
        .where('date',isEqualTo: selectedDate)
        .orderBy('time',descending: false)
        .snapshots();

  }

  static Future<void> removeTask(String userId, Task task) {
    var docRef = getTasksCollection(userId)
        .doc(task.id??"");
    return docRef.delete();
  }

 static Future<void> editIsDone(String userId, Task task){
    return getTasksCollection(userId).doc(task.id).update({
      "isDone": task.isDone,
    });
  }

  static Future<void> editTask(String userId, Task task){
    return getTasksCollection(userId).doc(task.id).update(task.toFireStore());
  }
}