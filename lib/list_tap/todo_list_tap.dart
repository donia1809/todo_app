import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:new_application/database/collection/tasks-collection.dart';
import 'package:new_application/date-time.dart';
import 'package:new_application/list_tap/tasks-list.dart';
import 'package:provider/provider.dart';

import '../common_widgets/dialogs.dart';
import '../database/models/tasks.dart';
import '../providers/AppAuthProvider.dart';
import '../providers/tasks-provider.dart';


class ListTab extends StatefulWidget {
  const ListTab({super.key});

  @override
  State<ListTab> createState() => _ListTabState();
}

class _ListTabState extends State<ListTab> {
  List<Task>? tasksList;

  late AppAuthProvider authProvider;
  late TasksProvider tasksProvider;

  @override
  void initState() {
    super.initState();
    authProvider = Provider.of<AppAuthProvider>(context, listen: false);
  }

  var selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    tasksProvider =  Provider.of<TasksProvider>(context);
    return Column(
      children: [
        EasyDateTimeLine(
          initialDate: selectedDate,
          onDateChange: (clickedDate) {
            setState(() {
              selectedDate = clickedDate;
            });
          },
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot<Task>>(
            stream: TasksCollection.listenForTasks(
                authProvider.authUser?.uid ??"" , selectedDate.dateOnly()),
            builder: (buildContext, snapshot) {
              if (snapshot.hasError) {
                // handle error
                return Center(
                  child: Column(
                    children: [
                      const Text("Something went wrong"),
                      ElevatedButton(
                          onPressed: () {
                            setState(() {});
                          },
                          child: const Text("Try again"))
                    ],
                  ),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                // waiting for future to get data // like await for future
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              // you have data
              var tasksList = snapshot.data?.docs.map((doc) => doc.data()).toList();

              return ListView.separated(
                  itemBuilder: (context, index) {
                    return TaskItem(
                      task: tasksList![index],
                      onDeleteClick: deleteTask,
                    );
                  },
                  separatorBuilder: (_, __) => Container(
                    height: 24,
                  ),
                  itemCount: tasksList?.length ?? 0);
            },
          ),
        ),
      ],
    );
  }

  void deleteTask(Task task) async {
    showLoadingDialog(context, message: "please wait...");
    try {
      await tasksProvider.removeTask(authProvider.authUser?.uid ?? "", task);
      hideLoading(context);
      setState(() {});
    } catch (e) {
      showMessageDialog(context,
          message: "Something went wrong ${e.toString()}",
          posButtonTitle: "retry", posButtonAction: () {
            deleteTask(task);
          });
    }
  }
}