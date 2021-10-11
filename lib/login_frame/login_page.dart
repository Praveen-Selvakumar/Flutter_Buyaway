import 'dart:async';
import 'dart:async';
import 'dart:core';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui_demo_1/common/UserLocalStore.dart';
import 'package:ui_demo_1/common/bottom_bar.dart';
import 'package:ui_demo_1/login_frame/edit_profile_page.dart';
import 'package:ui_demo_1/login_frame/forgot_password.dart';
import 'package:ui_demo_1/login_frame/register_page.dart';
import 'package:ui_demo_1/main.dart';
import 'package:ui_demo_1/mainframe/home_page.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert';


class login_page extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => login_page_();  
}

Future<UserModel>  load_login(String number, String pwd) async{

  final String apiUrl = "http://webbuyaway.buyaway.in/api/APIMobileAccount/UserLogin";

  final response = await http.post(Uri.parse(apiUrl), body: {
     "contact_number" : number,
     "password" : pwd
  });

      Map<String, dynamic> data = new Map<String, dynamic>.from(json.decode(response.body));
     UserModel model = new UserModel( data['status'],data['message'] , 
                               data['user_check'] ,data['contact_number'] );
      return model;              
}


class login_page_ extends State<login_page>{  

     

      Color btn_clr = Color(0xff1a95d1);
      GlobalKey<FormState> formkey = new GlobalKey();
       //CONTROLLER FOR TEXTFORM_FIELD
       final get_number_ = new TextEditingController();

       final get_password_ = new TextEditingController();
       //DECLARE MODEL CLASS
       UserModel model_cl = new UserModel( "", "", "", "");

      bool _obscureText = true;

         @override
         void initState()
         {
          super.initState();
          isUserLogged();              
         }  

       //PASSWORD VISIBILITY
       void _togglePasswordStatus() {
             setState(() {
             _obscureText = !_obscureText;
    });
  }       

  void StoreData(String number_) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("number", number_);
    preferences.commit();
  }       

  void isUserLogged() async{
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String  getNumber = preferences.getString("number").toString();
      if(getNumber != null ){
         pushToHome(getNumber);
      }
  }     

   void pushToHome(String contact_number){
     StoreData(contact_number);   
     Navigator.push(context, (MaterialPageRoute(
       builder: (context) =>  btm_app_bar()
       ) ));
        get_number_.text = "";
        get_password_.text = "";
   }

  @override
  Widget build(BuildContext context) {
     return Scaffold(       
         resizeToAvoidBottomInset : true,//FOR AVOIDING DISPLAYING WIDGET OVER THE KEYPAD
          body: SingleChildScrollView(                      
               child: Container(
                 padding:EdgeInsets.fromLTRB(20, 0, 20, 0) ,
                 child: Form(
                   key: formkey,
                   child: Theme(
                          data:Theme.of(context).copyWith(
                          colorScheme: ThemeData().colorScheme.copyWith(
                          primary:Colors.grey,),),
                     child: Column(
                       children: <Widget>[
                         Align(
                           alignment: Alignment.center,
                           child:  Image.asset('assets/buyaway.png',width: 300,height: 300),
                         ),
                         SizedBox(
                           height: 30,
                         ),
                         new Container(
                           child: TextFormField(
                             controller: get_number_,
                             keyboardType: TextInputType.number,
                             inputFormatters: [new LengthLimitingTextInputFormatter(10),],
                             style: TextStyle(color: Colors.black,fontFamily: 'Poppins',fontSize: 14 ),
                             decoration: InputDecoration(prefixIcon: Icon(Icons.call),                              
                             border: UnderlineInputBorder(),labelText: 'Primary Number',
                             ), 
                             validator: (value){
                               if(value!.isEmpty){
                                 return "Enter Primary Number";
                               }else if(value.length < 10){
                                 return "Enter valid Primary Number";
                               }
                               return null;
                             }, 
                           ),
                         ),
                         SizedBox(
                           height: 20,
                         ),
                         new Container(
                           child: TextFormField(
                             controller: get_password_,
                             obscureText: _obscureText,
                             style: TextStyle(color: Colors.black,fontFamily: 'Poppins',fontSize: 14 ),
                             decoration: InputDecoration(prefixIcon: Icon(Icons.lock),                              
                             border: UnderlineInputBorder(),labelText: 'Password',
                             suffixIcon: IconButton(onPressed:  _togglePasswordStatus,
                              icon: Icon(_obscureText  ?  Icons.visibility : Icons.visibility_off))
                             ), 
                            validator: (value){
                               if(value!.isEmpty){
                                 return "Enter E-mail Id";
                               }
                               return null;
                             }, 
                           ),
                         ),
                         SizedBox(height: 30,),
                         SizedBox(
                           width: double.infinity,
                           child: Container(
                             child: ElevatedButton(
                               onPressed: () async {                                     
                                   if(formkey.currentState!.validate()){   
                                        UserModel? model = await load_login(get_number_.text,get_password_.text);  
                                        if(model != null ){
                                           model_cl = model ;
                                           if(model_cl.status.contains("Success")){
                                                pushToHome(model.contact_number);
                                                Fluttertoast.showToast(msg: "Logged in SuccesFully");
                                             } 
                                         }                                    
                                       }else{
                                      Fluttertoast.showToast(msg: "Something gone wrong..!");
                                    }  
                                },
                                 child: Text("LOGIN",style: TextStyle(color: Colors.white, fontFamily: 'Poppins'),),
                                 style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(btn_clr)),
                               ),
                           ), 
                         ),
                         SizedBox(height: 30,),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: <Widget>[
                             TextButton(onPressed: (){
                               Navigator.push(context, 
                               MaterialPageRoute(builder: (context) => register_page() ));
                             },
                              child: Text('Sign up here',style: TextStyle(color: btn_clr ))),                    
                             Text(' | ',style: TextStyle(color: Colors.black )),
                             TextButton(onPressed: (){                         
                               Navigator.push(context,
                               MaterialPageRoute(builder: (context) => forgot_password() ) );                
                              },
                              child: Text('Forgot Password',style: TextStyle(color: btn_clr )))
                           ],
                         )
                       ],
                     ),
                   ),
                 ),
               ),
                     
            
          ),
       );
  }
}

 
class UserModel {
     UserModel(
       this.status,
       this.message,
       this.user_check,
       this.contact_number
     );

      String contact_number ;
      String message ;
      String status ; 
      String user_check ;
} 