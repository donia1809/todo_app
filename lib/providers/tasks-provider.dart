
import 'package:flutter/cupertino.dart';
import 'package:new_application/date-time.dart';
import 'package:provider/provider.dart';

import '../database/collection/tasks-collection.dart';
import '../database/models/tasks.dart';

class TasksProvider extends ChangeNotifier{

  var tasksCollection = TasksCollection();
  Future<List<Task>> getAllTasks(String userId,
      DateTime selectedDate)async{
    var tasksList = await TasksCollection.getAllTasks(userId,
        selectedDate.dateOnly());
    return tasksList;
  }
  Future<void> removeTask(String userId,Task task)async{
    await TasksCollection.removeTask(userId, task);
    notifyListeners();
    return;
  }
  Future<void> addTask(String userId,Task task)async{
    await TasksCollection.createTask(userId, task);
    notifyListeners();
    return;
  }

  static TasksProvider getInstance(BuildContext context,
      {bool listen = true}){
    return Provider.of<TasksProvider> (context,listen: listen);
  }

}