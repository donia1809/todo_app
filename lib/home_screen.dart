

import 'package:flutter/material.dart';
import 'package:new_application/providers/AppAuthProvider.dart';
import 'package:new_application/settings_tap/todo_settigs_tap.dart';
import 'package:provider/provider.dart';

import 'add-task.dart';
import 'list_tap/todo_list_tap.dart';
import 'login/login.dart';

class HomeScreen extends StatefulWidget
{
  static const String routeName = 'home_Screen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  var tabs = [ListTab(), SettingsTab()];

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppAuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome : ${provider.appUser?.fullName}"),
        actions: [
          InkWell(
              onTap: (){
                provider.logout();
                Navigator.pushReplacementNamed(context, LogInScreen.routeName);
              },
              child: Icon(Icons.logout))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddTaskBottomSheet();
        },
        shape: const StadiumBorder(
            side: BorderSide(
                color: Colors.white,
                width: 4)),
        child: const Icon(Icons.add,color: Colors.white,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: SingleChildScrollView(
          child: BottomNavigationBar(
            currentIndex: selectedIndex,
            onTap: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.list),
                  label: 'list',),

              BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'setting',),
            ],

          ),
        ),
      ),
      body: tabs[selectedIndex],

    );
  }

  void showAddTaskBottomSheet() {
    showModalBottomSheet(context: context, builder: (buildContext) {
      return AddTaskBottomSheet();
    });
  }
}