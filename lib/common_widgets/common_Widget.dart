import 'package:flutter/material.dart';

typedef Validator = String?Function( String? text) ;
class TextFormFieldWidget extends StatefulWidget{
  String text;
  String hintText;
  TextInputType keyboardType;
  bool securedPassword;
  Validator? validator;
  TextEditingController? controller;
  TextFormFieldWidget({super.key,
    required this.text,
    required this.hintText,
    this.keyboardType=TextInputType.text,
    this.securedPassword=false,
    this.validator,
    this.controller
  });


  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  bool isVisibleText=true;
  @override
  void initState(){
    super.initState();
    isVisibleText=widget.securedPassword;
  }
  @override
  Widget build(BuildContext context) {
    return Container(margin: EdgeInsets.symmetric(vertical: 6),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.text,
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 10,),
          TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              hintText: widget.hintText,
              hintStyle: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              fillColor: Colors.white,
              filled: true,
              suffixIcon: widget.securedPassword? InkWell(
                onTap: (){
                  setState(() {
                    isVisibleText=!isVisibleText;
                  });
                },
                child: Icon(isVisibleText?Icons.visibility_off_outlined
                :Icons.visibility,
                  color: const Color(0xff5D9CEC)),
              )
                  :null,
            ),
            keyboardType: widget.keyboardType,
            obscureText:isVisibleText ,
            validator: widget.validator,
            controller: widget.controller,
          )
        ],
      ),
    );
  }
}