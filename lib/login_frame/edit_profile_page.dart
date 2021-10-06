import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui_demo_1/ModelClass/TotalModel.dart';
 import 'package:ui_demo_1/login_frame/change_password.dart';
import 'package:ui_demo_1/login_frame/login_page.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert';


class edit_profile_page extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => edit_profile_page_();

}


Future<TotalModel?> load_user_detail(String number) async{

  final String apiUrl = "http://webbuyaway.buyaway.in/api/APIMobileAccount/ViewProfile";
  
   final response = await http.post(Uri.parse(apiUrl), body: {
     "contact_number" : number
  });
  
      
      if(response.body !=  null) {
         Map<String, dynamic> data = new Map<String, dynamic>.from(json.decode(response.body));
         TotalModel  model = new TotalModel( 
           id: data['id'].toString() ,  name: data['name'].toString(),
           email: data['email'].toString(), contact_number: data['contact_number'].toString(),
           date_of_birth: data['date_of_birth'].toString(), gender: data['gender'].toString(),
           Address: data['Address'].toString(), joined_date: data['joined_date'].toString(),
           profile_image: data['profile_image'].toString(), status: data['status'].toString(),
            );    
         return model ;
      } else {
          return null ;
}

}

 
class edit_profile_page_ extends State<edit_profile_page>{
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: SingleChildScrollView(
       child: Container(
         margin: EdgeInsets.only(left: 20,right: 20),
         child: FutureBuilder(
           future: load_user_detail("8682065651"),
            builder: (BuildContext context, AsyncSnapshot snapshot){
           return Stack(              
              children: <Widget>[                
               Column(
               children: <Widget>[
                 Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: <Widget>[           
                    Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                       margin: EdgeInsets.only(left: 0,top: 60),
                       child:Image.asset('assets/back_btn.png',width: 25,height: 25,color: Colors.black,),
                    ),
                  ),
                  Container(         
                       margin: EdgeInsets.only(right: 0, top: 60),  
                       child: TextButton(
                         onPressed: (){
                           clearLocalData();
                         },
                         child: Text(
                           "LOG OUT",
                           style: TextStyle(fontFamily: 'Poppins',fontSize: 16,
                           color: Colors.black),),
                       ),
                     ),          
                    ],
                   ),
                   SizedBox(height: 30,),       
                              Stack(
                                children: <Widget>[
                                 Offstage(
                                 offstage: false,
                                 child: Material(                        
                                     child: ColorFiltered(
                                       child: Image.asset('assets/avatar_.png',width: 100,height: 100,),
                                       colorFilter: ColorFilter.mode(Colors.blue, BlendMode.color),                              
                                     ),
                                     elevation: 1.0,
                                     shape: CircleBorder(),
                                    clipBehavior: Clip.antiAlias,                        
                                    ),     ),
                                    CircleAvatar(
                                      radius: 50,
                                      backgroundColor: Colors.blue[100],
                                    ),
                                 Container(
                                   margin: EdgeInsets.only(left: 37.5, top: 37.5),
                                   child: Offstage(
                                   offstage: false,
                                   child: Image.asset('assets/camera.png',width: 25,height: 25,color: Colors.blue,),),
                                 ), 
                                ],                            
                              ),
                              SizedBox(height: 10,),
                              Container(decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black ),
                                    borderRadius: BorderRadius.all(Radius.circular(10))),
                                    child: Container( margin: EdgeInsets.only(left: 10, top: 4, right: 10, bottom: 4),
                                    child: Text("Edit Profile",style: TextStyle(fontFamily: 'Poppins',fontSize: 13),)) ), 
                              //TextFields
                              SizedBox(height: 20,),                                                        
                              use_textField("Edit Name",snapshot.data.name),
                              SizedBox(height: 20,),
                              use_textField("Edit mail id",snapshot.data.email), 
                              SizedBox(height: 20,),
                              use_textField("Edit phone",snapshot.data.contact_number),
                              SizedBox(height: 20,),
                              use_textField("Edit Gender",snapshot.data.gender),
                              SizedBox(height: 20,),
                              snapshot.data.Address ==  null ? 
                              use_textField("Edit Address","" ) :  use_textField("Edit Address",  snapshot.data.Address ),                               
                              SizedBox(height: 20,),
                               snapshot.data.date_of_birth ==  null ? 
                              use_textField("Edit DOB","" ) :  use_textField("Edit DOB", snapshot.data.date_of_birth ),                               
                              
                               SizedBox(height: 30,),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(onPressed: (){
                              }, child: Text("Submit")) ,
                              ),
                               SizedBox(height: 10,),
                               TextButton( onPressed: (){
                           Navigator.push(context,
                           MaterialPageRoute(builder: (context) => change_password_page()));
                          },
                            child: Text('Click here to Change Password',style: TextStyle(color: Colors.black ,fontFamily: 'Poppins_Bold')),)
                          
                          
                                 //Click here to Change Password                                                                                 
               ],
             ),            

          ],
           );}         
       ),
     ),
   ));
  }


  Widget use_textField(String str,String data){
    return TextFormField(
               controller: TextEditingController(text: data) , 
               style: TextStyle(color: Colors.black,fontFamily: 'Poppins_Bold',fontSize: 14,),
                     decoration: InputDecoration(
                     border: UnderlineInputBorder(),labelText: str,
                     labelStyle:TextStyle(color: Colors.grey,fontFamily: 'Poppins') 
                     ), 
    );
  }

  void clearLocalData() async{
    SharedPreferences preference  = await SharedPreferences.getInstance();
    preference.clear();
  }

}