import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:new_application/database/collection/tasks-collection.dart';
import 'package:new_application/edit_task/edit_task_screen.dart';
import 'package:new_application/main.dart';
import 'package:new_application/providers/tasks-provider.dart';
import 'package:provider/provider.dart';
import '../common_widgets/dialogs.dart';
import '../database/models/tasks.dart';
import '../functions.dart';
import '../date-time.dart';
import '../providers/AppAuthProvider.dart';

typedef OnTaskDeleteClick = void Function(Task task);
class TaskItem extends StatefulWidget {

  Task task;
  OnTaskDeleteClick onDeleteClick;
  TaskItem({required this.task,required this.onDeleteClick});

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AppAuthProvider>(context);
    var taskProvider = Provider.of<TasksProvider>(context);
    String? userId = authProvider.authUser?.uid;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      child: Slidable(
        startActionPane: ActionPane(
          motion: const DrawerMotion(),
          children: [
            SlidableAction(onPressed: (buildContext){
              // delete
              showMessageDialog(context, message:
              "Are you sure to delete this task ?",
                  posButtonTitle: "Yes",
                  posButtonAction:(){
                    // delete Task
                    widget.onDeleteClick(widget.task);
                  },
                  negButtonTitle: "cancel"
              );
            },
              icon: Icons.delete,
              backgroundColor: Colors.red,
              label: 'delete',
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
            )
          ],
        ),

        child: Card(

          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)
          ),
          color: Colors.white,
          child:
          InkWell(
            onTap: (){
              Navigator.pushNamed(context, EditTaskScreen.routeName,
              arguments: widget.task);
            },
            child:
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 24
              ),
              child: Row(
                children: [
                  Container(width: 4,height: 64,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: widget.task.isDone==false? MyThemeData.lightPrimary
                          :Colors.green)
                  ),
                  const SizedBox(width: 12,),
                  Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:[
                            Text('${widget.task.title}',
                              style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(color: widget.task.isDone==false? MyThemeData.lightPrimary
                              :Colors.green),
                            ),
                            const SizedBox(height: 8,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(Icons.watch_later_outlined),
                                const SizedBox(width: 8,),

                                Text('${widget.task.time?.formatTime()}',
                                  style: Theme.of(context).textTheme.bodySmall,
                                )

                              ],)
                          ]
                      )),
                  const SizedBox(width: 12,),

                  InkWell(
                    onTap: (){
                      widget.task.isDone = !widget.task.isDone!;
                      TasksCollection.editIsDone(userId!,widget.task);
                      setState(() {});
                    },
                    child: widget.task.isDone ==true?
                        Text("Done !",style:TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: widget.task.isDone==false? MyThemeData.lightPrimary
                            :Colors.green))
                    :Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24,
                          vertical: 8),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child:ImageIcon(
                        AssetImage(getFullPath('icon_check.png'),),
                        color: Colors.white,
                      ),),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}