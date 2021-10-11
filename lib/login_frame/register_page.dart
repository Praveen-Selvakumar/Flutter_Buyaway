import 'dart:math';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui_demo_1/common/CustomTextButton.dart';
import 'package:ui_demo_1/common/UserLocalStore.dart';
import 'package:ui_demo_1/login_frame/login_page.dart';
import 'package:ui_demo_1/mainframe/home_page.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert';




class register_page extends StatefulWidget{
  @override
  State<StatefulWidget> createState()  => register_page_();
}

 

class register_page_  extends State<register_page>{       

       //CONTROLLERS
       final get_name  = new TextEditingController();
       final get_email  = new TextEditingController();
       final get_gender  = new TextEditingController();
       final get_number  = new TextEditingController();
       final password_con = new TextEditingController();
       final conf_password_con = new TextEditingController();

      Color btn_clr = Color(0xff1a95d1);
      GlobalKey<FormState> formkey = new GlobalKey();
      bool _obscureText = true;
      

      //PASSWORD VISIBILITY
       void _togglePasswordStatus() {
             setState(() {
             _obscureText = !_obscureText;
    });
  }     

  

Widget  getFormField(TextEditingController controller_,String str, IconData icon_,String type){    
   return Container(     
     margin: EdgeInsets.only(top: 20),
     child: TextFormField(  
       controller: controller_,                
      decoration: InputDecoration(      
        prefixIcon: Icon(icon_),       
        border: UnderlineInputBorder(),labelText: str,        
      ),
      validator: (value){
        String error = "";        
        if(type.contains("name")){
           error = "Enter user name";
        }else if(type.contains("mail")){
             error = "Enter E-mail";                   
        }else if(type.contains("gender")){
          error = "Enter Your Gender";
        }else if(type.contains("code")){
          error = "Enter your Promo Code";
        }

        if(value!.isEmpty){             
             return error;
        }else if(type.contains("mail")){
               if(!EmailValidator.validate(value)){
                 error = "Enter valid E-mail";
                 return error ;
               }
        }else{
           return null;
        }
        
      },
      style: TextStyle(fontFamily: 'Poppins'),
     ),
   );
}

Widget getNumberField(TextEditingController controller_){
   return Container(
     margin: EdgeInsets.only(top: 20),
     child: TextFormField(     controller:  controller_,
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
   );
}

Widget getPasswordField(String str,String error,TextEditingController controller_){  
  return  Container(    
    margin: EdgeInsets.only(top: 20),
    child: TextFormField(     controller:  controller_,
                              obscureText: _obscureText,
                               style: TextStyle(color: Colors.black,fontFamily: 'Poppins',fontSize: 14 ),
                               decoration: InputDecoration(prefixIcon: Icon(Icons.lock),                              
                               border: UnderlineInputBorder(),labelText: str,
                               suffixIcon: IconButton(onPressed:  _togglePasswordStatus,
                                icon: Icon(_obscureText  ?  Icons.visibility : Icons.visibility_off))
                               ), 
                              validator: (value){
                                 if(value!.isEmpty){
                                   return error;
                                 }
                                 return null;
                               }, 
                             ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : true,
        body:  SingleChildScrollView( 
         child: Align(
           alignment: Alignment.center,
           child: Container(
             padding: EdgeInsets.only(left: 20,right: 20),
             child: Theme(
                data:Theme.of(context).copyWith(
                          colorScheme: ThemeData().colorScheme.copyWith(
                          primary:Colors.grey,),),
               child: Form(
                 key: formkey,
                 child: Column(  
                     children: <Widget>[
                     SizedBox(height: 80),
                     Image.asset('assets/buyaway.png', width: 300,height: 300),
                     Text("Let's Get Started",style: TextStyle(color: Colors.black,fontSize: 18,fontFamily: 'Poppins_Bold')),
                     SizedBox(height: 10),
                     Text("Create a new account",style: TextStyle(color: Colors.grey,fontSize: 16,fontFamily: 'Poppins')),
                     
                     //FORM FIELDS
                     getFormField(get_name,"Full Name", Icons.person,"name"), 
                     getFormField(get_email,"Your Email", Icons.person,"mail"), 
                     getNumberField(get_number),
                     getFormField(get_gender,"Enter your Gender", Icons.person,"gender"),
                     getPasswordField("Enter Password","Enter Your Password", password_con),
                     getPasswordField("Re-Enter Password","Enter Your Conform Password",conf_password_con),   
                     getFormField(get_gender,"Enter Promo Code", Icons.code,"code"),
                     SizedBox(height: 40,),
                     SizedBox(
                       width: double.infinity,
                       child: ElevatedButton(
                           onPressed: (){
                              if(formkey.currentState!.validate()){
                                 //print("Validated");
                                 validate_final();
                              }else{
                                  print("Not validated");
                              }

                              },
                             child: Text("sign up",style: TextStyle(color: Colors.white, fontFamily: 'Poppins'),),
                             style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(btn_clr)),
                           ),
                     ), SizedBox(height: 10,),                
                      Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: <Widget>[
                         Text('have an account ?',style: TextStyle(color: Colors.grey ,fontFamily: 'Poppins')),
                          TextButton(onPressed: (){
                           Navigator.push(context, 
                           MaterialPageRoute(builder: (context) => login_page() ));
                          }, child: Text(" sign in", style:  TextStyle(color: Colors.blue, fontFamily: 'Poppins',fontWeight: FontWeight.bold),))        
                           ],
                     ),
                     SizedBox(
                       height: 20,
                     ),    
                   ],
                 ),
               ),
             ),
           ),
         ),        
        )
    );
  }


  void validate_final(){
      if(password_con.text.contains(conf_password_con.text)){ 
                            
                 
      }else{        
        Fluttertoast.showToast(msg: ' Passwords should be same');
      }
  }

   
  


   

}

