import 'package:flutter/material.dart';


class change_password_page extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => change_password_page_();

}

class change_password_page_ extends State<change_password_page>{
  bool _Is_Obcsure = true;

  @override
  Widget build(BuildContext context) {
     return Scaffold(
       body: SingleChildScrollView(
         child: Container(
           child: Container(
             margin: EdgeInsets.only(left: 20,right: 20),
             child: Column(
               children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: <Widget>[           
                  Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                     margin: EdgeInsets.only(left: 0,top: 57.5),
                     child:Image.asset('assets/back_btn.png',width: 25,height: 25,color: Colors.black,),
                  ),
                ),
                Container(         
                     margin: EdgeInsets.only(right: 0, top: 60),  
                     child: Text("LOG OUT",style: TextStyle(fontFamily: 'Poppins',fontSize: 16,color: Colors.black),),
                   ),          
                  ],
                 ),SizedBox(height: 30,),
                 Align(
                    alignment: Alignment.topLeft,
                   child: Text("Change Password",style: TextStyle(fontFamily: 'Poppins',fontSize: 14,color: Colors.black,fontWeight: FontWeight.bold),)),                          
                 SizedBox(height: 20,), password_Field("Current Password"),     
                 SizedBox(height: 20,), password_Field("New Password"),
                 SizedBox(height: 40,),
                 Container(
                   width: double.infinity, 
                   child: ElevatedButton(onPressed: (){
     
                   }, child: Text("Change",style: TextStyle(fontFamily: 'Poppins'),)),
                 )                   
               ],
             ),
           ),
         ),
       ) ,
     );
  }


 Widget password_Field(String label_){
   return TextFormField(
                   obscureText: _Is_Obcsure,
                   style: TextStyle(color: Colors.black, fontFamily: 'Poppins',fontSize: 14,fontWeight: FontWeight.bold),
                   decoration: InputDecoration(
                    labelText: label_ ,labelStyle: TextStyle(color: Colors.grey, fontFamily: 'Poppins',fontSize: 14,fontWeight: FontWeight.bold),
                      suffixIcon: IconButton(
                icon: Icon(
                  _Is_Obcsure ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _Is_Obcsure = !_Is_Obcsure;
                  });
                },
              ),                  
               )                                     
   );
 }

}