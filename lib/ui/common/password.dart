import 'package:flutter/material.dart';

import '../imagePath.dart';
import 'common_Widget.dart';

class Password extends StatelessWidget
{
  static TextEditingController password = TextEditingController();

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
             if (text.length < 6) {
               return 'Weak password!! Enter Strong One';
             }
             return null;
           }),
     ],
   );
  }
}
class ConfirmationPassword extends StatelessWidget
{
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
       });
  }

}