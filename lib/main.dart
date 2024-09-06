import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:new_application/providers/AppAuthProvider.dart';
import 'package:new_application/providers/tasks-provider.dart';
import 'package:new_application/providers/theme_provider.dart';
import 'package:new_application/register/register_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'edit_task/edit_task_screen.dart';
import 'firebase_options.dart';
import 'home_screen.dart';
import 'login/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var sharedPreference = await SharedPreferences.getInstance();

  await Firebase.initializeApp(
    name: "todoapp",
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
      providers: [
      ChangeNotifierProvider(create: (_) => AppAuthProvider()),
      ChangeNotifierProvider(create: (_) => TasksProvider()),
      ChangeNotifierProvider(create: (_) => ThemeProvider(sharedPreference)),  ],
  child: const MyApp()));
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'Todo App',
      debugShowCheckedModeBanner: false,
      theme: MyThemeData.lightTheme,
      darkTheme: MyThemeData.darkTheme,
      themeMode: themeProvider.currentTheme,

      initialRoute: LogInScreen.routeName,
      routes:
      {
        HomeScreen.routeName: (_)=> HomeScreen(),
        RegisterScreen.routeName: (_)=>  RegisterScreen(),
        LogInScreen.routeName: (_)=>  LogInScreen(),
        EditTaskScreen.routeName: (_)=>  EditTaskScreen(),

      },
    );
  }
}
//////////////////////////////////////////////////////////////
class MyThemeData{
  static Color defaultBackground=  const Color(0xffDFECDB);
  static Color lightPrimary= const Color(0xff5D9CEC);
  static const Color darkPrimary = Color(0xff141922);
  static final ThemeData lightTheme=ThemeData(
    appBarTheme: AppBarTheme(
        color: lightPrimary,
        titleTextStyle:const TextStyle(
          fontSize: 22,
          color:Colors.white,
          fontWeight: FontWeight.w700,
        )
    ),
    scaffoldBackgroundColor: defaultBackground,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
      elevation: 0,
      selectedItemColor:lightPrimary,
      unselectedItemColor: Colors.grey,
    ),
    textTheme: TextTheme(
      titleLarge: const TextStyle(
        fontSize: 18,
        color:darkPrimary,
        fontWeight: FontWeight.w700,
      ),
      titleMedium: const TextStyle(
        fontSize: 14,
        color:darkPrimary,
        fontWeight: FontWeight.w700,
      ),
      bodyMedium: TextStyle(
          fontSize: 14,
          color: lightPrimary,
          fontWeight: FontWeight.w400
      ),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: lightPrimary,
      primary: lightPrimary,
      onPrimary: Colors.white,
    ),
  );
  static final ThemeData darkTheme=ThemeData(
    appBarTheme: AppBarTheme(
        color: lightPrimary,
        titleTextStyle:const TextStyle(
          fontSize: 22,
          color:Colors.white,
          fontWeight: FontWeight.w700,
        )
    ),
    scaffoldBackgroundColor: darkPrimary,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
      elevation: 0,
      selectedItemColor:lightPrimary,
      unselectedItemColor: Colors.grey,
    ),
    textTheme: TextTheme(
      titleLarge: const TextStyle(
        fontSize: 18,
        color:Colors.white,
        fontWeight: FontWeight.w700,
      ),
      titleMedium: const TextStyle(
        fontSize: 14,
        color: Colors.white,
        fontWeight: FontWeight.w700
      ),
      bodyMedium: TextStyle(
          fontSize: 14,
          color: lightPrimary,
          fontWeight: FontWeight.w400
      ),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: darkPrimary,
      primary: darkPrimary,
      onPrimary: Colors.white,
    ),
    floatingActionButtonTheme:  FloatingActionButtonThemeData(
      foregroundColor: lightPrimary
    ),

  );
}