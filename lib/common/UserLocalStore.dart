import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui_demo_1/ModelClass/TotalModel.dart';

class UserLocalStore  {  

   UserLocalStore();

  /* static StoreUserData(TotalModel model) async{
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString("name", model.name);
      pref.setString("email",model.email);
      pref.setString("number", model.contact_number);
    //  pref.setString("password", model.password);
      pref.setString("gender", model.gender);
         
   }*/

   static  getStoredData(String key ) async{
   SharedPreferences pref = await SharedPreferences.getInstance();
   return pref.getString(key) ;
   }

    
  
}


 

