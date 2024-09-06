import 'package:flutter/material.dart';
import '../functions.dart';
import 'common_Widget.dart';

class Password extends StatelessWidget
{
  static TextEditingController password = TextEditingController();
  static TextEditingController confirmationPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
   return Column(
     children: [
       TextFormFieldWidget(
           text: 'Password',
           hintText: 'Please Enter Your Password',
           securedPassword: true,
           validator: (text) {
             if (text?.trim().isEmpty == true) {
               return 'Please Enter Your Password';
             }
             if (!isValidPassword(text!)) {
               return 'Please Enter Valid Password';
             }

             return null;
           },
       controller:password,),
     ],
   );
  }
 }

class ConfirmationPassword extends StatelessWidget
{  static TextEditingController confirmationPassword = TextEditingController();

@override
  Widget build(BuildContext context) {
   return  TextFormFieldWidget(
       text: 'Confirmation Password',
       hintText: 'Please Enter Your Confirmation Password',
       securedPassword: true,
       validator: (text) {
         if (text?.trim().isEmpty == true) {
           return 'Please Enter Your Password';
         }

         if (Password.password.text != text) {
           return 'Password Does not match!! ';
         }
         return null;
       },
        controller: confirmationPassword);
  }

}