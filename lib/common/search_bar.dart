import 'package:flutter/material.dart';


class Search_bar extends StatelessWidget{

    final String inputText ;

    const Search_bar({ required this.inputText});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20,right: 20),
      child: TextFormField(
         decoration: InputDecoration(
          suffixIcon: Icon(Icons.search),
            fillColor: Colors.transparent, filled: true,         
             labelText: inputText
            , labelStyle: TextStyle(color: Colors.grey[350],fontFamily: 'Poppins',fontSize: 14),
            border: UnderlineInputBorder(
                 borderSide: BorderSide.none,
                 ), floatingLabelBehavior: FloatingLabelBehavior.never,
        ),
        
      ),
    );
  }

}