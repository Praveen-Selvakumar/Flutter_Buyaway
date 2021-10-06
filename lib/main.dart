import 'package:flutter/material.dart';
//FOR CHNAGING STATUS BAR COLOR
import 'package:flutter/services.dart';
import 'package:ui_demo_1/login_frame/edit_profile_page.dart';
import 'package:ui_demo_1/login_frame/login_page.dart';
import 'package:ui_demo_1/login_frame/register_page.dart';
import 'package:ui_demo_1/mainframe/home_page.dart';
import 'package:ui_demo_1/mainframe/offers_page.dart';
import 'package:ui_demo_1/mainframe/search_page.dart';
import 'package:ui_demo_1/test_pack/temp.dart';
import 'package:ui_demo_1/test_pack/test.dart';
import 'package:ui_demo_1/test_pack/test_ui.dart';
import 'common/UserLocalStore.dart';
import 'common/bottom_bar.dart';
import 'login_frame/change_password.dart';
import 'login_frame/forgot_password.dart';


void main() {

  Color myHexColor = Color(0xff40BFFF);

  //Now we use SystemChrome
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: myHexColor,
    statusBarIconBrightness: Brightness.light
    ));
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Buyaway",
    home: test_ui(),
   ));
}



 

 