import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ui_demo_1/common/search_bar.dart';
import 'package:ui_demo_1/login_frame/edit_profile_page.dart';
import 'package:ui_demo_1/mainframe/offers_page.dart';
import 'package:ui_demo_1/mainframe/search_page.dart';


class home_page extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => home_page_();
}

class home_page_ extends State<home_page>{   
  @override
  Widget build(BuildContext context) {
      return MaterialApp(
       home: Scaffold(
          body: Container(
            margin: EdgeInsets.only(left: 20,right: 20,top: 60),
            child: Column(
              children: <Widget>[
                 Search_bar(inputText: "Search Product" )
              ],
            ),
     ),
       ),       
     );
  }

}