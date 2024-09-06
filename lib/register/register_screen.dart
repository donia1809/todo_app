
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_application/common_widgets/dialogs.dart';
import 'package:new_application/providers/AppAuthProvider.dart';
import 'package:provider/provider.dart';

import '../common_widgets/email.dart';
import '../common_widgets/info.dart';
import '../common_widgets/password.dart';
import '../functions.dart';
import '../home_screen.dart';
import '../login/login.dart';
import '../main.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'register_Screen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
   if (formKey.currentState?.validate() == false)return;
   createAccount();
  }

  void createAccount()async {
   var authProvider = Provider.of<AppAuthProvider>(context,listen: false);
    try {
     showLoadingDialog(context, message: 'please wait...');

     final appUser = await authProvider.createUserWithEmailAndPassword(
         Email.email.text, Password.password.text, Name.fullName.text);
     hideLoading(context);
     if (appUser == null) {
       showMessageDialog(context,
           message: "Something went wrong",
           posButtonTitle: 'try again', posButtonAction: () {
             createAccount();
           });
       return;
     }

     showMessageDialog(context,
         message: "User created successfully",
         posButtonTitle: 'ok', posButtonAction: () {
           Navigator.pushReplacementNamed(context, HomeScreen.routeName);
         });
    }
    on FirebaseAuthException catch (e) {
      String message = 'Something went Wrong';
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'The account already exists for that email.';
      }
      hideLoading(context);
      showMessageDialog(context, message: message, posButtonTitle: "ok");
    }
    catch (e) {
      String message = 'Something went Wrong';
      hideLoading(context);
      showMessageDialog(context, message: message, posButtonTitle: "try again",
          posButtonAction: () {
            register();
          });
    }
  }
}
