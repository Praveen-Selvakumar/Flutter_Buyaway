// main.dart
import 'package:flutter/material.dart';
  
 
 
 
class CustomButton extends StatelessWidget {

   final String inputText ; 

   const CustomButton({required this.inputText});

  @override
  Widget build(BuildContext context) {
     return Container(       
       width: double.infinity,
       margin: EdgeInsets.all(20.0),
       child: Align(
         alignment: Alignment.center,
         child: Text(inputText),
       ),
     );
  }
   
}
 
 