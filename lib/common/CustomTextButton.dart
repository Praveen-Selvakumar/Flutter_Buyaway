import 'package:flutter/material.dart';
import 'package:ui_demo_1/mainframe/home_page.dart';


class CustomTextButtom extends StatelessWidget{

   final String inputText ; 
   final Navigator navigator;
   final TextStyle style_;
   const CustomTextButtom({ required this.inputText, 
   required this.navigator , required this.style_ });

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: (){
       navigator;
    }, child: Text(inputText, style: style_  ));
  }

}