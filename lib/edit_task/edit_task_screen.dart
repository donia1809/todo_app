import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../database/collection/tasks-collection.dart';
import '../date-time.dart';
import '../common_widgets/date-time-feild.dart';
import '../common_widgets/dialogs.dart';
import '../common_widgets/material-textForm.dart';
import '../database/models/tasks.dart';
import '../providers/AppAuthProvider.dart';
import '../providers/tasks-provider.dart';

class EditTaskScreen extends StatefulWidget {
  EditTaskScreen({super.key});

  static const String routeName = 'edit_Screen';

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  var title = TextEditingController();
  var description = TextEditingController();
  var formKey = GlobalKey<FormState>();
  late Task taskModel;

@override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((duration){
      taskModel = ModalRoute.of(context)!.settings.arguments as Task;
      title.text = taskModel.title??'';
      description.text = taskModel.description??'';
      selectedDate = (taskModel.date?? DateTime.now()) as DateTime?;
      selectedTime = (taskModel.time?? TimeOfDay.now()) as TimeOfDay?;
      setState(() {});
    });
  }
  @override
  Widget build(BuildContext context) {

    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('To Do List'),
        toolbarHeight: 150,
      ),
      body: Stack(children: [
        Container(
          color: Theme.of(context).primaryColor,
          height: screenSize.height * .1,
        ),
        Container(
          height: screenSize.height*.7,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,

          ),
          margin: EdgeInsets.symmetric(horizontal: screenSize.width *.07, vertical: screenSize.height *.02),
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    "Edit Task",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  MaterialTextFormField(
                    hint: "Task title",
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return "please enter task title";
                      }

                      return null;
                    },
                    controller: title,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  MaterialTextFormField(
                    hint: "Task Description",
                    lines: 3,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return "please enter task description";
                      }
                      return null;
                    },
                    controller: description,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: DateTimeField(
                        title: "Task Date",
                        hint: selectedDate == null
                            ? "select date"
                            : "${selectedDate?.formatDate()}",
                        onClick: () {
                          showDatePickerDialog();
                        },
                      )),
                      Expanded(
                          child: DateTimeField(
                        title: "Task Time",
                        hint: selectedTime == null
                            ? "select time"
                            : "${selectedTime?.formatTime()}",
                        onClick: () {
                          showTimePickerDialog();
                        },
                      ))
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        EditTask();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff5D9CEC),
                      ),
                      child: Text("Save Changes",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(color: Colors.white)))
                ],
              ),
            ),
          ),
        )
      ]),
    );
  }

  DateTime? selectedDate;

  void showDatePickerDialog() async {
    var date = await showDatePicker(
        context: context,
        initialDate: selectedDate ?? DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (date == null) return;

    setState(() {
      selectedDate = date;
    });
  }

  TimeOfDay? selectedTime;

  void showTimePickerDialog() async {
    var time = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (time == null) return;
    setState(() {
      selectedTime = time;
    });
  }

  bool isValidTask() {
    bool isValid = true;
    if (formKey.currentState?.validate() == false) {
      isValid = false;
    }
    if (selectedDate == null) {
      showMessageDialog(context,
          message: "Please select task date", posButtonTitle: "ok");
      isValid = false;
    }
    if (selectedTime == null) {
      showMessageDialog(context,
          message: "Please select task time", posButtonTitle: "ok");
      isValid = false;
    }
    return isValid;
  }

  void EditTask() async {
    if (isValidTask() == false) return;

    var authProvider = Provider.of<AppAuthProvider>(context, listen: false);
    var tasksProvider = Provider.of<TasksProvider>(context, listen: false);

     taskModel.title = title.text;
     taskModel.description= description.text;
     taskModel.date= selectedDate?.dateOnly();
     taskModel.time= selectedTime?.timeSinceEpoch();

    try {
      showLoadingDialog(context, message: "Editing task please wait");
      var result = await TasksCollection.editTask(
          authProvider.appUser?.authId ?? "", taskModel);
      hideLoading(context);
      showMessageDialog(context,
          message: "Task edit successfully",
          posButtonTitle: "ok", posButtonAction: () {
        Navigator.pop(context);
      });
    } catch (e) {
      hideLoading(context);
      showMessageDialog(context, message: e.toString(), posButtonTitle: "ok");
    }
  }
}
