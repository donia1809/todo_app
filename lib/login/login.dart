
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common_widgets/dialogs.dart';
import '../common_widgets/email.dart';
import '../common_widgets/password.dart';
import '../functions.dart';
import '../home_screen.dart';
import '../main.dart';
import '../providers/AppAuthProvider.dart';
import '../register/register_screen.dart';

class LogInScreen extends StatefulWidget {
  static const String routeName = '/';

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
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
    if(formKey.currentState?.validate() == false){
      return;
    }
    signIn();
  }

  void signIn() async {
    var authProvider =Provider.of<AppAuthProvider>(context,listen: false);
    try {
      showLoadingDialog(context, message: 'please wait...');
      final credential = await authProvider.signInWithEmailAndPassword(
           Email.email.text,
           Password.password.text);

      hideLoading(context);
      showMessageDialog(context,
          message: "Something went wrong",
          posButtonTitle: 'try again', posButtonAction: () {
            signIn();
          });
      showMessageDialog(context, message: "Logged in successfully",
          posButtonTitle: 'ok',
          posButtonAction: (){
            Navigator.pushReplacementNamed(context, HomeScreen.routeName);
          });
    }

    on FirebaseAuthException catch (e) {
      String message = 'Something went Wrong';

      print(e.code);
      if(e.code == 'user-not-found' ||
          e.code =='wrong-password' ||
          e.code == 'invalid-credential'
      ){
        message = 'Wrong Email or Password';
      }
      hideLoading(context);
      showMessageDialog(context, message: message,posButtonTitle: "ok");
    }

    catch (e) {
      String message = 'Something went Wrong..';
      hideLoading(context);
      showMessageDialog(context, message: message, posButtonTitle: "try again",
          posButtonAction: () {
            logIn();
          });
    }
  }
}