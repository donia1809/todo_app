import 'package:flutter/material.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/ui/common/password.dart';
import 'package:todo_app/ui/logIn/LogIn_screen.dart';
import '../common/email.dart';
import '../common/info.dart';
import '../imagePath.dart';

class RegisterScreen extends StatelessWidget {
  static const String routeName = 'register_Screen';
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
                  Name(),
                  //
                  const SizedBox(
                    height: 18,
                  ),
                  //
                  PhoneNumber(),
                  //
                  const SizedBox(
                    height: 18,
                  ),
                  //
                  Email(),
                  //
                  const SizedBox(
                    height: 18,
                  ),
                  //
                 Password(),
                  //
                  const SizedBox(
                    height: 18,
                  ),
                  //
                  ConfirmationPassword(),
                  //
                  const SizedBox(
                    height: 18,
                  ),
                  //
                  ElevatedButton(
                    onPressed: () {
                      register();
                     // Navigator.pushReplacementNamed(context, HomeScreen.routeName);
                    },
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        backgroundColor: Colors.white),
                    child: Text(
                      'Sign In',
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
                      Navigator.pushReplacementNamed(context, LogInScreen.routeName);
                    },
                    child:  const Row(mainAxisAlignment:MainAxisAlignment.center,
                      children: [
                        Text('Do you have an account? ',
                          style: TextStyle(color: Colors.white),),
                        Text('LogIn',
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                  //
                  const SizedBox(
                    height: 18,
                  ),
                  //
                ],
              ),
            ),
          ),
        ));
  }

  void register() {
    formKey.currentState?.validate();
  }
}
