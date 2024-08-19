import 'package:flutter/material.dart';

import '../imagePath.dart';
import 'common_Widget.dart';

class Name extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
  return Column(
    children: [
      TextFormFieldWidget(
          text: 'Full Name',
          hintText: 'Please Enter Your Full Name',
          validator: (text) {
            if (text?.trim().isEmpty == true) {
              return 'Please Enter Full Name';
            }
            return null;
          }),
    ],
  );
  }
}

class PhoneNumber extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
return  TextFormFieldWidget(
    text: 'Phone Number',
    hintText: 'Please Enter Your Phone Number',
    keyboardType: TextInputType.number,
    validator: (text) {
      if (text?.trim().isEmpty == true) {
        return 'Please Enter Full Number';
      }
      if (!isValidPhoneNumber(text!)) {
        return 'Please Enter Valid Number';
      }
      if (text.length != 11) {
        return 'Please Enter Right Number';
      }
      return null;
    });
  }

}