import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:ui_demo_1/common/search_bar.dart';
import 'dart:convert';

 import 'package:ui_demo_1/test_pack/TestModel.dart';
 import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert';
import 'package:flutter_svg/flutter_svg.dart';


class Load_Brands extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => Load_Brands_();
}


Future<List<Brands_Model>> getBrands() async{
    final String  apiUrl = "http://webbuyaway.buyaway.in/api/APIMobileBrand/MobileBrand";
    
    var data = await http.get(Uri.parse(apiUrl));

      var jsonData = json.decode(data.body);
      print(jsonData);

       List<Brands_Model> brand_list = [];
       
         for(var u in jsonData){     

          Brands_Model model = Brands_Model(
            (u["id"]).toString(), 
            u["name"], 
            u["details"],
            u["tag_line"], 
            u["logo"], 
            u["added_by"],
            u["added_date"] 
            );

          
          print(u["name"]);  
                   
      }  
      return brand_list;
}



class Load_Brands_ extends State<Load_Brands>{
      var _color = const Color(0xFFeef6f9);



  @override
  Widget build(BuildContext context) {
       return Scaffold(
      backgroundColor: _color,
       body: Container(
         margin: EdgeInsets.only(top: 30,left: 15, right: 15),
         child: Column(
           children: <Widget>[
            SizedBox(height: 40,), 
            Search_bar(inputText: "Search Product" ),
            SizedBox(height: 100,),
            Future_Builder_Cat(),  
          

           ],
         ),
       ),
    );
  }
}

 
 Widget Future_Builder_Cat() {
   return FutureBuilder(
               future: getBrands(),
               builder: (BuildContext context, AsyncSnapshot snapshot){
                  if(snapshot.data == null ){
                          return Center(
                            child: Text("Loading..."),
                          );
                       }else{                         
                          return Expanded(
                            child: Column(
                              children: <Widget>[  
                                   SizedBox(
                                     height: 200,
                                     width: double.infinity,
                                     child: load_test(snapshot))   
                                                          
                                                         
                              ],
                            ),
                          );                            
                            
                           
                       }
               });
 }

 Widget load_test(AsyncSnapshot snapshot){   
   return Expanded(
     child: ListView.builder(
        shrinkWrap: true,  
        itemCount: snapshot.data.length,
       itemBuilder: (BuildContext context, int index){
         Fluttertoast.showToast(msg: snapshot.data[index].name); 
         return SingleChildScrollView(            
           child: Text(snapshot.data[index].name),
         );
       }
       ),
   );
 }

 Widget load_View(AsyncSnapshot snapshot){    
  return Expanded(                             
          child: new GridView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,         
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
             crossAxisCount:  2,                  
           ), padding: EdgeInsets.zero,                                 
          itemCount: snapshot.data.length,
          itemBuilder: (BuildContext context, int index){ 
                   return SingleChildScrollView(
                   child: Column( 
                     mainAxisAlignment: MainAxisAlignment.center,                  
                     children: [                       
                      Stack(
                       children: [
                         Container(
                           margin: EdgeInsets.all(10),
                           child: CircleAvatar(                                              
                             radius: 30,
                             backgroundColor: Colors.blue,
                             child: CircleAvatar(   
                               backgroundColor: Colors.white,                       
                               child: Image.network(
                                 'http://webbuyaway.buyaway.in${snapshot.data[index].logo}'
                                 ,height: 30,width: 30,),
                              radius: 29.8, ),)                                                  
                         ),                                                                     
                         ]                                                   
                     ),
                    Container(
                            child: Text(snapshot.data[index].name,
                           style: TextStyle(color: Colors.black,
                            fontFamily: 'Poppins', 
                            fontSize: 11.5  , 
                            fontWeight: FontWeight.bold ),),                          
                         ),
                      
                     ],
                   ),
                 );                      
                                   }),
                              );
 }



class Brands_Model{
  

    final String  id ;  
    final String  name ;
    final String  details ;
    final String  tag_line ;
    final String  logo ;
    final String  added_by ;   
    final String  added_date ;   

 Brands_Model(     this.id,     this.name,     this.details,
     this.tag_line,    this.logo,     this.added_by ,     this.added_date 

 );

}

 