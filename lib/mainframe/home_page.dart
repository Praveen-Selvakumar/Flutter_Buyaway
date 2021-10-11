 
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ui_demo_1/common/search_bar.dart';
import 'package:ui_demo_1/login_frame/edit_profile_page.dart';
import 'package:ui_demo_1/mainframe/offers_page.dart';
import 'package:ui_demo_1/mainframe/search_page.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert';
import 'package:flutter_svg/flutter_svg.dart';


class home_page extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => home_page_();

}

 Future<List<Brands_Model>> get_brands_list() async{

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





class home_page_ extends State<home_page>{

      var _color = const Color(0xFFeef6f9);


  @override
  Widget build(BuildContext context) {
      return MaterialApp(
       home: Scaffold(
        backgroundColor: _color,
          body: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 0,right: 0,top: 60),             
            child: Column(
              children: <Widget>[
                 Search_bar(inputText: "Search Product" ),
                 Container(margin: EdgeInsets.only(left: 15, right: 15),
                   child: Material(                   
                       elevation: 3,
                       borderRadius: BorderRadius.circular(15.0),
                       child:  Container(
                            width: double.infinity,
                            height: 150.0,
                            decoration: BoxDecoration(
                            image: DecorationImage(
                            fit: BoxFit.cover, image: NetworkImage('http://webbuyaway.buyaway.in/branditemimage/v214300221.jpg')),
                            borderRadius: BorderRadius.all(Radius.circular(15.0)),
                            color: Colors.white,),),                            
                       ),
                     ),SizedBox(height: 20,), 
                      Title_("Category", "More Category", context),
                      Future_Builder_Cat("all", ""),
                      Title_("Popular Brands","See More",context),
                      Future_Builder_Brands()
                      


              ],
            ),
     ),
       ),       
     );
  }
}

 Widget Title_(String t1, String t2, context){
   return  Row(
              children: <Widget>[
              setText(t1)  , Spacer() , setMoreButton(t2,context),                         
                ],
                );
 }

Widget Future_Builder_Brands(){
   return FutureBuilder(
               future: get_brands_list(),
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
                                  height:300,
                                  width: double.infinity,
                                 child:load_brands(snapshot)   
                                ),                                                 
                              ],
                            ),
                          );                            
                            
                           
                       }
               });
 }   


 Widget Future_Builder_Cat(String item_type,String fashion_type) {
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
                              SizedBox(
                                height: 100,
                                width: double.infinity,
                                child:load_CatList(snapshot)   
                              )                          
                                                       
                            ],
                          );                            
                            
                           
                       }
               });
 }

Widget load_brands(AsyncSnapshot snapshot){
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
                             height: 140,
                             width: 100,
                             decoration: BoxDecoration(
                             shape: BoxShape.circle,
                              borderRadius: BorderRadius.all( Radius.circular(15) ),
                              color: Colors.white
                             ),
                             child: Text(snapshot.data[index].name),
                           )                                                                     
                         ]                                                   
                     ),
                   
                      
                     ],
                   ),
                 );                      
                   }),
            );
} 

Widget load_CatList(AsyncSnapshot snapshot) {
  return ListView.builder(  
    scrollDirection: Axis.horizontal,
    itemCount: snapshot.data.length,  
    itemBuilder: (BuildContext context, int index){
         return Container(
           margin: EdgeInsets.only(left: 20),
           child: Column(           
             children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 5 ),
                  child: CircleAvatar(                                             
                                 radius: 30,
                                 backgroundColor: Colors.blue,
                                 child: CircleAvatar(   
                                   backgroundColor: Colors.white,                       
                                   child: SvgPicture.network(
                                     'http://webbuyaway.buyaway.in${snapshot.data[index].icon}'
                                     ,height: 30,width: 30,),
                                  radius: 29.8, ),),
                ) ,SizedBox(height: 3,)     ,                                      
                                               
               Text(snapshot.data[index].name,
                             style: TextStyle(color: Colors.black,
                              fontFamily: 'Poppins', 
                              fontSize: 11.5  , 
                              fontWeight: FontWeight.bold ),),
             ],
           ),
         );
    });

}



  
 
 
//COMMON
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

Widget setMoreButton(String str,context){
    return Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.only(left: 20),
      child: TextButton( onPressed: (){
       Navigator.push(context, 
       MaterialPageRoute(builder: (context) => search_page()));           
      },
      child: Text(str,
      style: TextStyle(color: Colors.blue[400],
       fontSize: 17, 
       fontFamily: 'Poppins', 
       fontWeight: FontWeight.bold),),        
        ),
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

 