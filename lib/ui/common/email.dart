import 'package:flutter/material.dart';

import '../imagePath.dart';
import 'common_Widget.dart';

class Email extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
   return  TextFormFieldWidget(
       text: 'Email',
       hintText: 'Please Enter Your Email',
       keyboardType: TextInputType.emailAddress,
       validator: (text) {
         if (text?.trim().isEmpty == true) {
           return 'Please Enter Valid Email';
         }
         if (!isValidEmail(text!)) {
           return 'Please Enter Valid Email';
         }
         return null;
       });
  }

}