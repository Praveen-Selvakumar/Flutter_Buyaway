import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
 import 'package:ui_demo_1/common/search_bar.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert';
import 'package:flutter_svg/flutter_svg.dart';



class search_page extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => search_page_();
}

Future<List<CategoryModel>> load_Categories(String item_type) async{

    final String  apiUrl = "http://webbuyaway.buyaway.in/api/APIMobileCategory/CategoryList";
    
    final data = await http.post(Uri.parse(apiUrl), body: {
  });

      var jsonData = json.decode(data.body);
      print(jsonData);

       List<CategoryModel> cat_list = [];
       
        
       

      for(var u in jsonData){          
          CategoryModel model_ = CategoryModel (
              (u["id"]).toString(), u["name"], u["item_type"],
              u["icon"], u["added_by"], u["added_date"]
              );
           if(item_type == u["item_type"].toString()){
             cat_list.add(model_);
           }else if(item_type == "all"){
              cat_list.add(model_);
           }
           

          print(u["name"]);  
                   
      }  

      return cat_list; 
  
}


 class search_page_ extends State<search_page>{
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
            Future_Builder("MAN", "Mens Fashion")  ,
            SizedBox(height: 60,),
            Future_Builder("WOMEN", "Womens Fashion")  ,

           ],
         ),
       ),
    );
  }
 }

  Widget Future_Builder(String item_type,String fashion_type) {
   return FutureBuilder(
               future: load_Categories(item_type),
               builder: (BuildContext context, AsyncSnapshot snapshot){
                  if(snapshot.data == null ){
                          return Center(
                            child: Text("Loading..."),
                          );
                       }else{                         
                          return Column(
                            children: <Widget>[
                             setText(fashion_type),
                             SizedBox(
                              height:  200,
                              width:   double.infinity,
                              child:   load_View(snapshot)
                            ),
                            ],
                          );                            
                            
                           
                       }
               });
 }
 
  Widget setText(String str){
    return Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.only(left: 20),
      child: Text(str,
      style: TextStyle(color: Colors.black,
       fontSize: 16, 
       fontFamily: 'Poppins', 
       fontWeight: FontWeight.bold),),
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
                               child: SvgPicture.network(
                                 'http://webbuyaway.buyaway.in${snapshot.data[index].icon}'
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

 class CategoryModel{
  final String id; 
  final String name; 
  final String item_type; 
  final String icon; 
  final String added_by; 
  final String added_date;
    
  CategoryModel(
    this.id,
    this.name,
    this.item_type,
    this.icon,
    this.added_by,
    this.added_date,
    );

}