import 'package:flutter/material.dart';
import 'package:todo_app/ui/listTab/todoListTab.dart';
import 'package:todo_app/ui/settingsTab/todoSettingsTab.dart';

class HomeScreen extends StatefulWidget
{
  static const String routeName = 'home_Screen';
   const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
int selectedIndex = 0;
var tabs=[ListTab(),SettingsTab()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
          toolbarHeight:157,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: const StadiumBorder(
            side: BorderSide(
                color: Colors.white,
                 width: 4)),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index){
            setState(() {
              selectedIndex=index;
            });
          },
          items: const [
          BottomNavigationBarItem(icon:Icon(Icons.list),label: ''),
          BottomNavigationBarItem(icon:Icon(Icons.settings),label: ''),
        ],

        ),
      ),
      body: tabs[selectedIndex],

    );
  }
}
