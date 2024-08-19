import 'package:flutter/material.dart';
import 'package:todo_app/ui/logIn/LogIn_screen.dart';
import 'package:todo_app/ui/register/register_screen.dart';
import 'homeScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      debugShowCheckedModeBanner: false,
      theme: MyThemeData.lightTheme,

     // initialRoute: RegisterScreen.routeName,
      routes:
      {
        HomeScreen.routeName: (_)=> HomeScreen(),
        RegisterScreen.routeName: (_)=>  RegisterScreen(),
        LogInScreen.routeName: (_)=>  LogInScreen(),
      },
    );
  }
}
//////////////////////////////////////////////////////////////
class MyThemeData{
  static Color defaultBackground=  const Color(0xffDFECDB);
  static Color lightPrimary= const Color(0xff5D9CEC);
  static final ThemeData lightTheme=ThemeData(
    appBarTheme: AppBarTheme(
        color: lightPrimary
    ),
    scaffoldBackgroundColor: defaultBackground,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
      elevation: 0,
      selectedItemColor:lightPrimary,
      unselectedItemColor: Colors.grey,
    ),
    textTheme: const TextTheme(
      titleMedium: TextStyle(
        fontSize: 18,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: TextStyle(
          fontSize: 18,
          color: Colors.black,
          fontWeight: FontWeight.normal
      ),
    ),
  );
}