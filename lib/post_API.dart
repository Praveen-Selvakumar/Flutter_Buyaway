import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert';

 import 'package:ui_demo_1/test_pack/TestModel.dart';


class View_Profile extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => View_Profile_(); 

}
String name = "";
 
Future<TestModel?> createUser() async{

  final String apiUrl = "http://webbuyaway.buyaway.in/api/APIMobileAccount/ViewProfile";

  final response = await http.post(Uri.parse(apiUrl), body: {
     "contact_number" : "8682065651"
  });

       //Print Raw value 
  /*final String responseString = response.body;
     var jsonData = json.decode(response.body);     
     print("String Data is" + responseString );

     //STEP FOUR
     Map<String, dynamic> data = new Map<String, dynamic>.from(json.decode(response.body));
     print(data['name']);
     name = data['name'].toString();*/
      
      if(response.body !=  null) {
         Map<String, dynamic> data = new Map<String, dynamic>.from(json.decode(response.body));
        TestModel model = new TestModel(
          contact_number: data['contact_number'].toString(),
          name: data['name'].toString(),
          email: data['email'].toString(),
          id:  int.parse(data['id'].toString()) );    
      return model ;
} else {
  return null ;
}

}

String get_name(){
 return name ; 
}



class View_Profile_ extends State<View_Profile>{

 TestModel model = new TestModel(contact_number: "", name: "", 
 email: "", id: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Align(
          alignment: Alignment.center,
          child: Column( 
            children: <Widget>[   
              SizedBox(height: 100,) ,                 
            ElevatedButton(onPressed: () async{
             final TestModel? testModel_ = await createUser( );           
               setState(() {               
               model = testModel_!; 
               Container(
                    child: Text("My name is "+ model.name),                  
                 );       
              });
           }, child: Text("LOGIN")),
           SizedBox(height: 80,),
           Text("My Details :  Name : ${model.name}\n"
           "Email : ${model.email}\n"
           "Id : ${model.id}\n"
           "Contact Number : ${model.contact_number}\n" )      
           
           ],
          ),
        ),
      ),
    );
  }

}

 