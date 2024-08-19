import 'package:flutter/material.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/ui/common/password.dart';
import '../common/email.dart';
import '../imagePath.dart';
import '../register/register_screen.dart';

class LogInScreen extends StatelessWidget {
  static const String routeName = '/';
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff5D9CEC),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 50, left: 12, right: 12),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(
                    getFullPath('route_logo.png'),
                    width: double.infinity,
                  ),
                  Email(),
                  //
                  const SizedBox(
                    height: 18,
                  ),
                  Password(),
                  //
                  const SizedBox(
                    height: 18,
                  ),
                  //
                  ElevatedButton(
                    onPressed: () {
                      logIn();
                     // Navigator.pushReplacementNamed(context, HomeScreen.routeName);
                    },
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        backgroundColor: Colors.white),
                    child: Text(
                      'Log In',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: MyThemeData.lightPrimary),
                    ),
                  ),
                  //
                  const SizedBox(
                    height: 18,
                  ),
                  //
                  InkWell(
                    onTap:(){
                      Navigator.pushReplacementNamed(context, RegisterScreen.routeName);
                    },
                    child:  const Row(mainAxisAlignment:MainAxisAlignment.center,
                      children: [
                         Text('Do not have an account? ',
                           style: TextStyle(color: Colors.white),),
                         Text('Create Account',
                             style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  void logIn() {
    formKey.currentState?.validate();
  }
}
